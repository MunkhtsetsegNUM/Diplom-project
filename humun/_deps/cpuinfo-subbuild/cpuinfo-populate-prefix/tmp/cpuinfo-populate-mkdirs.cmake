# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/cpuinfo"
  "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/_deps/cpuinfo-build"
  "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/_deps/cpuinfo-subbuild/cpuinfo-populate-prefix"
  "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/_deps/cpuinfo-subbuild/cpuinfo-populate-prefix/tmp"
  "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/_deps/cpuinfo-subbuild/cpuinfo-populate-prefix/src/cpuinfo-populate-stamp"
  "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/_deps/cpuinfo-subbuild/cpuinfo-populate-prefix/src"
  "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/_deps/cpuinfo-subbuild/cpuinfo-populate-prefix/src/cpuinfo-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/_deps/cpuinfo-subbuild/cpuinfo-populate-prefix/src/cpuinfo-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/_deps/cpuinfo-subbuild/cpuinfo-populate-prefix/src/cpuinfo-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
