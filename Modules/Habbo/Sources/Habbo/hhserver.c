#include "include/hhserver.h"

#include <stdlib.h>
#include <uuid/uuid.h>

hh_server_config_t *hh_server_config() {
    return (hh_server_config_t *) malloc(sizeof(hh_server_config_t));
}

void hh_alloc_buffer(uv_handle_t* handle, size_t  size, uv_buf_t* buf) {
    buf->base = malloc(size);
    buf->len = size;
}

void hh_on_connection_close(uv_handle_t *handle) {
    // on connection closed
    config->on_connection_closed((uv_stream_t *) handle);

    // make sure we free the previously malloc'd session id
    free(handle->data);
}

void hh_on_write(uv_write_t* req, int status) {
   free(req->data);
}

void hh_close_on_write(uv_write_t *req, int status) {
    uv_close((uv_handle_t *) req->handle, hh_on_connection_close);
}

void hh_on_read(uv_stream_t *handle, ssize_t nread, const uv_buf_t *buf) {
    if(nread == UV_EOF) {
        uv_close((uv_handle_t *) handle, hh_on_connection_close);
        return;
    }

    if(nread >= 0) {
        if(buf->base[0] == '<') {
            char policy_file[208] = "<?xml version=\"1.0\"?>\r\n<!DOCTYPE cross-domain-policy SYSTEM \"/xml/dtds/cross-domain-policy.dtd\">\r\n<cross-domain-policy>\r\n<allow-access-from domain=\"*\" to-ports=\"*\" />\r\n</cross-domain-policy>\0";

            uv_write_t *req;
            if(!(req = malloc(sizeof(uv_write_t)))){
                return;                    
            }

            uv_buf_t buffer = uv_buf_init(malloc(sizeof(policy_file)), sizeof(policy_file));

            buffer.base = policy_file;

            req->handle = handle;
            req->data = buffer.base;

            uv_write(req, handle, &buffer, 1, hh_close_on_write);
        } else {
            // here we want to create a buffer
            hh_buffer_t *buffer = hh_buffer_create(buf->base, nread);

            // on message read
            config->on_message(handle, buffer);
        }
    } else {
        uv_close((uv_handle_t *) handle, hh_on_connection_close);
    }

    free(buf->base);
}

void hh_on_new_connection(uv_stream_t *server, int status) {
    uv_tcp_t *client = (uv_tcp_t *) malloc(sizeof(uv_tcp_t));

    uv_tcp_init(uv_default_loop(), client);

    int result = uv_accept(server, (uv_stream_t *) client);

    if(result == 0) {
        uuid_t *uuid = malloc(sizeof(uuid_t));
    
        uuid_generate(uuid);

        client->data = malloc(37);

        uuid_unparse(uuid, client->data);
        
        free(uuid);

        // connection accepted successfully
        config->on_connection((uv_stream_t *) client);

        uv_read_start((uv_stream_t *) client, hh_alloc_buffer, hh_on_read);
    } else {
        // failed to accept client
    }
}

char *hh_client_id(uv_stream_t *session) {
    return (char *) session->data;
}

void hh_write_message(hh_buffer_t* message, uv_stream_t *session) {
    uv_write_t *req;

    if(!(req = malloc(sizeof(uv_write_t)))){
        return;                    
    }

    hh_buffer_prepare(message);

    uv_buf_t buffer = uv_buf_init(message->base, message->index + 4);

    req->handle = session;
    req->data = buffer.base;

    uv_write(req, session, &buffer, 1, hh_on_write);
}

void hh_start_server(char *ip, int port, hh_server_config_t *configuration) {
    config = configuration;

    uv_loop_t *loop = uv_default_loop();

    uv_tcp_t server;
    struct sockaddr_in bind_addr;

    uv_tcp_init(loop, &server);
    uv_ip4_addr(ip, port, &bind_addr);
    uv_tcp_bind(&server, (const struct sockaddr *) &bind_addr, 0);
    uv_listen((uv_stream_t *) &server, 128, hh_on_new_connection);

    int result = uv_run(loop, UV_RUN_DEFAULT);

    if(result) {
        // display errors to user.
    }

    uv_loop_close(loop);
}

void hh_close_session(uv_stream_t *session) {
    uv_close((uv_handle_t *) session, hh_on_connection_close);
}
