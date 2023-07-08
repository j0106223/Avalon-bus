#include <stdio.h>
#include <stdlib.h>
#include <curl/curl.h>
#include <unistd.h>
#include "dl_curl.h"

int main(int argc, char *argv[])
{
    void *lib_handle;

    lib_handle = curl_load();
    if (!lib_handle) {
        fprintf(stderr, "curl_load failed!\r\n");
        return 0;
    }

    CURL *curl;
    CURLcode res;

    curl = dl_curl_easy_init();

    struct curl_slist *header = NULL;

    /* Modify a header curl otherwise adds differently */
    header = dl_curl_slist_append(header, "Host: demo.terasic.com");
    header = dl_curl_slist_append(header, "User-Agent: libcurl-agent/1.0");

    /* set our custom set of headers */
    res = dl_curl_easy_setopt(curl, CURLOPT_HTTPHEADER, header);
    if (res != CURLE_OK)
        fprintf(stderr, "curl_easy_setopt() failed: %s\n",
                dl_curl_easy_strerror(res));

    dl_curl_easy_setopt(curl, CURLOPT_URL,
            "http://demo.terasic.com/time/");

    while (1) {
        res = dl_curl_easy_perform(curl);
        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n",
                    dl_curl_easy_strerror(res));
        } else {
            printf("\r");
            fflush(stdout);
        }
        usleep(200 * 1000);
    }

    dl_curl_easy_cleanup(curl);

    curl_unload(lib_handle);
    return 0;
}
