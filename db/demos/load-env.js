import * as dotenv from 'dotenv';
import chalk from 'chalk';
import { fileURLToPath } from 'url';
import { dirname } from 'path';
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// TODO: If you re-use this, change this to the name of your project's directory
// e.g. 'course-manager-full-stack'
const root = 'library-circulation-system';
const rootRE = new RegExp(`(.*/${root})`);
let results = rootRE.exec(__dirname);

if (!results) throw Error('Could not find .env file');
let envDir = results[0];

let dotEnvResults = dotenv.config({ path: envDir + '/.env' });

if (dotEnvResults.error) {
  if (dotEnvResults.error.code === 'ENOENT') {
    console.error(
      chalk.red.bold(
        '***** ERROR: Please create a .env file with the appropriate information! *****'
      )
    );
  }
  throw dotEnvResults.error;
}
