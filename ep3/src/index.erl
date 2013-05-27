%% @author povloid
%% @doc @todo Add description to index.


%% Упражнение 3-9 -> Индексирование

-module(index).

%% ====================================================================
%% API functions
%% ====================================================================
-export([text/0,read_file/0,clean/1,split_text/1,create_map/1
		,split_text_to_string/1,create_strings_words_lists/1,create_index/2,index/0, print/0,
		 create_index_file/0,pac/4]).



index() ->
 	create_index(create_strings_words_lists(split_text_to_string(text())),
			 create_map(split_text(text()))). 
	
create_index_file() ->
	file:write_file("c:/erl/file.index", print()).


print() ->
	print_index_a("", index()).

print_index_a(Strings, []) -> Strings;
print_index_a(Strings, [X|T]) ->
	{Word, Index} = X,
	print_index_a(Strings ++ Word ++ "  " ++ pac("",0,0,lists:sort(Index)) ++ "\n" , T). 


%% ====================================================================
%% Internal functions
%% ====================================================================
  
%% Примеры запуска: 
%% 14> index:pac("", 0, 0, [1,3,5,6,7,10,11,12,14,15]).
%% "1,3,5-7,10-12,14-15"
%% 15> index:pac("", 0, 0, [1,3,5,6,7,10,11,12,14]).   
%% "1,3,5-7,10-12,14"
%% 16> index:pac("", 0, 0, [1,2,3,5,6,7,10,11,12,14]).
%% "1-3,5-7,10-12,14"
%% 17> index:pac("", 0, 0, [1,2,3,6,7,10,11,12,14]).  
%% "1-3,6-7,10-12,14"
%% 18> index:pac("", 0, 0, [1,2,4,6,7,10,11,12,14]).
%% "1-2,4,6-7,10-12,14"

pac(String, 1 , X ,[]) -> String ++ integer_to_list(X);
pac(String, _ , _ ,[]) -> String;
pac(String, 0 , 0, [Y|T]) ->
	pac( String ++ integer_to_list(Y), 0,  Y, T );
pac(String, 0 , X ,[Y|T]) when ((X == Y) or ((X + 1) == Y)) ->
	pac( String ++ "-" , 1 , X + 1, T);

pac(String, 1 , X, [Y|T]) when (X + 1) == Y ->
	pac( String , 1 , X + 1, T);
pac(String, 1 , X, [Y|T]) when X == Y ->
	pac( String , 1 , X, T);

pac(String, 0,  _, [Y|T]) -> 
	pac( String ++ "," ++ integer_to_list(Y) , 0,  Y, T);
pac(String, _,  X, [Y|T]) -> 
	pac( String ++ integer_to_list(X) ++ "," ++ integer_to_list(Y) , 0,  Y, T).



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