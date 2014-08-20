-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

local module = {}

function module.initialize(config)
	local elasticsearch_host = config['elasticsearch']
	if elasticsearch_host then
		local elastricsearch = require('misc/elasticsearch')

		hakabana = elastricsearch.connector(elasticsearch_host)
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

		geoip = require('misc/geoip')

		require('/misc/hakabana/packet')
		require('/misc/hakabana/flow')
		require('/misc/hakabana/http')
	else
		error("missing elastic search config")
	end
end

return module
