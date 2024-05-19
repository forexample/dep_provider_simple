cmake_minimum_required(VERSION 3.29)

function(submodule_dependency_provider method package_name)
  add_subdirectory("third_party/${package_name}")

  # Stub config file for 'find_package' to process
  set(stub_dir "${CMAKE_CURRENT_BINARY_DIR}/generated/pkg")
  file(WRITE "${stub_dir}/${package_name}Config.cmake" "")
  set(${package_name}_DIR ${stub_dir} PARENT_SCOPE)
endfunction()

cmake_language(
    SET_DEPENDENCY_PROVIDER submodule_dependency_provider
    SUPPORTED_METHODS FIND_PACKAGE
)
