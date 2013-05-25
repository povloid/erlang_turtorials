%% @author povloid
%% @doc @todo Add description to listu.


-module(listu).

%% ====================================================================
%% API functions
%% ====================================================================
-export([filter/2,reverce/1,reverce2/1,concatenate/1,flatten/1,qsort/1,ssort/1,ssortx/1,is_sorted/1]).


%% Упражнение 3-5 -> Работа со списками

%% 1
filter([],_) -> [];
filter([H|T], X) when H =< X -> [H| filter(T,X)];
filter([_|T], X) -> filter(T,X).

%% 2
reverce([]) -> [];
reverce([H|T]) -> reverce(T) ++ [H].


reverce2(List) -> reverce_iter(List, []).

reverce_iter([], List2) -> List2;
reverce_iter([H|T], List2) -> reverce_iter(T,[H|List2]).

%% 3
concatenate(List) -> concatenate_a([],List).

concatenate_a(AL, []) -> reverce2(AL);
concatenate_a(AL, [[]|List]) -> concatenate_a(AL, List); 
concatenate_a(AL, [H|T]) ->
	[HH|TT] = H,
	concatenate_a([HH|AL], [TT|T]).

%% 4
flatten([]) -> [];
flatten([H|T]) when is_list(H) -> 
	concatenate( [flatten(H) , flatten(T)]);
flatten([H|T]) -> [H | flatten(T)].


%% Упражнение 3-6 -> Сортировка списков 

%% Быстрая сортировка 
qsort([]) -> [];
qsort([H|T]) -> 
 	 concatenate([qsort(filterm(T,H)) ,[ H | qsort(filterb(T,H))]]). 

%% Сортировка слиянием
ssort(List) -> 
	io:format("~p~n", [List]),
	case is_sorted(List) of
		yes -> List;
		no -> ssort(ssortx(List))
	end.


ssortx([]) -> [];
ssortx([H|[]]) -> [H];
ssortx([H1|[H2|T]]) when H1 > H2 ->
	[H2|ssortx([H1|T])];
ssortx([H1|[H2|T]]) -> 
	[H1|ssortx([H2|T])].



%% ====================================================================
%% Internal functions
%% ====================================================================

is_sorted([]) -> yes;
is_sorted([H1|[H2|_]]) when H1 > H2 -> no;
is_sorted([_|T]) -> is_sorted(T). 



filterm([],_) -> [];
filterm([H|T], X) when H < X -> [H| filterm(T,X)];
filterm([_|T], X) -> filterm(T,X).

filterb([],_) -> [];
filterb([H|T], X) when H > X -> [H| filterb(T,X)];
filterb([_|T], X) -> filterb(T,X).




