import { getBookInInventory } from '../db/generate-functions.js';
import { expect } from 'chai';

describe('generate-circulation.js', () => {
  let inventory = {};
  beforeEach(() => {
    inventory = {
      1: 5,
      2: 3,
    };
  });

  it('Smoke test', () => {
    getBookInInventory(inventory);
  });

  it('should return a valid chosen id', () => {
    let validIds = Object.keys(inventory);
    let [chosenId] = getBookInInventory(inventory);
    expect(validIds).to.contain(chosenId);
  });
});
