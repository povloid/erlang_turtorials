%% @author povloid
%% @doc @todo Add description to db2.

-module(db2).

%% ====================================================================
%% API functions
%% ====================================================================
-export([new/0,write/3,read/2,match/2,delete/2]).


%% Упражнение 3-7 -> применение библиотечных модулей

new() -> [].

write(Name,City,DB) -> 
	lists:keystore(Name,1,DB,{Name,City}). 

read(Key, DB) ->
	lists:keysearch(Key, 1, DB).


match(Key, DB) ->
	lists:keytake(Key, 2, DB).
	
	
delete(Key, DB) -> 
	lists:keydelete(Key, 1, DB).







%% ====================================================================
%% Internal functions
%% ====================================================================