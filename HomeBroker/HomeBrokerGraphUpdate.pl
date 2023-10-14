:- consult('../Utils/matrixUtils.pl').
:- consult('../Models/Company/GetSetAttrsCompany.pl').
:- consult('../Utils/updateUtils.pl').
:- consult('../Models/Company/GetSetAttrsCompany.pl').

updateHBGraphCandle(Arquivo, Linha, Coluna):-
    writeMatrixValue(Arquivo, Linha, Coluna, "❚").


cleanHBGraph(FilePath, 26) :-
    replicate("", 74, Spaces),
    writeMatrixValue(FilePath, 26, 2, Spaces), !.
cleanHBGraph(FilePath, Row) :-
    replicate("", 74, Spaces),
    writeMatrixValue(FilePath, Row, 2, Spaces),
    NextRow is Row + 1,
    cleanHBGraph(FilePath, NextRow).


checkNewHBCandle(ID, OldPrice, NewPrice) :-
    (   NewPrice > OldPrice,
        getRow(ID, 6) ->
        number_string(ID, IDString),
        string_concat('../Model/Company/HomeBrokers/homebroker', IDString, Path0),
        string_concat(Path0, '.txt', Path),
        cleanHBGraph(Path, 6),
        getRow(ID, Row),
        newRow is Row + 20,
        setRow(ID, newRow)
    ;   NewPrice > OldPrice ->
        getRow(ID, Row),
        newRow is Row - 1,
        setRow(ID, newRow)
    ;   NewPrice < OldPrice,
        getRow(ID, 26) ->
        number_string(ID, IDString),
        string_concat('../Model/Company/HomeBrokers/homebroker', IDString, Path0),
        string_concat(Path0, '.txt', Path),
        cleanHBGraph(Path, 6),
        getRow(ID, Row),
        newRow is Row - 20,
        setRow(ID, newRow)
    ;   NewPrice < OldPrice ->
        getRow(ID, Row),
        newRow is Row + 1,
        setRow(ID, newRow)
    ;   true ->
        getRow(ID, Row),
        setRow(ID, Row)
    ).
    

