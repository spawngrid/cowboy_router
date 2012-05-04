-module(cowboy_router_sup).
-behaviour(esupervisor).
-include_lib("esupervisor/include/esupervisor.hrl").


%% API
-export([start_link/2]).

%% Supervisor callbacks
-export([init/1]).

%% ===================================================================
%% API functions
%% ===================================================================

start_link(Handler, Listeners) ->
    esupervisor:start_link({local, ?MODULE}, ?MODULE, [Handler, Listeners]).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================


init([Handler, Listeners]) ->
    #one_for_one{
      children = [
                  #worker{
                     id = {cowboy_router, Handler},
                     restart = permanent,
                     start_func = {cowboy_router_server, start_link, [Handler, Listeners]},
                     modules = [Handler, cowboy_router_server]
                  }
                 ]
     }.
