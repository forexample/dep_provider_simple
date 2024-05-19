cmake_minimum_required(VERSION 3.29)

set(MY_DEPENDENCY_PROVIDER_INIT OFF CACHE BOOL "" FORCE)
set(MY_DEPENDENCY_PROVIDER_SET "stable" CACHE STRING "")

function(my_dependency_provider method package_name)
  if(NOT MY_DEPENDENCY_PROVIDER_INIT)
    set(MY_DEPENDENCY_PROVIDER_INIT ON CACHE BOOL "" FORCE)
    message("Dependency provider using set: ${MY_DEPENDENCY_PROVIDER_SET}")
    message("CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME}")
    message("CMAKE_CXX_COMPILER_ID: ${CMAKE_CXX_COMPILER_ID}")
    if("${MY_DEPENDENCY_PROVIDER_SET}" STREQUAL "stable")
      set(__my_dp_foo_version "1.2.0")
      set(__my_dp_bar_version "1.0.1")
    else()
      set(__my_dp_foo_version "2.3.1")
      set(__my_dp_bar_version "3.0.2")
    endif()

    set(__my_dp_foo_version "${__my_dp_foo_version}" PARENT_SCOPE)
    set(__my_dp_bar_version "${__my_dp_bar_version}" PARENT_SCOPE)

    message("foo version: ${__my_dp_foo_version}")
    message("bar version: ${__my_dp_bar_version}")
  endif()

  execute_process(
      COMMAND
          "${CMAKE_COMMAND}"
          -E
          echo
          "Install ${package_name} version ${__my_dp_${package_name}_version}"
      COMMAND_ERROR_IS_FATAL ANY
  )

  # 'find_package' will find system packages
endfunction()

cmake_language(
    SET_DEPENDENCY_PROVIDER my_dependency_provider
    SUPPORTED_METHODS FIND_PACKAGE
)
