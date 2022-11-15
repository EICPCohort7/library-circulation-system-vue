// Just successfully connect to the database.
import { Sequelize } from 'sequelize';

// protocol://user:password@host:port/schema
let connectionString = 'mysql://root:root1234@localhost:3306/books';

async function connectToDatabase() {
  let connection = new Sequelize(connectionString);
  try {
    await connection.authenticate();
    console.log('Successful connection!');
    await connection.close();
  } catch (error) {
    console.error('Database problem:', error);
  }
}

connectToDatabase();
