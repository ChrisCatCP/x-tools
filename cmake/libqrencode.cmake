﻿# https://github.com/fukuchi/libqrencode
set(qrencode_package_name "libqrencode-master")

# --------------------------------------------------------------------------------------------------
# Extract libencode zip...
if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/3rd/${qrencode_package_name})
  execute_process(COMMAND ${CMAKE_COMMAND} -E tar xzf ${qrencode_package_name}.zip
                  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/3rd)
endif()

# --------------------------------------------------------------------------------------------------
# Add libencode module...
if(${CMAKE_BUILD_TYPE} STREQUAL "Release")
  set(x_qrencode "qrencode")
else()
  set(x_qrencode "qrencoded")
endif()

set(qrencode_dst_dir ${X_DEPLOY_LIBS_DIR}/${qrencode_package_name})
if(EXISTS ${qrencode_dst_dir})
  set(CMAKE_PREFIX_PATH ${qrencode_dst_dir} ${CMAKE_PREFIX_PATH})
  link_directories(${qrencode_dst_dir}/lib)
  include_directories(${qrencode_dst_dir}/include)
else()
  add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/3rd/${qrencode_package_name})
  include_directories(${CMAKE_CURRENT_SOURCE_DIR}/3rd/${qrencode_package_name})
  set_property(TARGET qrencode PROPERTY FOLDER "3rd")
  set(x_qrencode "qrencode")
endif()

if(LINUX)
  set(x_qrencode "qrencode")
endif()

# --------------------------------------------------------------------------------------------------
# Install libencode library to libs
function(x_install_qrencode target)
  add_custom_target(
    qrencode_install
    COMMAND ${CMAKE_COMMAND} --install . --prefix ${qrencode_dst_dir}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/3rd/${qrencode_package_name}
    SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/cmake/libqrencode.cmake)
  set_property(TARGET qrencode_install PROPERTY FOLDER "3rd")
endfunction()
