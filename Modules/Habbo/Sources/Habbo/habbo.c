#include "include/habbo.h"

const int habbo_b64_length = 2;

char *habbo_b64_encode(int value) {
    char *stack = malloc(habbo_b64_length);

    for (int x = 1; x <= habbo_b64_length; x++)
    {
        int offset = 6 * (habbo_b64_length - x);
        char val = (64 + (value >> offset & 0x3f));

        stack[x - 1] = val;
    }

    return stack;
}