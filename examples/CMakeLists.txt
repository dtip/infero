
# example-1: C API
ecbuild_add_executable( TARGET 1_example_mimo_c
   SOURCES   1_example_mimo_c.c
   CONDITION HAVE_BUILD_TOOLS
   INCLUDES  ${eckit_INCLUDE_DIRS}
   LIBS      inferoapi
   NOINSTALL
)

set_target_properties( 1_example_mimo_c
    PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)

# example-2: C++ API
ecbuild_add_executable( TARGET 2_example_mimo_cpp
   SOURCES   2_example_mimo_cpp.cc
   CONDITION HAVE_BUILD_TOOLS
   INCLUDES  ${eckit_INCLUDE_DIRS}
   LIBS      
     infero
     eckit
     eckit_option
   NOINSTALL
)

set_target_properties( 2_example_mimo_cpp
    PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)

# example-3: Fortran API
if(infero_HAVE_FORTRAN_APIS)

    ecbuild_add_executable( TARGET 3_example_mimo_fortran
       SOURCES   3_example_mimo_fortran.F90
       CONDITION HAVE_BUILD_TOOLS
       INCLUDES  ${eckit_INCLUDE_DIRS}
       LIBS      inferof
       NOINSTALL
    )

    set_target_properties( 3_example_mimo_fortran
        PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
    )

endif()

