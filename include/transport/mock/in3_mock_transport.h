#ifndef IN3_MOCK_TRANSPORT_H_
  #define IN3_MOCK_TRANSPORT_H_
  #include <client.h>   // the core client
  in3_ret_t transport_mock(char **urls, int urls_len, char *payload, in3_response_t *result);
#endif