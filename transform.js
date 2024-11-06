const { Pool } = require("pg");
const QueryStream = require("pg-query-stream");
const pLimit = require("p-limit");
const { error } = require("winston");

const config = {
  db: {
    user: "postgres",
    host: "localhost",
    database: "reports",
    password: "postgres",
    port: 5431,
    max: 20, // Maximum number of clients in the pool
  },
  query: "SELECT * FROM temp_user_reports", // SQL query to stream data
  tableName: "temp_user_reports", // Name of the table to update
  updateColumns: ["user_email"], // Columns to update in the table
  batchSize: 10000, // Increased size of update buffer
  concurrencyLimit: 500,
};

const pool = new Pool(config.db);
const limit = pLimit(config.concurrencyLimit);

async function streamAndUpdateData(transformFunction) {
  console.time("s");
  try {
    const streamClient = await pool.connect();

    // Start streaming data
    const query = new QueryStream(config.query);
    const stream = streamClient.query(query);

    let updateQueries = [];

    stream.on("data", async (row) => {
      if (updateQueries.length >= config.batchSize) {
        console.log("Pausing stream");
        stream.pause();
        await updateRows(updateQueries);
        updateQueries = [];
        console.log("Resuming stream");
        stream.resume();
      }
      row = transformFunction(row);
      const updateQuery = generateQuery(
        row.id,
        row,
        config.updateColumns,
        config.tableName
      );
      updateQueries.push(updateQuery);
    });

    stream.on("end", async () => {
      // Final flush of any remaining updates
      if (updateQueries.length > 0) {
        await updateRows(updateQueries);
      }
      console.log("Streaming and updating completed");
      streamClient.release();
      pool.end()
      console.timeEnd("s");
    });

    stream.on("error", (err) => {
      console.error("Stream error:", err);
      streamClient.release();
      pool.end();

    });
  } catch (error) {
    console.error("Error streaming data:", error);
    await pool.end();
  }
}

async function updateRows(queries) {
  const client = await pool.connect();
  await client.query("BEGIN"); // Start transaction

  const updatePromises = queries.map((q) =>{
    return limit(async () => {
      try {
        await client.query(q.queryText, q.values);
      } catch (error) {
        console.error("Error updating row:", error);
      }
    });
  });

  await Promise.allSettled(updatePromises);
  await client.query("COMMIT"); // Commit transaction
  client.release();
}

function generateQuery(id, row, columns, tableName) {
  const setClause = columns
    .map((col, idx) => `${col} = $${idx + 1}`)
    .join(", ");

  const values = columns.map((col) => row[col]);
  values.push(id); // Add id as the last parameter
  const queryText = `UPDATE ${tableName} SET ${setClause} WHERE id = $${values.length}`;
  return { queryText, values };
}

function exampleTransformFunction(row) {
  row["user_email"] = "blabla@nexsales.com";
  return row;
}

streamAndUpdateData(exampleTransformFunction);
