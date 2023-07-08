#include <stdbool.h>
#include <stdlib.h>
#include <dlfcn.h>
#include "dl_curl.h"

CURL *(*dl_curl_easy_init)() = NULL;
struct curl_slist *(*dl_curl_slist_append)(struct curl_slist *, const char *) =
        NULL;
CURLcode (*dl_curl_easy_setopt)(CURL *, CURLoption, ...) = NULL;
CURLcode (*dl_curl_easy_perform)(CURL *) = NULL;
const char *(*dl_curl_easy_strerror)(CURLcode) = NULL;
void (*dl_curl_easy_cleanup)(CURL *) = NULL;



void *curl_load()
{
    char *libcurl = "libcurl.so";
    bool bSuccess = true;
    void *lib_handle;

    if (bSuccess == true) {
        lib_handle = dlopen(libcurl, RTLD_NOW);
        if (lib_handle == NULL) {
            fprintf(stderr, "Load %s error: %s\r\n", libcurl, dlerror());
            bSuccess = false;
        }
    }

    if (bSuccess == true) {
        dl_curl_easy_init = dlsym(lib_handle, "curl_easy_init");
        dl_curl_slist_append = dlsym(lib_handle, "curl_slist_append");
        dl_curl_easy_setopt = dlsym(lib_handle, "curl_easy_setopt");
        dl_curl_easy_perform = dlsym(lib_handle, "curl_easy_perform");
        dl_curl_easy_strerror = dlsym(lib_handle, "curl_easy_strerror");
        dl_curl_easy_cleanup = dlsym(lib_handle, "curl_easy_cleanup");
        if (dl_curl_easy_init == NULL || dl_curl_slist_append == NULL
                || dl_curl_easy_setopt == NULL || dl_curl_easy_perform == NULL
                || dl_curl_easy_strerror == NULL || dl_curl_easy_cleanup == NULL) {
            fprintf(stderr, "Load %s error: %s\r\n", libcurl, dlerror());
            curl_unload(lib_handle);
            bSuccess = false;
        }
    }

    if (bSuccess == true) {
        return lib_handle;
    } else {
        return NULL;
    }
}

void curl_unload(void *lib_handle)
{
    dlclose(lib_handle);
    dl_curl_easy_init = NULL;
    dl_curl_slist_append = NULL;
    dl_curl_easy_setopt = NULL;
    dl_curl_easy_perform = NULL;
    dl_curl_easy_strerror = NULL;
    dl_curl_easy_cleanup = NULL;
}
