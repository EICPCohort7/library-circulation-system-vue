/* eslint-disable no-unused-vars */
import './load-env.js';
import { Op } from 'sequelize';
import { connection } from '../../server/orm/lcs-connection.js';
import { Patron, Circulation } from '../../server/orm/models/index.js';

async function queryPatrons() {
  try {
    await connection.sync({ logging: false });
    let patrons = await Patron.findAll({
      where: {
        province: 'CA',
        lastName: 'Howe',
      },
    });
    for (let patron of patrons) {
      console.log(`${patron.firstName} ${patron.lastName} ${patron.province}`);
    }
  } catch (error) {
    console.error('Database issue:', error);
  } finally {
    connection.close();
  }
}

async function queryPatronsIn() {
  try {
    await connection.sync({ logging: false });
    let patrons = await Patron.findAll({
      where: {
        province: {
          [Op.in]: ['CA', 'BC', 'ID', 'OR', 'PA'],
        },
      },
    });
    for (let patron of patrons) {
      console.log(`${patron.firstName} ${patron.lastName} ${patron.province}`);
    }
  } catch (error) {
    console.error('Database issue:', error);
  } finally {
    connection.close();
  }
}

async function queryBooks() {
  try {
    await connection.sync({ logging: false });
    let records = await Circulation.findAll({
      order: ['bookId'],
    });
    for (let record of records) {
      console.log(`${record.bookId}`);
    }
  } catch (error) {
    console.error('Database issue:', error);
  } finally {
    connection.close();
  }
}

async function countingBooks() {
  try {
    await connection.sync({ logging: false });

    // No book_ids, just counts
    // let circulationCount = await Circulation.count({ group: 'book_id' });

    let { count, rows } = await Circulation.findAndCountAll({ group: 'book_id' });
    console.log('Count:', count);
  } catch (error) {
    console.error('Database issue:', error);
  } finally {
    connection.close();
  }
}

queryPatrons();
// queryPatronsIn();
// queryBooks();
// countingBooks();
