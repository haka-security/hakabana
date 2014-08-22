-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require('misc/hakabana').initialize{
	elasticsearch = {
		host = "127.0.0.1",
		port = 9200,
		geoip_data = '/usr/share/GeoIP/GeoIP.dat'
	}
}

