-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

local function gen_flow_rules(mod)
	haka.rule{
		hook = mod.events.new_connection,
		eval = function (flow, pkt)
			local type
			local next_dissector = flow:next_dissector()
			if next_dissector then type = next_dissector.name end

			flow.flowid = hakabana:genid()

			hakabana:insert('hakabana', 'flow', flow.flowid, {
				['@timestamp'] = hakabana:timestamp(pkt.ip.raw.timestamp),
				srcip = flow.srcip,
				srccountry = geoip.country(flow.srcip),
				srcport = flow.srcport,
				dstip = flow.dstip,
				dstcountry = geoip.country(flow.dstip),
				dstport = flow.dstport,
				state = 'open',
				type = type or pkt.name,
				flow = flow.flowid,
			})
		end
	}

	haka.rule{
		hook = mod.events.end_connection,
		eval = function (flow, pkt)
			hakabana:update('hakabana', 'flow', flow.flowid, {
				state = 'closed'
			})
		end
	}

	haka.rule{
		hook = mod.events.receive_packet,
		eval = function (flow, pkt, dir)
			local data = pkt.ip.raw.data
			data.flow = flow.flowid

			local next_dissector = flow:next_dissector()
			if next_dissector then
				data.type = next_dissector.name
			end
		end
	}
end

gen_flow_rules(require('protocol/tcp_connection'))
gen_flow_rules(require('protocol/udp_connection'))
