:- module(verificationUtils, [existCompany/1, isNumber/1]).

:- use_module('./Models/Company/GetSetAttrsCompany.pl').
:- use_module('./Models/Company/SaveCompany.pl').


% Verifica se existe uma empresa cadastrada a bolsa a partir do seu ID
existCompany(IdComp) :-
    getCompanyJSON(Comps),
    existCompanyAux(IdComp, Comps).

existCompanyAux(_, []) :- false, !.
existCompanyAux(IdComp, [H|T]) :-
    getCompIdent(H, CompId),
    (CompId =:= IdComp -> true ; existCompanyAux(IdComp, T)).


% Verifica se uma String é um número
isNumber("0") :- !, false.
isNumber(String) :- 
    atom_number(String, Num),
    (Num > 0) -> true ; !, false.