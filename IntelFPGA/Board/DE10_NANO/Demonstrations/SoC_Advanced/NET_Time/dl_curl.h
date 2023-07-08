#ifndef DL_CURL_H_
#define DL_CURL_H_

#include <curl/curl.h>

void *curl_load();
void curl_unload(void *lib_handle);

extern CURL *(*dl_curl_easy_init)();
extern struct curl_slist *(*dl_curl_slist_append)(struct curl_slist *, const char *);
extern CURLcode (*dl_curl_easy_setopt)(CURL *, CURLoption, ...);
extern CURLcode (*dl_curl_easy_perform)(CURL *);
extern const char *(*dl_curl_easy_strerror)(CURLcode);
extern void (*dl_curl_easy_cleanup)(CURL *);

#endif /* DL_CURL_H_ */
