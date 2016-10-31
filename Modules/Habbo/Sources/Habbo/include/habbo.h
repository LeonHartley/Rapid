//
// Created by Leon on 18/10/2016.
//

#pragma once

typedef struct {
    int index;
    int length;
    char *base;
} hh_buffer_t;

hh_buffer_t *hh_buffer_create(int length);

void hh_buffer_free(hh_buffer_t *buffer);

void hh_buffer_initialise(hh_buffer_t *buffer);

void hh_buffer_reset(hh_buffer_t *buffer);

void hh_buffer_prepare(hh_buffer_t *buffer);

int hh_buffer_read_int(hh_buffer_t *buffer);

short hh_buffer_read_short(hh_buffer_t *buffer);

char *hh_buffer_read_string(hh_buffer_t *buffer);

void hh_buffer_write_string(char* string, hh_buffer_t *buffer);

void hh_buffer_write_short(short s, hh_buffer_t *buffer);

void hh_buffer_write_int(int i, hh_buffer_t *buffer);

void hh_buffer_write_int_at(int i, hh_buffer_t *buffer, int start);

void hh_buffer_write_byte(char byte, hh_buffer_t *buffer);