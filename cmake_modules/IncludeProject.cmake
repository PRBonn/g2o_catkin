# This function is used to force a build on a dependant project at cmake
# configuration phase.

# FOLLOWING ARGUMENTS are the CMAKE_ARGS of ExternalProject_Add
function (build_external_project target repository tag)
  set(trigger_build_dir ${CATKIN_DEVEL_PREFIX}/lib/${PROJECT_NAME}/force_${target})

    # mktemp dir in build tree
    file(MAKE_DIRECTORY ${trigger_build_dir} ${trigger_build_dir}/build)
    # generate false dependency project
    set(CMAKE_LIST_CONTENT "
    cmake_minimum_required(VERSION 2.8)

    include(ExternalProject)
    ExternalProject_add(${target}
            PREFIX ${CATKIN_DEVEL_PREFIX}/lib/${PROJECT_NAME}
            GIT_REPOSITORY ${repository}
            GIT_TAG ${tag}
            CMAKE_ARGS ${ARGN}
            INSTALL_COMMAND \"\"
            TIMEOUT 20)
            add_custom_target(trigger_${target})
            add_dependencies(trigger_${target} ${target})")

    file(WRITE ${trigger_build_dir}/CMakeLists.txt "${CMAKE_LIST_CONTENT}")

    execute_process(COMMAND ${CMAKE_COMMAND} -DCMAKE_VERBOSE_MAKEFILE=ON -G Ninja ..
        WORKING_DIRECTORY ${trigger_build_dir}/build)
      message(STATUS "Using ninja to build G2O. May take a while. Please be patient.")
      message(STATUS "Note that if you are using Ubuntu 16.04 or higher, the compiling will 
                      produce a lot of warnings")
      execute_process(COMMAND ${CMAKE_COMMAND} --build .
        WORKING_DIRECTORY ${trigger_build_dir}/build)

endfunction()
