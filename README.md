# luabry

luabry is a simple wrapper library around [luajrpc](https://github.com/ocornoc/luajrpc), my JSON-RPC validation utility. To be honest, luabry doesn't actually need luajrpc, but whatever.
luabry is also an API pseudo-binding to the [LBRY daemon](https://github.com/lbryio/lbry).



Requirements:

* [lua-cjson](https://github.com/mpx/lua-cjson)
* [luasocket](https://github.com/diegonehab/luasocket)
* Lua 5.1
* LBRY daemon

## Usage

luabry will return a table of functions when `require`'d. There is a function in the table for each entry in the [LBRY daemon API](https://lbryio.github.io/lbry/). Each functions takes two optional arguments: `id` (the request object id) and `params` (the parameters to be passed to the daemon). Each function returns a table which, when the remaining necessary fields are filled out, can be used to communicate with the LBRY daemon via `socket.http.request`.

## License

luabry is licensed under the MIT license. Review [the license](https://github.com/ocornoc/luajrpc/LICENSE) if you'd like.
