cmake_minimum_required(VERSION 3.29)
project(myproj)

option(MYPROJ_USE_BAR "Use package bar" OFF)

find_package(foo CONFIG REQUIRED)
add_executable(prog1 main1.cpp)
target_link_libraries(prog1 PRIVATE foo::foo)

if(MYPROJ_USE_BAR)
  find_package(bar CONFIG REQUIRED)
  add_executable(prog2 main2.cpp)
  target_link_libraries(prog2 PRIVATE bar::bar)
endif()
