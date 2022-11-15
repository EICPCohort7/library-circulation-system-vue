import { DataTypes } from 'sequelize';
import { connection } from '../lcs-connection.js';

// The name of the model should be a singluar version of the name of the table
// e.g. The model is Book which connects to the table "books"
const Book = connection.define('Book', {
  bookId: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  title: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  publishYear: DataTypes.INTEGER,
  isbn: DataTypes.STRING,
  notes: DataTypes.STRING,
});

export default Book;
