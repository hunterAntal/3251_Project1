#include "symbol.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

Symbol symbol_table[MAX_SYMBOLS];
int symbol_count = 0;

int find_symbol(const char* name) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbol_table[i].name, name) == 0) {
            return i;
        }
    }
    return -1;
}

int add_symbol(const char* name) {
    if (symbol_count >= MAX_SYMBOLS) {
        fprintf(stderr, "Error: Symbol table overflow\n");
        exit(1);
    }
    symbol_table[symbol_count].name = strdup(name);
    symbol_table[symbol_count].value = 0;
    symbol_table[symbol_count].initialized = 0;
    return symbol_count++;
}
