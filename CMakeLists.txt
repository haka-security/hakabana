# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# Initialize
cmake_minimum_required(VERSION 2.8)

project(hakabana NONE NONE)

install(DIRECTORY rule DESTINATION share/haka/hakabana)
install(DIRECTORY dashboard DESTINATION share/haka/hakabana)

configure_file(haka.conf.in ${CMAKE_CURRENT_BINARY_DIR}/haka.conf)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/haka.conf DESTINATION share/haka/hakabana)

configure_file(hakabana.1.in ${CMAKE_CURRENT_BINARY_DIR}/hakabana.1)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/hakabana.1 DESTINATION share/man/man1)

set(LOCALINSTALL "${CMAKE_BINARY_DIR}/out" CACHE STRING "Default localinstall dest")

add_custom_target(localinstall
	COMMAND $(MAKE) install DESTDIR=${LOCALINSTALL}
	WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
	COMMENT "Install locally..." VERBATIM
	VERBATIM
)
