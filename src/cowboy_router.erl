-module(cowboy_router).
-export([find/1, options/1, reload/1]).

find(Handler) ->
    case lists:keyfind({cowboy_router, Handler}, 1, supervisor:which_children(cowboy_router_sup)) of
        false ->
            undefined;
        {_Id, Pid, _Type, _Modules} ->
            Pid
    end.

options(Server) when is_atom(Server) ->
    options(find(Server));
options(Server) ->
    gen_server:call(Server, options).

reload(Server) when is_atom(Server) ->
    reload(find(Server));
reload(Server) ->
    gen_server:call(Server, reload).
