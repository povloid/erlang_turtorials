%% @author povloid
%% @doc @todo Add description to calc.


-module(calc).

%% ====================================================================
%% API functions
%% ====================================================================
-export([parse/1]).




parse(Exp) -> iparse({},clean(Exp)).



%% ((2+3)-4) 
%% iparse([]) -> [];
%% iparse([$(|T])-> {iparse(T)};
%% iparse([$+|[$(|T]])-> {iparse(T)};
%% iparse([$-|[$(|T]])-> {minus,0,iparse(T)};
%% 
%% iparse([$)|T]) -> iparse(T);
%% 
%% iparse([X|[$+|T]] )->{plus, iparse(X), iparse(T)};
%% iparse([X|[$-|T]])->{minus, iparse(X), iparse(T)};
%% 
%% iparse([H|T]) -> H.


iparse(Tuple, []) -> Tuple;
iparse(Tuple, [$(|T]) -> 
	{H, TL} = iparse({},T),
	iparse(erlang:append_element(Tuple, H), TL);

iparse(Tuple, [$+|[$(|T]]) -> 
	{H, TL} = iparse({},T),
	iparse(erlang:append_element(Tuple, H), TL);

iparse(Tuple, [$-|[$(|T]]) -> 
	{H, TL} = iparse({},T),
	iparse(erlang:append_element(Tuple, {0,minus,H}), TL);

iparse(Tuple, [$)|T]) -> {Tuple, T};

iparse(Tuple, [$+|T]) -> 
	iparse(erlang:append_element(Tuple, plus),T);
iparse(Tuple, [$-|T]) -> 
	iparse(erlang:append_element(Tuple, minus),T);

iparse(Tuple, [H|T]) -> 
	{Hi,_} = string:to_integer([H]),
	iparse(erlang:append_element(Tuple, {num,Hi}),T).








%% ====================================================================
%% Internal functions
%% ====================================================================


clean([]) -> [];
clean([$ |T]) -> clean(T);
clean([H|T]) -> [H|clean(T)].