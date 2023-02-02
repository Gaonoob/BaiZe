FUNCTION(decode_version)                                 
    FILE(READ "cust/version.cfg" file_contents) 
    STRING(REGEX MATCH "BAIZE_VER_MAJOR ([0-9]+)" _  "${file_contents}")       
    IF(NOT CMAKE_MATCH_COUNT EQUAL 1)                                           
        MESSAGE(FATAL_ERROR "Could not extract major version number from version.cfg") # FATAL_ERROR，立即终止所有 cmake 过程.
    ENDIF()                                                                     
    SET(ver_major ${CMAKE_MATCH_1})                                             

    STRING(REGEX MATCH "BAIZE_VER_MINOR ([0-9]+)" _  "${file_contents}")       
    IF(NOT CMAKE_MATCH_COUNT EQUAL 1)                                           
        MESSAGE(FATAL_ERROR "Could not extract minor version number from version.cfg") # FATAL_ERROR，立即终止所有 cmake 过程
    ENDIF()                                                                     
    SET(ver_minor ${CMAKE_MATCH_1})                                             
    STRING(REGEX MATCH "BAIZE_VER_PATCH ([0-9]+)" _  "${file_contents}")       
    IF(NOT CMAKE_MATCH_COUNT EQUAL 1)                                           
        MESSAGE(FATAL_ERROR "Could not extract patch version number from version.cfg") # FATAL_ERROR，立即终止所有 cmake 过程
    ENDIF()                                                                     
    SET(ver_patch ${CMAKE_MATCH_1})                                             

    SET(BAIZE_BASE_VERSION_MAJOR ${ver_major} PARENT_SCOPE)                      
    SET (BAIZE_BASE_VERSION "${ver_major}.${ver_minor}.${ver_patch}" PARENT_SCOPE)
    SET (CMAKE_SYSTEM "hello" PARENT_SCOPE)
ENDFUNCTION()