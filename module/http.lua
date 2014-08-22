-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

local http = require('protocol/http')

http.install_tcp_rule(80)

haka.rule{
	hook = http.events.request,
	eval = function (http, request)
		if not http.flow.ignore	then
			http.dataid = hakabana:genid()
			hakabana:insert('hakabana', 'http', http.dataid, {
				['@timestamp'] = hakabana:timestamp(haka.network_time()),
				uri = request.uri,
				['user agent'] = request.headers['User-Agent'],
				['host'] = request.headers['Host'],
				flow = http.flow.flowid
			})
		end
	end
}

haka.rule{
	hook = http.events.response,
	eval = function (http, response)
		hakabana:update('hakabana', 'http', http.dataid, {
			status = response.status
		})
	end
}

