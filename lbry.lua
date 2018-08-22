local http = require "socket.http"
local ltn12 = require "ltn12"
local json = require "json"
local jrpc = require "luajrpc/jrpc"
local luabry = {}

local funclist = {
	"blob_announce",
	"blob_availability",
	"blob_delete",
	"blob_get",
	"blob_list",
	"blob_reflect",
	"blob_reflect_all",
	"block_show",
	"channel_export",
	"channel_import",
	"channel_list",
	"channel_new",
	"claim_abandon",
	"claim_list",
	"claim_list_by_channel",
	"claim_list_mine",
	"claim_new_support",
	"claim_renew",
	"claim_send_to_address",
	"claim_show",
	"cli_test_command",
	"commands",
	"daemon_stop",
	"file_delete",
	"file_list",
	"file_reflect",
	"file_set_status",
	"get",
	"help",
	"peer_list",
	"peer_ping",
	"publish",
	"resolve",
	"resolve_name",
	"routing_table_get",
	"settings_get",
	"settings_set",
	"status",
	"stream_availability",
	"stream_cost_estimate",
	"transaction_list",
	"transaction_show",
	"utxo_list",
	"version",
	"wallet_balance",
	"wallet_decrypt",
	"wallet_encrypt",
	"wallet_is_address_mine",
	"wallet_list",
	"wallet_new_address",
	"wallet_prefill_addresses",
	"wallet_public_key",
	"wallet_send",
	"wallet_unlock",
	"wallet_unused_address",
}

for _,v in pairs(funclist) do
	luabry[v] = function(params, id)
		local body = {
			jsonrpc = "2.0",
			method = v,
			params = params,
			id = id,
		}
		
		assert(jrpc.validate_request(body))
		
		local jstring = json.encode(body)
		
		return {
			url = "http://localhost:5279",
			method = "POST",
			headers = {
				["Content-Type"]   = "application/json-rpc",
				["Accept"]         = "application/json-rpc",
				["Content-Length"] = jstring:len(),
			},
			source = ltn12.source.string(jstring),
		}
	end
end

return luabry
