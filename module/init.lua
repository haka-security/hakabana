-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

local module = {}

local ipv4 = require('protocol/ipv4')
local tcp_conn = require('protocol/tcp_connection')

function module.ignore_flow(conn, check)
	haka.rule{
		hook = conn.events.new_connection,
		eval = function (flow, pkt)
			if check(flow) then
				flow.ignore = true
			end
		end
	}
end

function module.initialize(config)
	local es_conf = config['elasticsearch']
	if es_conf then
		local es_host = config['elasticsearch'].host
		local es_port = config['elasticsearch'].port or 9200

		haka.rule{
			hook = haka.events.started,
			eval = function ()
				local elastricsearch = require('misc/elasticsearch')
				hakabana = elastricsearch.connector('http://' .. es_host .. ':' .. es_port)
				hakabana:newindex("hakabana", {
					mappings = {
						http = {
							properties = {
								['user agent'] = {
									type = 'string',
									index = 'not_analyzed'
								},
								['host'] = {
									type = 'string',
									index = 'not_analyzed'
								}
							}
						}
					},
				})
			end
		}

		local geoip = require('misc/geoip')
		db = geoip.open('/usr/share/GeoIP/GeoIP.dat')

		-- do not monitor elasticsearch traffic
		module.ignore_flow(tcp_conn, function (flow)
			local es_ip = ipv4.addr(es_host)
			if (flow.dstip == es_ip and flow.dstport == es_port) or
				(flow.srcip == es_ip and flow.srcport == es_port) then
				return true
			end
			return false
		end)

		require('/misc/hakabana/packet')
		require('/misc/hakabana/flow')
		require('/misc/hakabana/http')
		require('/misc/hakabana/http')

	else
		error("missing elastic search config")
	end
end

return module
