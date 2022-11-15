import { DataTypes } from 'sequelize';
import { connection } from '../lcs-connection.js';

const Patron = connection.define('Patron', {
  patronId: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  firstName: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  lastName: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  dateOfBirth: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  email: DataTypes.STRING,
  phoneNumber: DataTypes.STRING,
  city: DataTypes.STRING,
  province: DataTypes.STRING,
  postalCode: DataTypes.STRING,
});

export default Patron;
