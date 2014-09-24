-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

local raw = require('protocol/raw')
local ipv4 = require('protocol/ipv4')
local icmp = require('protocol/icmp')
local tcp = require('protocol/tcp')
local udp = require('protocol/udp')


haka.rule{
	hook = raw.events.receive_packet,
	eval = function (pkt)
		pkt.data['@timestamp'] = hakabana:timestamp(pkt.timestamp)
		pkt.data.type = 'other'
		pkt.data.len = #pkt.payload
	end
}

haka.rule{
	hook = raw.events.send_packet,
	eval = function (pkt)
		if not pkt.data.ignore then
			hakabana:insert('hakabana', 'packet', nil, pkt.data)
		end
	end
}

haka.rule{
	hook = ipv4.events.receive_packet,
	eval = function (pkt)
		local data = pkt.raw.data
		data.src = pkt.src
		data.dst = pkt.dst
		data.proto = pkt.proto
		data.type = 'ipv4'
	end
}

haka.rule{
	hook = icmp.events.receive_packet,
	eval = function (pkt)
		local data = pkt.ip.raw.data
		data.type = 'icmp'
	end
}

haka.rule{
	hook = tcp.events.receive_packet,
	eval = function (pkt)
		local data = pkt.ip.raw.data
		data.srcport = pkt.srcport
		data.dstport = pkt.dstport
		data.type = 'tcp'
	end
}

haka.rule{
	hook = udp.events.receive_packet,
	eval = function (pkt)
		local data = pkt.ip.raw.data
		data.srcport = pkt.srcport
		data.dstport = pkt.dstport
		data.type = 'udp'
	end
}
