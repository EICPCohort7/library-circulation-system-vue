import Author from './Author.js';
import Book from './Book.js';
import BooksAuthors from './BooksAuthors.js';
import Circulation from './Circulation.js';
import Inventory from './Inventory.js';
import Patron from './Patron.js';

Book.hasOne(Inventory, { foreignKey: 'bookId' });
Inventory.belongsTo(Book, { foreignKey: 'bookId' });

Author.belongsToMany(Book, {
  foreignKey: 'authorId',
  through: BooksAuthors,
});

Book.belongsToMany(Author, {
  foreignKey: 'bookId',
  through: BooksAuthors,
});

export { Author, Book, Circulation, Inventory, Patron };
