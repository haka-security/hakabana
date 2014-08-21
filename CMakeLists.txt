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

# CPack default Packaging
include(version.cmake)

# Add a build tag from the Git information
execute_process(COMMAND git symbolic-ref -q --short HEAD WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
	OUTPUT_VARIABLE BUILD_BRANCH RESULT_VARIABLE HAD_ERROR OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_QUIET)
execute_process(COMMAND git describe --dirty --always WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
	OUTPUT_VARIABLE BUILDTAG RESULT_VARIABLE HAD_ERROR OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_QUIET)
if(HAD_ERROR EQUAL 0)
	set(HAKABANA_VERSION_BUILD "+${BUILDTAG}")
	execute_process(COMMAND echo "set(HAKABANA_VERSION_BUILD \"${HAKABANA_VERSION_BUILD}\")"
		OUTPUT_FILE ${CMAKE_SOURCE_DIR}/buildtag.cmake)
else()
	include(buildtag.cmake OPTIONAL)
endif()

set(CPACK_GENERATOR "TGZ")
set(CPACK_SET_DESTDIR TRUE)
set(CPACK_PACKAGE_RELOCATABLE FALSE)
set(CPACK_PACKAGE_NAME "hakabana")
set(CPACK_PACKAGE_VENDOR "Arkoon Network Security")
set(CPACK_PACKAGE_VERSION_MAJOR ${HAKABANA_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${HAKABANA_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${HAKABANA_VERSION_PATCH})
set(CPACK_PACKAGE_VERSION "${HAKABANA_VERSION_MAJOR}.${HAKABANA_VERSION_MINOR}.${HAKABANA_VERSION_PATCH}${HAKABANA_VERSION_BUILD}")
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}_${CPACK_PACKAGE_VERSION}")

set(CPACK_SOURCE_GENERATOR "NULL")

include(CPack)
