#ifndef SYMBOL_H
#define SYMBOL_H

#define MAX_SYMBOLS 100  // Maximum number of symbols

// Symbol structure to hold variable information
typedef struct {
    char* name;
    int value;
    int initialized;  // Flag indicating if the variable has been assigned a value
} Symbol;

// The symbol table and a counter for the number of symbols
extern Symbol symbol_table[MAX_SYMBOLS];
extern int symbol_count;

// Function declarations
int find_symbol(const char* name);
int add_symbol(const char* name);

#endif  // SYMBOL_H
