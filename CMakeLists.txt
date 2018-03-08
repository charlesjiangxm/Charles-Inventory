# ------------------------------------------
# File: CMakeLists.txt
# Brief: To perform some universal configurations for using CLion
# Autor: Charles JIANG
# ------------------------------------------
cmake_minimum_required(VERSION 3.8)

#Change the project name accordingly
project(Test)

# general settings
set(CMAKE_CXX_STANDARD 11)
set(SOURCE_FILES main.cpp)

# for opencv
find_package(OpenCV REQUIRED)
message(STATUS "OpenCV library status:")
message(STATUS "    version: ${OpenCV_VERSION}")
message(STATUS "    libraries: ${OpenCV_LIBS}")
message(STATUS "    include path: ${OpenCV_INCLUDE_DIRS}")
include_directories(${OpenCV_INCLUDE_DIRS})

# for openmp
find_package(OpenMP)

# for eigen
include_directories(/home/gpu/eigen3_3_4)

# This is to compile main.cpp into an executable named Main
set(SRC_LIST
	main.cpp
)
add_executable(Test ${SRC_LIST})
target_link_libraries(Test ${OpenCV_LIBS})

add_definitions(
        -D DEBUG_MODE      # turn off the debug mode only when you are running val set accuracy
)
set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS} -Wall -O3 -fopenmp -march=native -msse2 -lgomp -lpthread -lm -ldl")
set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_EXE_LINKER_FLAGS}")
