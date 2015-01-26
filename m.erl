-module(m).
-export([hello/0,hello/1,mkPerson/2,greeting/2,greeting/1,sum/1]).

hello() ->
    io:fwrite("Hello world\n").

hello(Name) ->
    io:fwrite("Hello " ++ Name ++ "\n").

%% -----------

-record(person, {name, born=1990}).

mkPerson(N, B) ->
    #person{name=N, born=B}.

greeting(hi, Name) ->
    io:fwrite("Hello " ++ Name ++ "\n");
greeting(bye, Name) ->
    io:fwrite("Bye " ++ Name ++ "\n").

greeting({hi, #person{name=Name, born=Born}}) ->
    %Name = P#person.name,
    Age = 2015 - Born,
    if
        Age < 18 -> io:fwrite("Hej hej " ++ Name ++ "\n");
        Age < 30 -> io:fwrite("Tjena " ++ Name ++ "\n");
        true     -> io:fwrite("Halloj " ++ Name ++ "\n")
    end;
greeting({bye, Name}) ->
    io:fwrite("Bye " ++ Name ++ "\n");
greeting(Default) ->
    io:fwrite("Cannot handle: ~p\n", [Default]).

sum([])    -> 0;
sum([H|T]) -> H + sum(T).

