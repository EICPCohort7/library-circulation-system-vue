import fs from 'node:fs';
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import { Sequelize } from 'sequelize';
import { getConnectionConfig } from '../app-config.js';
import chalk from 'chalk';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

let { user, password, host, port, schema, useSSL } = getConnectionConfig();

let connectionString = `mysql://${user}:${password}@${host}:${port}/${schema}`;

let sequelizeConfig = {
  logging: (...msg) => console.log(chalk.gray(msg.slice(0, -1))),
  logQueryParameters: true,
  define: {
    timestamps: false,
    underscored: true,
  },
};

if (useSSL === 'true') {
  sequelizeConfig.dialect = 'mysql';
  sequelizeConfig.dialectOptions = {
    ssl: {
      rejectUnauthorized: true,
      ca: [fs.readFileSync(__dirname + '/DigiCertGlobalRootCA.crt.pem')],
    },
  };
}

export const connection = new Sequelize(connectionString, sequelizeConfig);
