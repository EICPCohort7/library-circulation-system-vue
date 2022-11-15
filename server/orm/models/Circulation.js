import { DataTypes } from 'sequelize';
import { connection } from '../lcs-connection.js';

const Circulation = connection.define(
  'Circulation',
  {
    circulationId: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    bookId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    patronId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    checkoutDate: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    dueDate: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    returnDate: DataTypes.DATE,
  },
  {
    freezeTableName: true,
  }
);

export default Circulation;
