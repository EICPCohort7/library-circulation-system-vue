import { getBookInInventory } from '../db/generate-functions.js';

describe('JEST: generate-functions.js', () => {
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
    expect(validIds).toContain(chosenId);
  });

  it('should exhaust inventory', () => {
    // Exhausted inventory provokes a console.warn, these two lines suppress it
    let originalWarn = console.warn;
    console.warn = jest.fn();

    let inventoryCount = Object.values(inventory).reduce((sum, current) => sum + current, 0);

    for (let x = 0; x < inventoryCount; x++) {
      let [_chosenId, updatedInventory] = getBookInInventory(inventory);
      inventory = updatedInventory;
    }

    let [chosenId] = getBookInInventory(inventory);
    expect(chosenId).toBeNull();

    // Restore console.warn
    console.warn = originalWarn;
  });

  it('should never return a book that has zero inventory', () => {
    let originalWarn = console.warn;
    console.warn = jest.fn();
    let inventory = {
      1: 10,
      2: 0,
    };
    let inventoryCount = Object.values(inventory).reduce((sum, current) => sum + current, 0);

    for (let x = 0; x < inventoryCount; x++) {
      let [chosenId, updatedInventory] = getBookInInventory(inventory);
      expect(chosenId).not.toBe(2);
      inventory = updatedInventory;
    }

    let [chosenId] = getBookInInventory(inventory);
    expect(chosenId).toBeNull();

    console.warn = originalWarn;
  });
});
