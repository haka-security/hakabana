
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

Requirements
------------

First you need to install haka on your computer. You need also to install
Kibana and Elasticsearch.

Dependencies
------------

### Required

* Toolchain (GCC, Make, ...)
* cmake (>= 2.8)
* haka (>= 0.2.1)
* libgeoip
* libjansson
* libuuid
* libcurl

### Optional

 * curl

Build
-----

### Configure

It is required to create a separate directory to store
all the files generated during the build using cmake.

    $ mkdir make
    $ cd make
    $ cmake ..

### Build

Then use make like usual to compile (`make`) and install (`make install`) or
clean (`make clean`).

    $ make
    $ sudo make install

Using Hakabana
--------------

The default setting assumes that the elasticsearch server runs locally (at
127.0.0.1:9200) but this can be changed by editing the main script file
`<install prefix>/share/haka/hakabana/config.lua`.

Going furhter
-------------

You are encouraged to check the Haka module located in `<install
prefix>/share/haka/modules/misc/hakabana`. It is easily editable if you want to
report extra information. Check Haka full documentation to get details about
hakabana's dedicated API.

On the Kibana page, you need to import the predefined dashboard that is
available at `<install prefix>/share/haka/hakabana/dashboard/Hakabana.json`.
This dashboard will report various information about the packets and connections
seen on the network.

Then you can run ``haka``:

    $ haka -c <install prefix>/share/haka/hakabana/haka.conf

License
-------

This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
