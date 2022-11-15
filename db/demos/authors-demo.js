import './load-env.js';
import { connection } from '../../server/orm/lcs-connection.js';
import Author from '../../server/orm/models/Author.js';

async function main() {
  try {
    await connection.sync();
    let robertParker = await Author.findByPk(5);
    console.log('Found the author:', robertParker.commonName);

    let douglasAdams = Author.build({
      firstName: 'Douglas',
      lastName: 'Adams',
      commonName: 'Douglas Adams',
    });

    await douglasAdams.save();
    console.log('Douglas Adams added to the database with id', douglasAdams.authorId);

    await douglasAdams.destroy();
    console.log('Douglas Adams removed from the database');

    await connection.close();
  } catch (error) {
    console.error('Database error:', error);
  }
}

main();
