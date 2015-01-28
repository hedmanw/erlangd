-module(counter).
-export([main/0, rec/1, inc/1]).

main() ->
    Pid = spawn(counter, rec, [0]),
    catch(unregister(server)),
    register(server, Pid),
    Pid.

rec(Counter) ->
    receive
        {Pid, inc, V} ->
            Counter2 = Counter + V,
            Pid ! {response, Counter2};
        {Pid, dec, V} ->
            Counter2 = Counter - V,
            Pid ! {response, Counter2}
    end,
    rec(Counter2).

inc(V) ->
    MyPid = self(),
    server ! {MyPid, inc, V},
    receive
        Msg ->
            io:fwrite("# Received message: ~p~n",[Msg])
    after 1000 ->
            io:fwrite("# Received nothiung :(~n")
    end.


