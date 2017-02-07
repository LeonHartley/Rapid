//
// Created by Leon on 02/01/2017.
//

#pragma once

typedef int* hh_map;

typedef struct {
    int x;
    int y;
    float z;
} hh_position;

typedef struct {
    hh_position position;
    void *next_node;
    int cost;
    int in_open;
    int in_closed;
} hh_pathfinder_node;

typedef int (*hh_pathfinder_valid_step)    (int entity, hh_position from, hh_position to, int last);

typedef struct {
    hh_pathfinder_valid_step *valid_step;
    hh_map *map;
} hh_pathfinder_config;

hh_position *hh_pathfinder_find(hh_pathfinder_config *config, hh_position *start, hh_position *destination);