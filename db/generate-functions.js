import { random, sample } from 'lodash-es';
import { add, formatISO } from 'date-fns';

// Current weight: overdue 1 time out of five
let overdueWeight = [false, false, false, false, true];

/**
 *
 * @returns {[Date, Date, Date]} [checkoutDate, dueDate, returnDate]
 */
export function generateDates() {
  let day = random(1, 31);
  let month = random(1, 12);
  let year = random(2010, 2021);
  let checkoutDate = new Date(`${year}-${month}-${day}`);
  let dueDate = add(checkoutDate, { weeks: 3 });
  let returnDate;
  if (overdueWeight[random(1, 5)]) {
    returnDate = add(dueDate, { days: random(1, 21) });
  } else {
    returnDate = add(dueDate, { days: random(-20, -2) });
  }

  return [formatISODate(checkoutDate), formatISODate(dueDate), formatISODate(returnDate)];
}

export function generateCheckedOut() {
  let today = new Date();
  let dueDate = add(today, { days: random(1, 20) });
  let checkedOut;
  if (overdueWeight[random(1, 5)]) {
    checkedOut = add(dueDate, { days: random(-50, -22) });
  } else {
    checkedOut = add(dueDate, { weeks: -3 });
  }
  return [formatISODate(checkedOut), formatISODate(dueDate)];
}

export function getBookInInventory(inventory) {
  let validIds = Object.entries(inventory)
    .filter(([bookId, count]) => count > 0)
    .map(([key]) => key);

  if (!validIds.length) {
    console.warn('All books checked out!', inventory);
    return [null, inventory];
  }

  let chosenId = sample(validIds);
  inventory[chosenId] = inventory[chosenId] - 1;
  return [chosenId, inventory];
}

function formatISODate(d) {
  return formatISO(d, { representation: 'date' });
}
