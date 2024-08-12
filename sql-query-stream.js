/* eslint-disable no-console */
const { Pool } = require("pg");
const QueryStream = require("pg-query-stream");

async function connectDb(config) {
  try {
    const dbConfig = {
      host: config.host,
      user: config.username,
      port: config.port,
      database: config.database,
      password: config.password,
      max: 10,
      min: 0,
      idleTimeoutMillis: 10,
      log: (messages) => {
        console.log(messages);
      },
      allowExitOnIdle: true,
    };

    const pool = new Pool(dbConfig);

    const connection = await pool.connect();
    return connection;
  } catch (error) {
    error.code = "MASTER_DB_CONNECTION_ERROR";
    const connection = {};
    connection.error = error;
    return connection;
  }
}

function getStreamyQuery(sql, param) {
  return new QueryStream(sql, param);
}

async function queryStreamer(_config, sql, sqlArgs = [], logger) {
  logger.info("[QUERY_STREAMER] :: [DB_CONNECTION] : Connecting Client");

  const connection = await connectDb(_config);

  if (connection.error) {
    logger.info(
      "[QUERY_STREAMER] :: [DB_CONNECTION] : Client Connection Error"
    );
    logger.error(connection.error);
    throw connection.error;
  }
  logger.info(
    "[QUERY_STREAMER] :: [DB_CONNECTION] : Client Connected Successfully"
  );

  const streamyQuery = getStreamyQuery(sql, sqlArgs);

  logger.debug(
    `[QUERY_STREAMER] :: Create stream for read data form DB. sqlQuery: ${sql}`
  );

  const dataProducerStream = connection.query(streamyQuery);

  dataProducerStream.on("end", () => {
    logger.info("[QUERY_STREAMER] :: [DATA_PRODUCER_STREAM] : Stream Ended");
    connection.release();
  });

  return dataProducerStream;
}

module.exports = {
  queryStreamer,
};
