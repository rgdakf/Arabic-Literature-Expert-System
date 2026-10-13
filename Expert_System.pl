% =====================================================================
% Project Title: Arabic Literature Recommendation System
%
% * Problem Description: 
% This system is a Prolog-based expert system that recommends Arabic 
% literature and novels. It uses logical inference to match reader 
% preferences with a curated knowledge base of books.
%
% * Assumptions:
% - All book titles, authors, and attributes are written in lowercase 
%   with underscores (e.g., men_in_the_sun) to match Prolog syntax.
% - The knowledge base assumes exact matches for queries.
%
% * Knowledge Base Explanation:
% 1. author(Book, Author): Links a book to its specific writer.
% 2. genre(Book, Type): Defines the literary category (e.g., novel, short_story).
% 3. book_length(Book, Size): Categorizes the book's length (short, medium, long).
% 4. theme(Book, Topic): Identifies the main subject or message of the book.
% 5. language_style(Book, Style): Describes the complexity of the Arabic language used.
% =====================================================================

% 1. Author Facts 
author(men_in_the_sun, ghassan_kanafani).
author(ya_sahibi_assijn, ayman_alotoom).
author(granada_trilogy, radwa_ashour).
author(kharait_altih, bothayna_alessa).
author(alaswad_yalik_bik, ahlam_mosteghanemi).
author(tisat_ashar, ayman_alotoom).
author(abqariyat_omar, al_aqqad).
author(sad_oranges_land, ghassan_kanafani).

% 2. Genre Facts
genre(men_in_the_sun, novel).
genre(ya_sahibi_assijn, biography).
genre(granada_trilogy, historical).
genre(kharait_altih, novel).
genre(alaswad_yalik_bik, novel).
genre(tisat_ashar, novel).
genre(abqariyat_omar, book).
genre(sad_oranges_land, short_story).

% 3. Length Facts
book_length(men_in_the_sun, short).
book_length(ya_sahibi_assijn, long).
book_length(granada_trilogy, long).
book_length(kharait_altih, long).
book_length(alaswad_yalik_bik, medium).
book_length(tisat_ashar, medium).
book_length(abqariyat_omar, medium).
book_length(sad_oranges_land, short).

% 4. Theme Facts
theme(men_in_the_sun, refugee_struggle).
theme(ya_sahibi_assijn, prison_literature).
theme(granada_trilogy, history).
theme(kharait_altih, social_issues).
theme(alaswad_yalik_bik, romance).
theme(tisat_ashar, philosophical).
theme(abqariyat_omar, biography).
theme(sad_oranges_land, refugee_struggle).

% 5. Language Style Facts
language_style(men_in_the_sun, eloquent_fusha).
language_style(ya_sahibi_assijn, eloquent_fusha).
language_style(granada_trilogy, poetic_fusha).
language_style(kharait_altih, simple_fusha).
language_style(alaswad_yalik_bik, poetic_fusha).
language_style(tisat_ashar, eloquent_fusha).
language_style(abqariyat_omar, classical_fusha).
language_style(sad_oranges_land, simple_fusha).


% =====================================================================
% *  Inference Rules
% =====================================================================

% 1. Recommend book by genre and theme
rec_genre_theme(Book, Genre, Theme) :-
    genre(Book, Genre),
    theme(Book, Theme).


% 2. Check if a book is easy for beginners (short and simple fusha)
is_beginner_book(Book) :-
    book_length(Book, short),
    language_style(Book, simple_fusha).


% 3. Quick read by a specific author
quick_author_read(Book, Author) :-
    author(Book, Author),
    book_length(Book, short).


% 4. Suggest another book by the same author
same_author_book(Book1, Book2) :-
    author(Book1, Author),
    author(Book2, Author),
    Book1 \= Book2.


% 5. Check if it's a history/heritage book
is_historical(Book) :-
    genre(Book, historical).
is_historical(Book) :-
    theme(Book, history).
is_historical(Book) :-
    theme(Book, refugee_struggle).


% 6. Books that need advanced Arabic skills
advanced_arabic(Book) :-
    (language_style(Book, classical_fusha) ; language_style(Book, eloquent_fusha)),
    (book_length(Book, medium) ; book_length(Book, long)).


% 7. Perfect match based on 3 user preferences
match_book(Book, Genre, Length, Style) :-
    genre(Book, Genre),
    book_length(Book, Length),
    language_style(Book, Style).


% 8. Check if an author writes about a specific theme
author_has_theme(Author, Theme) :-
    author(Book, Author),
    theme(Book, Theme).


% 9. List Processing & Recursion: Get books by a specific author from a given list
get_author_books(_, [], []).

get_author_books(Author, [HeadBook|TailBooks], [HeadBook|FilteredTail]) :-
    author(HeadBook, Author),
    get_author_books(Author, TailBooks, FilteredTail).

get_author_books(Author, [HeadBook|TailBooks], FilteredTail) :-
    \+ author(HeadBook, Author),
    get_author_books(Author, TailBooks, FilteredTail).


% 10. Recursion: check if all books in a list are in simple fusha
check_all_simple([]).
check_all_simple([HeadBook|TailBooks]) :-
    language_style(HeadBook, simple_fusha),
    check_all_simple(TailBooks).


% 11. Recursion: Filter a list of books to only include short books
filter_short_books([], []).
filter_short_books([HeadBook|TailBooks], [HeadBook|FilteredTail]) :-
    book_length(HeadBook, short),
    filter_short_books(TailBooks, FilteredTail).
filter_short_books([HeadBook|TailBooks], FilteredTail) :-
    \+ book_length(HeadBook, short),
    filter_short_books(TailBooks, FilteredTail).


% =====================================================================
% *  Sample Queries and Expected Outputs
% =====================================================================

% 1. ?- rec_genre_theme(Book, novel, romance).
%    Expected: Book = alaswad_yalik_bik.

% 2. ?- is_beginner_book(sad_oranges_land).
%    Expected: true.

% 3. ?- is_beginner_book(men_in_the_sun).
%    Expected: false.

% 4. ?- quick_author_read(Book, ghassan_kanafani).
%    Expected: Book = men_in_the_sun ;
%              Book = sad_oranges_land.

% 5. ?- same_author_book(men_in_the_sun, Book2).
%    Expected: Book2 = sad_oranges_land.

% 6. ?- is_historical(granada_trilogy).
%    Expected: true.

% 7. ?- is_historical(men_in_the_sun).
%    Expected: true.  (matched via theme = refugee_struggle)

% 8. ?- advanced_arabic(ya_sahibi_assijn).
%    Expected: true.  (eloquent_fusha and long)

% 9. ?- advanced_arabic(kharait_altih).
%    Expected: false.  (simple_fusha fails the style condition)

% 10. ?- match_book(Book, novel, medium, eloquent_fusha).
%     Expected: Book = tisat_ashar.

% 11. ?- author_has_theme(ayman_alotoom, Theme).
%     Expected: Theme = prison_literature ;
%               Theme = philosophical.

% 12. ?- get_author_books(ayman_alotoom, [ya_sahibi_assijn, men_in_the_sun, tisat_ashar], List).
% Expected Output: List = [ya_sahibi_assijn, tisat_ashar].

% 13. ?- check_all_simple([kharait_altih, sad_oranges_land]).
%     Expected: true.  (both books are simple_fusha)

% 14. ?- check_all_simple([kharait_altih, men_in_the_sun]).
%     Expected: false.  (men_in_the_sun is eloquent_fusha, not simple_fusha)