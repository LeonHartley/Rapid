#include "include/habbo.h"

//
// Created by Leon on 18/10/2016.
//

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

hh_buffer_t *hh_buffer_create_empty(int length) {
    return hh_buffer_create((char*) malloc(length), length);
}

hh_buffer_t *hh_buffer_create(char* base, int length) {
    hh_buffer_t *buffer = malloc(sizeof(hh_buffer_t));

    buffer->index = 0;
    buffer->length = length;
    buffer->base = base;

    return buffer;
}

void hh_buffer_initialise(hh_buffer_t *buffer) {
    buffer->index = 4;
}

void hh_buffer_reset(hh_buffer_t *buffer) {
    buffer->index = 0;
}

void hh_buffer_prepare(hh_buffer_t *buffer) {
    hh_buffer_write_int_at(buffer->index, buffer, 0);
}

void hh_buffer_free(hh_buffer_t *buffer) {
    free(buffer);
}

int hh_buffer_read_int(hh_buffer_t *buffer) {
    return (0xff & buffer->base[buffer->index++] << 24) |
        (0xff & buffer->base[buffer->index++] << 16) |
        (0xff & buffer->base[buffer->index++] << 8) |
       (0xff & buffer->base[buffer->index++]);
}

short hh_buffer_read_short(hh_buffer_t *buffer) {
    return (0xff & buffer->base[buffer->index++]) << 8 |
        (0xff & buffer->base[buffer->index++] << 0);
}

char *hh_buffer_read_string(hh_buffer_t *buffer) {
    short length = hh_buffer_read_short(buffer);
    char* string = malloc(length + 1);

    for(int i = 0; i < length + 1; i++) {
        string[i] = buffer->base[buffer->index++];
    }

    return string;
}

void hh_buffer_write_string(char* string, hh_buffer_t *buffer) {
    size_t length = strlen(string);

    hh_buffer_write_short(length, buffer);

    for(int i = 0; i < length; i++) {
        hh_buffer_write_byte(string[i], buffer);
    }
}

void hh_buffer_write_short(short s, hh_buffer_t *buffer) {
    buffer->base[buffer->index++] = ((s >> 8) & 0xff);
    buffer->base[buffer->index++] = (s & 0xff);
}

void hh_buffer_write_int(int i, hh_buffer_t *buffer) {
    buffer->base[buffer->index++] = ((i >> 24) & 0xff);
    buffer->base[buffer->index++] = ((i >> 16) & 0xff);
    buffer->base[buffer->index++] = ((i >> 8) & 0xff);
    buffer->base[buffer->index++] = (i & 0xff);
}

void hh_buffer_write_int_at(int i, hh_buffer_t *buffer, int start) {
    buffer->base[start++] = ((i >> 24) & 0xff);
    buffer->base[start++] = ((i >> 16) & 0xff);
    buffer->base[start++] = ((i >> 8) & 0xff);
    buffer->base[start++] = (i & 0xff);
}

void hh_buffer_write_byte(char byte, hh_buffer_t *buffer) {
    buffer->base[buffer->index++] = byte;
}

void hh_buffer_write_bool(int b, hh_buffer_t *buffer) {
    buffer->base[buffer->index++] = b == 1 ? (char) 1 : (char) 0;
}
