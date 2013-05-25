%% @author povloid
%% @doc @todo Add description to m1.


-module(m1).

%% ====================================================================
%% API functions
%% ====================================================================
-export([inc/1,add/2,dec/1,mod/2,sum1/1,sum2/1,sum1/2,sum2/2,create/1,reverce_create/1
		,print_0_N/1,print_0_N_ch/1]).

inc(X) -> X + 1.
dec(X) -> X - 1.

add(X , Y) -> X + Y.
mod(X, Y) -> X * Y.

%% Первый вариант с прямой рекурсией
sum1(0) -> 0;
sum1(X) -> X + sum1(X - 1).

sum1(X,Y) when X > Y -> 0;
sum1(X,Y) -> X + sum1(X + 1, Y).


%% Второй вариант сумм с хвостовой рекурсией 
sum2(X) -> sum_acc(X, 0).

sum_acc(0, Sum) -> Sum;
sum_acc(X, Sum) -> sum_acc(X - 1, Sum + X).


sum2(X,Y) -> sum_acc2(X,Y,0).

sum_acc2(X,Y,Sum) when X > Y -> Sum;
sum_acc2(X,Y,Sum) -> sum_acc2(X + 1, Y , Sum + X). 


create(X) -> create_acc(X, []).

create_acc(0, List) -> List;
create_acc(I, List) -> create_acc(I - 1 ,[I|List]). 

reverce_create(0) -> [];
reverce_create(X) -> [ X | reverce_create(X - 1)].



print_0_N(N) -> print_tail(1,N).

print_tail(I,N) when I > N -> ok;
print_tail(I,N) -> io:format("~p~n", [I]), print_tail(I + 1,N).


print_0_N_ch(N) -> print_tail_ch(1,N).
                                                                               
print_tail_ch(I,N) when I > N -> ok;
print_tail_ch(I,N) when I rem 2 == 0 -> print_tail_ch(I + 1,N);
print_tail_ch(I,N) -> io:format("~p~n", [I]), print_tail_ch(I + 1,N).














%% ====================================================================
%% Internal functions
%% ====================================================================

 



