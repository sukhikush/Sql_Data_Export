
process.env.GOOGLE_APPLICATION_CREDENTIALS='./localaccess.json'
const csv = require('fast-csv');
const { serializeError } = require('serialize-error');
const { Storage } = require('@google-cloud/storage');
const { Transform, Writable } = require('stream');
const storage = new Storage();

// csvReader
const csvReader = storage
.bucket('da-local-files')
.file('inclusionExport/inclusion-export-test.csv')
.createReadStream();

// csvWriter
const csvWriter = storage
.bucket('da-local-files')
.file('inclusionExport/inclusion-export-test-local-testing-result.csv')
.createWriteStream();

// csvParser
const csvParser = csv.parse({
    headers: true,
    objectMode: true,
    highWaterMark: 1,
  });

// csvFormatter
const csvFormatter = csv.format({
    objectMode: true,
    headers: true,
  });

// csvTransformer
const transformer = new Transform({
    objectMode: true,
    highWaterMark: 1,
    transform: async (data, encoding, callback) => {
      try {
        let writable = new Writable({
            objectMode: true,
            highWaterMark: 1,
            write: function(chunk, encoding, callback) {
              csvFormatter.push(data);
              callback();
            }
        });
        writable.write(data);
        callback(null, data);
      } catch (err) {
        callback(err);
      }
    },
  });

// error loggers
csvReader.on('error', (error) => {
    let e = serializeError(error);
    console.log(`csvReader: ERROR: ${JSON.stringify(e)}`);
});
csvParser.on('error', (error) => {
    let e = serializeError(error);
    console.log(`csvParser: ERROR: ${JSON.stringify(e)}`);
});
transformer.on('error', (error) => {
    let e = serializeError(error);
    console.log(`transformer: ERROR: ${JSON.stringify(e)}`);
});
csvFormatter.on('error', (error) => {
    let e = serializeError(error);
    console.log(`csvFormatter: ERROR: ${JSON.stringify(e)}`);
});
csvWriter.on('error', (error) => {
    let e = serializeError(error);
    console.log(`csvWriter: ERROR: ${JSON.stringify(e)}`);
});

// data loggers
transformer.on('data', (data) => {
    console.log(`transformer: data: ${JSON.stringify(data)}`);
});
csvFormatter.on('data', (data) => {
    console.log(`csvFormatter: data: ${JSON.stringify(data)}`);
});



csvReader.pipe(csvParser).pipe(transformer)
csvFormatter.pipe(csvWriter);
