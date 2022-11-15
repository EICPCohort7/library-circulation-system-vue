import { DataTypes } from 'sequelize';
import { connection } from '../lcs-connection.js';

const Author = connection.define('Author', {
  authorId: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  commonName: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  firstName: DataTypes.STRING,
  lastName: DataTypes.STRING,
});

export default Author;
