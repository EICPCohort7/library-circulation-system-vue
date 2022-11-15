import './load-env.js';
import { connection } from '../../server/orm/lcs-connection.js';
import Book from '../../server/orm/models/Book.js';

async function main() {
  try {
    await connection.sync();
    console.log('Successful connection');
    let books = await Book.findAll();
    for (let book of books) {
      console.log(book.title);
    }
    await connection.close();
  } catch (error) {
    console.error('Sequelize error:', error);
  }
}

main();
