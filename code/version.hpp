#pragma once                                                                       

// for cmake
// 用于在CMakeLists文件中解析用
// 0.1.0                                                                 
#define GAKKI_APP_VER_MAJOR 0                                                      
#define GAKKI_APP_VER_MINOR 1                                                      
#define GAKKI_APP_VER_PATCH 0                                                      

#define GAKKI_APP_VERSION (GAKKI_APP_VER_MAJOR * 10000 + GAKKI_APP_VER_MINOR * 100 + GAKKI_APP_VER_PATCH)

// for source code
// 用于在项目源码中获取版本号字符串
// v0.1.0                                                           
#define _GAKKI_APP_STR(s) #s                                                       
#define GAKKI_PROJECT_VERSION(major, minor, patch) "v" _GAKKI_APP_STR(major.minor.patch)