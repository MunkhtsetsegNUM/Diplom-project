# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/neon2sse"
  "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/_deps/neon2sse-build"
  "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/_deps/neon2sse-subbuild/neon2sse-populate-prefix"
  "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/_deps/neon2sse-subbuild/neon2sse-populate-prefix/tmp"
  "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/_deps/neon2sse-subbuild/neon2sse-populate-prefix/src/neon2sse-populate-stamp"
  "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/_deps/neon2sse-subbuild/neon2sse-populate-prefix/src"
  "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/_deps/neon2sse-subbuild/neon2sse-populate-prefix/src/neon2sse-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/_deps/neon2sse-subbuild/neon2sse-populate-prefix/src/neon2sse-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/Users/macbookpro/Desktop/Diploma/Diploma-project/humun/_deps/neon2sse-subbuild/neon2sse-populate-prefix/src/neon2sse-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
