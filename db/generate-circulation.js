import { random } from 'lodash-es';
import meow from 'meow';
import { generateCheckedOut, generateDates, getBookInInventory } from './generate-functions.js';

const patronUpperBound = 48;
const bookUpperBound = 25;

const cli = meow(
  `
Usage 
  $ generate-circulation <resolved> <open>

  <resolved>  Number of resolved (returned) circulation records
  <open>      Number of open (not yet returned) circulation records
`,
  { importMeta: import.meta }
);

let [resolvedCount, openCount] = cli.input;

resolvedCount = resolvedCount || 100;
openCount = openCount || 25;

let inventory = {
  1: 4,
  2: 3,
  3: 9,
  4: 8,
  5: 9,
  6: 2,
  7: 5,
  8: 6,
  9: 4,
  10: 6,
  11: 9,
  12: 8,
  13: 5,
  14: 4,
  15: 5,
  16: 4,
  17: 6,
  18: 7,
  19: 6,
  20: 1,
  21: 9,
  22: 5,
  23: 7,
  24: 9,
  25: 3,
};

let statements = [];
for (let x = 0; x < resolvedCount; x++) {
  let [checkout, due, returned] = generateDates();
  let patron = random(1, patronUpperBound);
  let book = random(1, bookUpperBound);
  let statement = `(${book}, ${patron}, '${checkout}', '${due}', '${returned}')`;
  statements.push(statement);
}

for (let x = 0; x < openCount; x++) {
  let [checkout, due] = generateCheckedOut();
  let patron = random(1, patronUpperBound);
  let [book, updatedInventory] = getBookInInventory(inventory);
  inventory = updatedInventory;
  let statement = `(${book}, ${patron}, '${checkout}', '${due}', NULL)`;
  statements.push(statement);
}

console.log(statements.join(',\n'));
