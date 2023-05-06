include(CMakePrintHelpers)
if( NOT TARGET CinderKinect )
	get_filename_component( CinderKinect_SOURCE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../src" ABSOLUTE )
	get_filename_component( CINDER_PATH "${CMAKE_CURRENT_LIST_DIR}/../../../.." ABSOLUTE )
	
	list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")
	find_package(libusb-1.0 REQUIRED)

	list( APPEND FREENECT_SOURCES
		${CinderKinect_SOURCE_PATH}/freenect/cameras.c
		${CinderKinect_SOURCE_PATH}/freenect/core.c
		${CinderKinect_SOURCE_PATH}/freenect/registration.c
		${CinderKinect_SOURCE_PATH}/freenect/tilt.c
		${CinderKinect_SOURCE_PATH}/freenect/usb_libusb10.c
	)
	
    add_library( CinderKinect ${CinderKinect_SOURCE_PATH}/CinderFreenect.cpp ${FREENECT_SOURCES})
	
	target_include_directories( CinderKinect PUBLIC "${CinderKinect_SOURCE_PATH}" ${CinderKinect_SOURCE_PATH}/freenect)
	target_include_directories( CinderKinect SYSTEM BEFORE PUBLIC "${CINDER_PATH}/include" )

	if( NOT TARGET cinder )
		    include( "${CINDER_PATH}/proj/cmake/configure.cmake" )
		    find_package( cinder REQUIRED PATHS
		        "${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
		        "$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}" )
	endif()
	target_link_libraries( CinderKinect PRIVATE cinder  ${LIBUSB_1_LIBRARIES})
	
endif()



