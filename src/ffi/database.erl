-module(database).
-export([init/0, add_user/2, get_user/1]).

-record(user, {id, name}).

init() ->
    try
        case net_kernel:start([ffime, shortnames]) of
            {ok, _} -> ok;
            {error, {already_started, _}} -> ok;
            Error -> throw({node_error, Error})
        end,
    
        % Para y limpia mnesia primero si está corriendo
        mnesia:stop(),
        
        % Crea el schema
        case mnesia:create_schema([node()]) of
            ok -> ok;
            {error, {_, {already_exists, _}}} -> ok;
            Error1 -> throw({schema_error, Error1})
        end,
        
        % Inicia mnesia
        mnesia:start(),
        
        % Crea la tabla
        Result = mnesia:create_table(user, [
            {attributes, record_info(fields, user)},
            {disc_copies, [node()]},
            {type, set}
        ]),
        
        case Result of
            {atomic, ok} -> ok;
            {aborted, {already_exists, user}} -> ok;
            Error2 -> throw({table_error, Error2})
        end,
        
        % Espera a que esté lista
        case mnesia:wait_for_tables([user], 10000) of
            ok -> "init_ok";
            timeout -> "init_timeout";
            Error3 -> lists:flatten(io_lib:format("wait_error: ~p", [Error3]))
        end
        
    catch
        throw:Err -> lists:flatten(io_lib:format("init_error: ~p", [Err]));
        _:Err -> lists:flatten(io_lib:format("init_exception: ~p", [Err]))
    end.

add_user(Id, Name) ->
    User = #user{id = Id, name = Name},
    case mnesia:transaction(fun() -> mnesia:write(User) end) of
        {atomic, ok} -> "ok";
        {aborted, Reason} -> 
            % Asegúrate de que sea un string plano
            binary_to_list(list_to_binary(io_lib:format("error: ~p", [Reason])))
    end.

get_user(Id) ->
    case mnesia:transaction(fun() -> mnesia:read(user, Id) end) of
        {atomic, []} -> "not_found";
        {atomic, [#user{id = Id, name = Name}]} -> 
            lists:flatten(io_lib:format("found: ~s", [Name]));
        {aborted, Reason} -> 
            lists:flatten(io_lib:format("error: ~p", [Reason]))
    end.