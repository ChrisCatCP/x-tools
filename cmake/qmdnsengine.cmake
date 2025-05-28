# https://github.com/nitroshare/qmdnsengine
set(qmdns_package_name "qmdnsengine-master")

# --------------------------------------------------------------------------------------------------
# Extract qmdns zip...
if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/3rd/${qmdns_package_name})
  execute_process(COMMAND ${CMAKE_COMMAND} -E tar xzf ${qmdns_package_name}.zip
                  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/3rd)
endif()

# --------------------------------------------------------------------------------------------------
# Add qmdns module...
set(qmdns_dst_dir ${X_DEPLOY_LIBS_DIR}/${qmdns_package_name})
if(EXISTS ${qmdns_dst_dir})
  set(CMAKE_PREFIX_PATH ${qmdns_dst_dir} ${CMAKE_PREFIX_PATH})
  find_package(qmdnsengine REQUIRED)
else()
  add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/3rd/${qmdns_package_name})
  set_property(TARGET qmdnsengine PROPERTY FOLDER "3rd")
endif()

# --------------------------------------------------------------------------------------------------
# Install qmdns library to libs
function(x_install_qmdns target)
  add_custom_target(
    qmdnsengine_install
    COMMAND ${CMAKE_COMMAND} --install . --prefix ${qmdns_dst_dir}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/3rd/${qmdns_package_name}
    SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/cmake/qmdnsengine.cmake)
  set_property(TARGET qmdnsengine_install PROPERTY FOLDER "3rd")
endfunction()
