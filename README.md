# Arabic Literature Recommendation System 

Hi! This is an academic project I built to practice AI fundamentals and logical programming. It’s a rule-based expert system written entirely in **Prolog**.

### What does it do?
Instead of using machine learning, this system uses logical inference to recommend Arabic novels and literature. I built a knowledge base containing facts about various books—like their author, genre, theme, length, and the complexity of the Arabic language used (e.g., Simple vs. Eloquent Fusha). 

Based on these facts, the system can match a reader with their perfect book by running specific rules and queries.

### The Technical Side
- **Knowledge Base:** Created structured facts for books by prominent Arab authors like Ghassan Kanafani, Radwa Ashour, and Ayman Al-Otoum.
- **Inference Rules:** Wrote logical rules to filter books (e.g., finding a short, simple-Fusha book for beginners, or a deep historical novel).
- **Advanced Prolog:** Implemented recursion and list processing to filter through lists of books dynamically (like extracting all books by a specific author from a given list or checking if an entire list of books fits a certain criteria).

### How to test it
If you load the script into a Prolog environment (like SWI-Prolog), you can ask it things like:
- *"What's a good romance novel?"* 
  `?- rec_genre_theme(Book, novel, romance).`
- *"Is 'Men in the Sun' a good book for beginners?"*
  `?- is_beginner_book(men_in_the_sun).`

Feel free to explore the `Arabic Literature Exp Systempl.pl` file to see the logic, rules, and the sample queries I included at the bottom!
