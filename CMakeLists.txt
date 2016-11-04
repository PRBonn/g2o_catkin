cmake_minimum_required(VERSION 2.8.3)
project(g2o)

include(cmake_modules/IncludeProject.cmake)

set(G2O_PREFIX g2o)
set(G2O_GIT_REPO https://github.com/RainerKuemmerle/g2o.git)

if(NOT GIT_TAG)
  set(GIT_TAG \"\")
endif()

message(STATUS ${GIT_TAG})
build_external_project(
    ${G2O_PREFIX}
    ${G2O_GIT_REPO}
    ${GIT_TAG})

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED)

file(GLOB_RECURSE G2O_LIBS
    libg2o*.so
    libg2o*.a
)

set(G2O_INCLUDE_DIRS
    "${PROJECT_BINARY_DIR}/g2o/src/g2o"
    "${PROJECT_BINARY_DIR}/g2o/src/g2o/g2o"
    "${PROJECT_BINARY_DIR}/g2o/src/g2o-build")

catkin_package(
    INCLUDE_DIRS ${G2O_INCLUDE_DIRS}
    LIBRARIES ${G2O_LIBS})
message(STATUS "G2O_INCLUDE_DIR = ${G2O_INCLUDE_DIR}")
message(STATUS "G2O_LIBS = ${G2O_LIBS}")

# in your other catkin projects the g2o libraries will be available as:
# ${g2o_INCLUDE_DIRS}
# ${g2o_LIBRARIES}
