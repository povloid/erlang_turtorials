%% @author povloid
%% @doc @todo Add description to db.


-module(db).

%% ====================================================================
%% API functions
%% ====================================================================
-export([new/0,write/3,read/2,match/2,delete/2]).





new() -> [].

write(Name,City,DB) -> [{Name,City} | DB]. 

read(_, []) -> {error,instance};
read(Name, [{Name,City}| _ ]) -> {ok,City};
read(Name, [_| Tail]) -> read(Name, Tail).


match(_, []) -> [];
match(City, [{Name, City}| Tail]) -> [Name| match(City,Tail)];
match(City, [_| Tail]) -> match(City,Tail).
	
	
delete(_, []) -> [];
delete(Name, [{Name,_}| Tail]) -> delete(Name, Tail);
delete(Name, [Head| Tail]) -> [Head | delete(Name, Tail)].




%% ====================================================================
%% Internal functions
%% ====================================================================


