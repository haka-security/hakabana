
HAKABANA
========

Network monitoring tool using Haka, Elasticsearch and Kibana.

This tool uses an Haka configuration to extract various information on the
network:

* packets and connections information
  * source and destination IP
  * geographic data
  * protocols
  * bandwidth
  * ...
* connections information
* http details (host, user-agent, uri...)
* dns queries

Install
-------

First you need to install hakabana (which depends on haka) on your computer.
You also need an elasticsearch server. By default, it is supposed to be available
locally (at 127.0.0.1:9200) but this can be changed by editing the file
`<install prefix>/share/haka/hakabana/config.lua`.

On the Kibana page, you need to import the predefined dashboard that is available
at `<install prefix>/share/haka/hakabana/dashboard/Hakabana.json`. This dashboard
will report various information about the packets and connections seen on the
network.

Going furhter
-------------

You are encouraged to check the Haka configuration located in
`<install prefix>/share/haka/modules/misc/hakabana`. It is easily editable if you want to
report extra information. Check Haka full documentation to get details about this
configuration file.

License
-------

This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
