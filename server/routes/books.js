import express from 'express';
import { Book } from '../orm/models/index.js';
import { Op, ValidationError } from 'sequelize';
let router = express.Router();

function handleError(res, error) {
  return res.status(500).send('Book endpoint error:', error.message);
}

/**
 * Most RESTful APIs have these endpoints for their resources
 * GET /books -> Returns all books
 * GET /books/{bookId} -> Returns the book with the id {bookId}
 * GET /books/search?title=Gatsby OR /books?title=Gatsby -> Search on books for field=value combos
 *    Maybe case insensitive, maybe partial matches
 * POST /books -> Add a book
 * PATCH /books/{bookId} -> Partially update the book with the id {bookId}
 * PUT /books/{bookId} -> Overwrite the book with the id {bookId}
 * DELETE /books/{bookId} -> Delete (or similar) the book with the id {bookId}
 *
 * @see https://github.com/typicode/json-server#routes
 * Has several good examples of typical RESTful endpoints beyond the above
 */

router.get('/', async (req, res) => {
  try {
    return res.json(await Book.findAll());
  } catch (error) {
    handleError(res, error);
  }
});

// Specify a parameter on a route with a colon ":"
// router.get('/foo/:bar') bar is now a parameter available as req.params.bar
// Control the parameter pattern with a regular expression /:foo([a-z]{1,3})
// Params ALWAYS come through as Strings
router.get('/:bookId([0-9]+)', async (req, res) => {
  try {
    let bookId = req.params.bookId;
    let book = await Book.findByPk(bookId);
    if (book) return res.json(book);

    return res.status(404).send(`Book ID ${bookId} not found`);
  } catch (error) {
    handleError(res, error);
  }
});

// This should probably go into a controller(like) object
router.get('/search', async (req, res) => {
  /** @see https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams */
  console.log('Query string:', req.query);
  let criteria = new URLSearchParams(req.query);
  let title = criteria.get('title');
  let titleLike = criteria.get('titleLike');

  // Partial implementation
  try {
    // Exact match
    if (title) {
      let results = await Book.findAll({
        where: {
          // implicitly title:title
          title,
        },
      });
      if (results.length) return res.json(results);
      // return res.status(404).send(`No books with title ${title} found.`);
      return res.status(404).json([]);
    }

    // Or should we make partial matches the default?
    if (titleLike) {
      let results = await Book.findAll({
        where: {
          title: {
            [Op.substring]: titleLike,
          },
        },
      });
      if (results.length) return res.json(results);
      // return res.status(404).send(`No books with title ${titleLike} found.`);
      return res.status(404).json([]);
    }
  } catch (error) {
    handleError(res, error);
  }

  // 404? 501? 400 for a Bad Request
  return res.status(400).json([]);
});

router.post('/', async (req, res) => {
  try {
  // Note use of build() and not create()
  // Allows for local validations
    let bookToBeAdded = Book.build({ ...req.body });

    // result is either bookToBeAdded OR an error
    let result = await bookToBeAdded.save();
    if (result instanceof ValidationError) {
      console.error('Validation failed:', result);
      throw result;
    }
    return res.status(201).json(bookToBeAdded);
  } catch (error) {
    // Might want more robust error handling here
    handleError(res, error);
  }
});

router.patch('/:bookId([0-9]+)', async (req, res) => {
  try {
    let book = await Book.findByPk(req.params.bookId);
    if (!book) return res.status(404).send(`Book ID ${req.params.bookId} not found`);

    await book.update({ ...req.body });
    console.log(`Book id ${req.params.bookId} updated`);
    return res.json(book);
  } catch (error) {
    handleError(res, error);
  }
});

router.put('/:bookId([0-9]+)', async (req, res) => {
  try {
    let book = await Book.findByPk(req.params.bookId);
    if (!book) return res.status(404).send(`Book ID ${req.params.bookId} not found`);

    // PUT _replaces_ the record, whereas PATCH merges the record
    book.publishYear = req.body.publishYear || null;
    book.isbn = req.body.isbn || null;
    book.notes = req.body.notes || null;
    book.title = req.body.title || book.title;

    await book.update({ ...req.body });
    console.log(`Book id ${req.params.bookId} updated`);
    return res.json(book);
  } catch (error) {
    handleError(res, error);
  }
});

router.delete('/:bookId([0-9]+)', async (req, res) => {
  try {
    let book = await Book.findByPk(req.params.bookId);
    if (!book) return res.status(404).send(`Book ID ${req.params.bookId} not found`);

    await book.destroy();
    console.log(`Book ${req.params.bookId} deleted.`);
    return res.status(204).send('');

    /*
    if (results === 1) {
      console.log(`Book ${req.params.bookId} deleted.`);
      return res.status(204);
    } else if (results === 0) {
      console.log(`Book ${req.params.bookId} NOT deleted, for some reason.`);
      return res.status(500).send(`Book ${req.params.bookId} not deleted for some reason`);
    } else if (results > 1) {
      console.error('Multiple books deleted, this should not happen.');
      throw new Error('Multiple books deleted, this should not happen.');
    }
    */
  } catch (error) {
    handleError(res, error);
  }
});

export default router;
