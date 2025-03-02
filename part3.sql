CREATE OR REPLACE PROCEDURE P_BOOKS_ADD (p_book_id          IN books.book_id%TYPE,
                                         p_title            IN books.title%TYPE,
                                         p_author_id        IN books.author_id%TYPE,
                                         p_borrower_id      IN books.borrower_id%TYPE,
                                         p_isbn_ten         IN books.isbn_ten%TYPE,
                                         p_isbn_thirteen    IN books.isbn_thirteen%TYPE,
                                         p_num_of_pages     IN books.num_of_pages%TYPE,
                                         p_on_loan          IN books.on_loan%TYPE,
                                         p_publication_date IN books.publication_date%TYPE,
                                         p_publisher        IN books.publisher%TYPE) 
AS
BEGIN

    --a null value in borrower_id is changed to the default of 1, who is NO_ONE
    --this is done to maintain the foreign key between BOOKS and BORROWERS
    INSERT INTO books (book_id, title, author_id, borrower_id, isbn_ten,
                       isbn_thirteen, num_of_pages, on_loan,
                       publication_date, publisher) 
               VALUES (p_book_id, p_title, p_author_id, NVL( p_borrower_id,1), p_isbn_ten,
                       p_isbn_thirteen, p_num_of_pages, p_on_loan,
                       p_publication_date, p_publisher);
    dbms_output.put_line ('Successfully inserted the book '|| p_title || ' into the database. ' );
    
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        dbms_output.put_line ('ERROR: Unique index conflict on table BOOKS.  Received error: '||SQLERRM );
    WHEN OTHERS THEN
        dbms_output.put_line ('ERROR: Unexpected insert error on BOOKS table.  Received error: '||SQLERRM );

END;
/