%% @author povloid
%% @doc @todo Add description to text_width.

%% Упражнение 3-10 -> Обработка текста 


-module(text_width).

%% ====================================================================
%% API functions
%% ====================================================================
-export([clean/1,read_file/0,text/0,words/0,print_text/0]).





%% ====================================================================
%% Internal functions
%% ====================================================================


%% (ep3@proton-w7)25> text_width:print_text().
%%  Write  a  function that will print this
%% in  a  readable form, so that duplicates
%% are removed and adjacent numbers are put
%% into a range. You might like to think of
%% doing  this  via  a function which turns
%% the  earlier  list of occurrences into a
%% list  like                              
%% [{1,2},{4,6},{98,98},{100,100},{102,102}]
%% through a sequence of transformations.
%% ok
%% (ep3@proton-w7)26> 

print_text() ->
  print(words(), 40, "").


print(_ , Width , _) when Width < 30 -> {error,  "Bad width size"};
print([], _ ,Line) ->
	io:format(Line ++ "\n"),
	ok;
print([Word|L], Width , Line) -> 
	LineSize = string:len(Line),
	WordSize = string:len(Word),
	io:format("~p , ~p , ~c", [LineSize,WordSize,Word]),
	if 
		((LineSize + 1 + WordSize) =< Width) -> print(L, Width , Line ++ " " ++ Word);
		true -> 
			io:format( expand_line(Line,Width) ++ "\n"),			
 			print(L, Width , Word)
	end.


expand_line(Line, Width) ->
 	LineSize = string:len(Line),
 	if
 		LineSize >= Width -> Line;
		true -> 
			expand_line( expand_one(Line), Width)
	end.
		
expand_one([]) -> [$ ];
expand_one([B|[$ |[H|T]]]) when ((H /= $ ) and (B /= $ )) ->   
	[B|[$ |[$ |[H|T]]]];
expand_one([H|T]) -> [H| expand_one(T)].
	

words() ->
	string:tokens(clean(text()), [$ ]).

text() -> 
	{ok,Text} = read_file(),
 	binary_to_list(Text).

read_file() ->
	file:read_file("c:/erl/file.txt").


% отчистка текста от лишних пробелов  знаков припинания
clean([]) -> [];
clean([$ |[$ |T]]) -> clean([$ |T]);
clean([$\n|T]) -> clean([$ |T]);
clean([H|T]) -> [H|clean(T)].

