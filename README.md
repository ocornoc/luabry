# luabry

luabry is an API pseudo-binding to the [LBRY daemon](https://github.com/lbryio/lbry).

<br/>

#### Requirements:

* [lua-cjson](https://github.com/mpx/lua-cjson)
* [luasocket](https://github.com/diegonehab/luasocket)
* Lua 5.1
* [lbrynet-daemon](https://github.io/lbryio/lbry) (for `lbry.lua`)
* [lbrycrdd](https://github.com/lbry/lbrycrd) (for `lbrycrd.lua`)

## Usage

There are two libraries in luabry: `lbry.lua` and `lbrycrd.lua`. `lbry.lua` interfaces with the lbrynet-daemon, while `lbrycrd.lua` interfaces with the lbrycrd daemon. Each `lbry.lua` function takes two optional arguments: `id` (the request object id) and `params` (the parameters to be passed to the daemon). `lbrycrd.lua` adds an additional two optional arguments: `user` (the lbrycrdd username), and `password` (the lbrycrdd password). Each function returns a table which, when the remaining necessary fields are filled out, can be used to communicate with the lbrynet-daemon or lbrycrdd via `socket.http.request`.

Example `lbry.lua` usage:

```Lua
local lbry = require "lbry"
local ltn12 = require "ltn12"
local http = require "socket.http"

-- Sets up the `status` API method call, with the parameters-table `{session_status = true}` and the JSON-RPC field `id = 1`.
local req = lbry.status({
	session_status = true,
}, 1)
-- Returns a table that, when given a URL and an LTN12 sink, can be called by `http.request`.

-- The sink is filled out.
req.sink = ltn12.sink.file(io.stdout)
-- The URL does not need to be provided if lbrynet-daemon is bound to its default URL.

-- Safely calls the request and ends up printing the resulting JSON-RPC response.
assert(http.request(req))
```

<br/>

Example `lbrycrd.lua` usage:

```Lua
local http = require "socket.http"
local lbrycrd = require "lbrycrd"
local ltn12 = require "ltn12"

local username, password = "hi", "test"

-- Sets up the `getinfo` API method call, with no (nil) parameter table and the JSON-RPC field `id = 1`.
-- The username and password provided by us are defined above.
local req = lbrycrd.getinfo(nil, 1, username, password)
-- Returns a table that, when given a URL and an LTN12 sink, can be called by `http.request`.

-- The sink is filled out.
req.sink = ltn12.sink.file(io.stdout)
-- The URL does not need to be provided if lbrycrdd is bound to its default URL.

-- Safely calls the request and ends up printing the resulting JSON-RPC response.
assert(http.request(req))
```

## License

luabry is licensed under the MIT license. Review [the license](LICENSE) if you'd like.
