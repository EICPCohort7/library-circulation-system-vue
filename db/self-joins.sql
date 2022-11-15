-- Self-join, just ids
SELECT
  c.series_name,
  c.current_book_id AS book,
  c.next_book_id AS next_book,
  n.next_book_id AS following_book
FROM
  book_series c
  LEFT JOIN book_series n ON c.next_book_id = n.current_book_id;

-- Self-join with titles
SELECT
  c.series_name,
  b_current.title AS current_title,
  b_next.title AS next_title,
  b_following.title AS following_title
FROM
  book_series c
  LEFT JOIN book_series n ON c.next_book_id = n.current_book_id
  JOIN books b_current ON c.current_book_id = b_current.book_id
  LEFT JOIN books b_next ON c.next_book_id = b_next.book_id
  LEFT JOIN books b_following ON n.next_book_id = b_following.book_id;