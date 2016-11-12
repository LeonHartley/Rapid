#pragma once

#include "uv.h"
#include "habbo.h"

typedef void (*hh_server_started_cb)    (int status);
typedef void (*hh_connection_cb)        (uv_stream_t *client);
typedef void (*hh_disconnection_cb)     (uv_stream_t *client);
typedef void (*hh_receive_message_cb)   (uv_stream_t *client, hh_buffer_t *buffer);

typedef struct {
    hh_server_started_cb on_server_started;
    hh_connection_cb on_connection;
    hh_disconnection_cb on_connection_closed;
    hh_receive_message_cb on_message;
} hh_server_config_t;

hh_server_config_t *config = NULL;

hh_server_config_t *hh_server_config();

void hh_start_server(char *ip, int port, hh_server_config_t *configuration);

void hh_write_message(hh_buffer_t* message, uv_stream_t *session);

void hh_close_session(uv_stream_t *session);

char *hh_client_id(uv_stream_t *session);

hh_buffer_t *authentication_ok_composer() {
    hh_buffer_t *auth_ok = hh_buffer_create(((char *) malloc(6)), 6);

    hh_buffer_initialise(auth_ok);
    hh_buffer_write_short(3536, auth_ok);

    return auth_ok;
}

hh_buffer_t *motd_composer(char* text) {
    int msg_size = strlen(text) + 8;

    hh_buffer_t *motd = hh_buffer_create(((char *) malloc(msg_size)), msg_size);

    hh_buffer_initialise(motd);

    hh_buffer_write_short(1141, motd);
    hh_buffer_write_int(1, motd);
    hh_buffer_write_string(text, motd);

    return motd;
}