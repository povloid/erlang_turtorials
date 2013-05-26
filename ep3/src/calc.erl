%% @author povloid
%% @doc @todo Add description to calc.


-module(calc).

%% ====================================================================
%% API functions
%% ====================================================================
-export([parse/1,calc/1]).


%% Упражнение 3-8 -> Выполнение и компиляция выражений

calc(Exp) -> calculate(parse(Exp)).

parse(Exp) -> iparse({},clean(Exp)).



%% ((2+3)-4) 

iparse(Tuple, []) -> Tuple;
iparse(Tuple, [$(|T]) -> 
	{H, TL} = iparse({},T),
	iparse(erlang:append_element(Tuple, H), TL);

%% iparse(Tuple, [$+|[$(|T]]) -> 
%% 	{H, TL} = iparse({},T),
%% 	iparse(erlang:append_element(Tuple, H), TL);
%% 
%% iparse(Tuple, [$-|[$(|T]]) -> 
%% 	{H, TL} = iparse({},T),
%% 	iparse(erlang:append_element(Tuple, {0,minus,H}), TL);

iparse(Tuple, [$)|T]) -> {Tuple, T};

iparse(Tuple, [$+|T]) -> 
	iparse(erlang:append_element(Tuple, plus),T);
iparse(Tuple, [$-|T]) -> 
	iparse(erlang:append_element(Tuple, minus),T);
iparse(Tuple, [$*|T]) -> 
	iparse(erlang:append_element(Tuple, mul),T);
iparse(Tuple, [$/|T]) -> 
	iparse(erlang:append_element(Tuple, divade),T);


iparse(Tuple, [H|T]) -> 
	{Hi,_} = string:to_integer([H]),
	iparse(erlang:append_element(Tuple, {num,Hi}),T).



calculate({}) -> 0;
calculate({num,X}) -> X;

calculate({minus,X}) -> -1 * calculate(X);

calculate({X,plus,Y}) -> calculate(X) + calculate(Y);
calculate({X,minus,Y}) -> calculate(X) - calculate(Y);
calculate({X,mul,Y}) -> calculate(X) * calculate(Y);
calculate({X,divade,Y}) -> calculate(X) / calculate(Y);
calculate(_) -> "syntax error".










%% ====================================================================
%% Internal functions
%% ====================================================================


clean([]) -> [];
clean([$ |T]) -> clean(T);
clean([H|T]) -> [H|clean(T)].