import { DataTypes } from 'sequelize';
import { connection } from '../lcs-connection.js';

let BooksAuthors = connection.define(
  'BooksAuthors',
  {
    bookAuthorId: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    bookId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    authorId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  },
  { tableName: 'books_authors' }
);

export default BooksAuthors;
