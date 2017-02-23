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

int hh_config_initialised() {
    return config != NULL;
}

void hh_initialise_config(hh_server_config_t *configuration) {
    config = configuration;
}


void hh_start_server(char *ip, int port);

void hh_write_message(hh_buffer_t* message, uv_stream_t *session);

void hh_close_session(uv_stream_t *session);

char *hh_client_id(uv_stream_t *session);