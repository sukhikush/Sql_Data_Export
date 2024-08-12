require('dotenv').config()
const { queryStreamer } = require('./sql-query-stream')
const fs = require('fs')
const csv = require('fast-csv')
const { Transform } = require('stream')
const { cloneDeep, isEmpty } = require('lodash')
const winston = require('winston')

// const dataBaseConfig = {
//   username: "dauser",
//   host: "34.72.0.216",
//   database: "da-db",
//   password: "X8bOqV|ds?\\IHr@{",
//   port: 5432,
// };

const dataBaseConfig = {
  username: process.env.username,
  host: process.env.host,
  database: process.env.database,
  password: process.env.password,
  port: process.env.port
}

console.log(dataBaseConfig)

let data = {
  logger: winston.createLogger({
    transports: [new winston.transports.Console()],
    format: winston.format.combine(
      winston.format.label({
        label: 'packageName'
      }),
      winston.format.timestamp({
        format: 'YYYY-MM-DD HH:mm:ss'
      }),
      winston.format.errors({ stack: true }),
      winston.format.splat(),
      winston.format.json(),
      winston.format.printf(info => {
        let logStructure = `${info.level.toUpperCase()} - ${[
          info.timestamp
        ]} - `

        logStructure += `${info.message}`

        return logStructure
      })
    )
  })
}

function getWriteStream (fileLocation) {
  const writeStream = fs.createWriteStream(fileLocation)
  return writeStream
}

function formatExportData (data) {
  try {
    let string_data = JSON.stringify(data)
    string_data = string_data.replace(/\\n/g, ' ')
    string_data = string_data.replace(/\\r/g, ' ')
    let jsonData = JSON.parse(string_data)

    // console.log(typeof jsonData.technology, jsonData.technology)
    //Account_aliasName - Normalizeing it to array format
    if (typeof jsonData.aliasName === 'object')
      jsonData.aliasName = Object.keys(jsonData.aliasName)
    if (typeof jsonData.verifiedData === 'object')
      jsonData.verifiedData = JSON.stringify(jsonData.verifiedData)

    if (jsonData.technology) {
      jsonData.technology = [
        ...jsonData.technology.filter(item => item !== 'null')
      ]
    }

    if (jsonData.tags) {
      jsonData.tags = [...jsonData.tags.filter(item => item !== 'null')]
    }

    return jsonData
  } catch (e) {
    console.log('Error while formatting', e.message)
    console.log('data', JSON.stringify(data, null, ' '))
  }
}

function startDownloadProcess ({ fileLocation, sqlQuery, logger }) {
  return new Promise((resolve, reject) => {
    const sqlArgs = []
    let countRawOfOutputFile = 0

    const writableStream = getWriteStream(fileLocation)
    const output = csv.format({
      headers: true,
      objectMode: true
    })

    const dataFormatter = new Transform({
      objectMode: true,
      transform: (_data, encoding, callback) => {
        let data = cloneDeep(_data)
        countRawOfOutputFile += 1

        if (countRawOfOutputFile % 10000 === 0) {
          console.log(countRawOfOutputFile)
        }

        data = formatExportData(data)

        if (isEmpty(data))
          logger.debug(
            `[DOWNLOAD_SERVICE] :: Row data is Empty. rowNo: ${countRawOfOutputFile}, rowData: ${JSON.stringify(
              _data
            )}, formattedRowData: ${JSON.stringify(data)}`
          )

        dataFormatter.push(data)
        callback()
      }
    })

    queryStreamer(dataBaseConfig, sqlQuery, sqlArgs, logger).then(
      readableStream => {
        readableStream.pipe(dataFormatter).pipe(output).pipe(writableStream)

        readableStream.on('error', error => {
          logger.error('Readable Stream - Error')
          return reject(error)
        })
      }
    )

    dataFormatter.on('error', error => {
      logger.error('Data Formatter - Error')
      return reject(error)
    })

    output.on('error', error => {
      logger.error('Output - Error')
      return reject(error)
    })

    writableStream.on('error', error => {
      logger.error('Writable Stream - Error')
      return reject(error)
    })

    writableStream.on('finish', () => {
      logger.info('Writable Stream - Finish')
      resolve({ totalRow: countRawOfOutputFile })
    })

    writableStream.on('close', () => {
      logger.info('Writable Stream - Close')
    })
  })
}

;(async data => {
  var offset = 1 * 810000
  data.fileLocation = `./csv_data/Account_Master_Tech_Data.csv`

  //Not Verfied Account Master data for 50+ employees... Total Data count - 10,01,461

  data.sqlQuery = `Select * from "Technologies";`

  data.logger.info('Staring Downloading Process for...')
  startDownloadProcess(data).then(cnt => {
    data.logger.info(`Total Records - ${cnt.totalRow}`)
  })
})(data)
