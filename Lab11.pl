
% Initial set of letters
:- dynamic letters/1.

letters([a,b,c]).

% Display current letters
display_letters :-
    letters(L),
    write('Current letters: '),
    write(L), nl.

% Add a letter
add_letter :-
    write('Enter a letter: '),
    read(X),
    letters(L),
    append(L, [X], NewL),
    retract(letters(L)),
    assertz(letters(NewL)),
    write('Letter added.'), nl.

% Add a letter at the top
add_top :-
    write('Enter a letter: '),
    read(X),
    letters(L),
    NewL = [X|L],
    retract(letters(L)),
    assertz(letters(NewL)),
    write('Letter added at the top.'), nl.

% Add a letter at the bottom
add_bottom :-
    add_letter.

% Delete a letter
delete_letter :-
    write('Enter a letter to delete: '),
    read(X),
    letters(L),
    ( select(X, L, NewL) ->
        retract(letters(L)),
        assertz(letters(NewL)),
        write('Letter deleted.'), nl
    ;
        write('Letter not found.'), nl
    ).

% Delete all letters
delete_all :-
    retractall(letters(_)),
    assertz(letters([])),
    write('All letters deleted.'), nl.

% Main menu
menu :-
    nl,
    write('Hi, This is the Name Game'), nl,
    write('1- Display the current set of letters'), nl,
    write('2- Add a letter'), nl,
    write('3- Add a letter at the top'), nl,
    write('4- Add a letter at the bottom'), nl,
    write('5- Delete a letter'), nl,
    write('6- Delete all letters'), nl,
    write('7- Exit'), nl,
    write('Enter your choice: '),
    read(Choice),
    execute(Choice).

execute(1) :-
    display_letters, menu.

execute(2) :-
    add_letter, menu.

execute(3) :-
    add_top, menu.

execute(4) :-
    add_bottom, menu.

execute(5) :-
    delete_letter, menu.

execute(6) :-
    delete_all, menu.

execute(7) :-
    write('Goodbye!'), nl.

execute(_) :-
    write('Invalid choice!'), nl,
    menu.

% Start the game
start :-
    menu.
