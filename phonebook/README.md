Phonebook
---------

A simple command-line phone ook program.

Manages multiple phone books.

To run
------

ruby ./phonebook.rb

Tests
-----

Although the project requires that gems not be used, rspec and rr are included
for easy testing. The actual "production" code does not use gems.

Run tests: `rspec phonebook_spec.rb`


Data Files
----------

Data files are just CSV, which makes imports easy. CSV library is built into Ruby.
The data file format is:

    index,name,number

index is used for updating and deleting entries. Delete function should also
re-number, probably. But the delete function isn't in scope.
