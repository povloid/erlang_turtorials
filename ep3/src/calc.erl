%% @author povloid
%% @doc @todo Add description to calc.


-module(calc).

%% ====================================================================
%% API functions
%% ====================================================================
-export([exp/1,replace_var/3]).


%% Упражнение 3-8 -> Выполнение и компиляция выражений
%% Данный вариант работает только с натуральными числами от 0 до 9
%% Пример вызова: 
%% calc:exp("-((((1+2)+2)+(5-5))-((1-(2+2))*7))").
%% calc:exp("let c = (2+(4-2) ) in ( c + 4 )").
%% calc:exp("let c = (2+ (4 -2)) in c+4").
%% calc:exp("if ((2 + 2) - 4) then 4 else -((2*3)+(3*4))").
%% calc:exp("((2 + 2) - 4)").
%% calc:exp("2+1"). --- Если запись не в скобках то писать без пробелов




exp(Exp) ->
	R = list_to_tuple(string:tokens(clean_ext(Exp), [$ ])),
	io:format("~p~n",[R]),
	exp_ext(R). 

%% ====================================================================
%% Internal functions
%% ====================================================================


exp_ext({}) -> nothing;
exp_ext({"if", Exp1, "then" , Exp2, "else" , Exp3}) ->
	R = calc(Exp1),
	if 
		R /= 0 -> calc(Exp2);
		R == 0 -> calc(Exp3)
	end;
exp_ext({"let", Var, "=", Exp1 , "in" , Exp2}) ->
	calc(replace_var(Exp2, Var, integer_to_list(calc(Exp1))));
exp_ext({Exp}) -> calc(clean(Exp)).




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
calculate({X}) -> calculate(X);
calculate({num,X}) -> X;

calculate({minus,X}) -> -1 * calculate(X);

calculate({X,plus,Y}) -> calculate(X) + calculate(Y);
calculate({X,minus,Y}) -> calculate(X) - calculate(Y);
calculate({X,mul,Y}) -> calculate(X) * calculate(Y);
calculate({X,divade,Y}) -> calculate(X) / calculate(Y);
calculate(_) -> "syntax error".


clean_ext(X) -> clean_ext2(X,0). 

clean_ext2([], _) -> [];
clean_ext2([$ |T], C) when C > 0 -> clean_ext2(T,C);
clean_ext2([$(|T], C) -> [$(|clean_ext2(T, C + 1)];
clean_ext2([$)|T], C) -> [$)|clean_ext2(T, C - 1)];
clean_ext2([H|T], C) -> [H|clean_ext2(T , C)].


clean([]) -> [];
clean([$ |T]) -> clean(T);
clean([H|T]) -> [H|clean(T)].


replace_var([], _, _) -> [];
replace_var([H|T], Var, Value) when [H] == Var -> 
	Value ++ replace_var(T,Var,Value);
replace_var([H|T], Var, Value) -> 
	[H|replace_var(T,Var,Value)].
















