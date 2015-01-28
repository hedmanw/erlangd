-module(higherorder).
-export([main/0, appserv/0, client/2]).

main() ->
    Pid = spawn(higherorder, appserv, []),
    catch(unregister(server)),
    register(server, Pid),
    Pid.

appserv() ->
    receive
        {Pid, apply, F, Args} ->
            Ans = apply(F, Args),
            Pid ! {response, Ans}
    end,
    appserv().

client(A1, A2) ->
    MyPid = self(),
    F = fun(V1, V2) -> V1 * V2 end,
    server ! {MyPid, apply, F, [A1, A2]},
    receive
        Msg ->
            io:fwrite("# Received message: ~p~n",[Msg])
    after 1000 ->
            io:fwrite("# Received nothing :(~n")
    end.


