/* eslint-disable no-unused-expressions */
import { Book, Inventory } from '../server/orm/models/index.js';
import { expect } from 'chai';

describe('Book model', () => {
  it('Smoke Test', async () => {
    let result = await Book.sync({ logging: false });
    expect(result).to.equal(Book);
  });

  it('should query someone in the database', async () => {
    let testBook = await Book.findByPk(5, { logging: false });
    expect(testBook.title).to.equal('The Grapes of Wrath');
    expect(testBook.get('isbn')).to.equal('9780143039433');
  });

  it('should query inventory (an association)', async () => {
    let testBook = await Book.findByPk(5, { logging: false });
    expect(testBook.title).to.equal('The Grapes of Wrath');

    let inventoryRecord = await testBook.getInventory({ logging: false });
    expect(inventoryRecord).not.to.be.null;
    expect(inventoryRecord.inventory).to.be.greaterThan(1);
  });

  it('should query inventory (an association), eagerly', async () => {
    let testBook = await Book.findByPk(5, {
      include: Inventory,
    });
    expect(testBook.title).to.equal('The Grapes of Wrath');

    // console.log('testBook:', testBook);
    let inventoryRecord = testBook.Inventory;
    expect(inventoryRecord).not.to.be.null;
    expect(inventoryRecord.inventory).to.be.greaterThan(1);
  });

  it('should query authors (an assocation)', async () => {
    let testBook = await Book.findByPk(5, { logging: false });
    expect(testBook.title).to.equal('The Grapes of Wrath');

    /** @type {Author[]} */
    let testBookAuthors = await testBook.getAuthors({ logging: false });
    expect(testBookAuthors.length).to.be.greaterThan(0);

    let firstAuthor = testBookAuthors[0];
    expect(firstAuthor.lastName).to.equal('Steinbeck');
  });
});
