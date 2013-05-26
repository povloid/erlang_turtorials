%% @author povloid
%% @doc @todo Add description to index.


-module(index).

%% ====================================================================
%% API functions
%% ====================================================================
-export([text/0,read_file/0,clean/1,split_text/1,create_map/1
		,split_text_to_string/1,create_strings_words_lists/1,create_index/2,index/0]).



index() ->
 	create_index(create_strings_words_lists(split_text_to_string(text())),
			 create_map(split_text(text()))). 
	


%% ====================================================================
%% Internal functions
%% ====================================================================

create_index(Strings, Index) -> create_index_a(1,Strings, Index).

create_index_a(_,[],Index) -> Index;
create_index_a(N,[String|Strings],Index) -> 
	create_index_a( N + 1, Strings, make_string(N,String,Index)).


make_string(_,[],Index) -> Index;
make_string(N,[Word|Words],Index) -> 
	case lists:keyfind(Word, 1, Index) of
		{Word,L} ->
			make_string(N, Words, lists:keyreplace(Word, 1, Index, {Word,[N|L]}));
		false ->
			make_string(N, Words, Index)
	end.
		



create_map(Words) ->  create_map_a(Words, []).

create_map_a([], Map) -> Map;
create_map_a([Word|T], Map) -> 
	create_map_a(T, lists:keystore(Word, 1, Map, {Word,[]})).

create_strings_words_lists([]) -> [];
create_strings_words_lists([H|T]) ->
	[split_text(H)|create_strings_words_lists(T)].


%% Разбить текст на троки 
split_text_to_string(Text) ->
	string:tokens(Text,[$\n]).

%% Разбить текст на слова
split_text(Text) -> 
	string:tokens(clean(Text),[$ , $\n]).




%% Текст -------------------------------------------------------------- 

text() -> 
	{ok,Text} = read_file(),
 	binary_to_list(Text).

read_file() ->
	file:read_file("c:/erl/file.txt").


% отчистка текста от лишних пробелов  знаков припинания
clean([]) -> [];
clean([$ |[$ |T]]) -> clean([$ |T]);
clean([$,|T]) -> clean([$ |T]);
clean([$.|T]) -> clean([$ |T]);
clean([$-|T]) -> clean([$ |T]);
clean([H|T]) -> [H|clean(T)].