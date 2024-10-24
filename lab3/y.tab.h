/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    STRING_LITERAL = 258,          /* STRING_LITERAL  */
    IF = 259,                      /* IF  */
    BYE = 260,                     /* BYE  */
    THEN = 261,                    /* THEN  */
    ELSE = 262,                    /* ELSE  */
    ENDIF = 263,                   /* ENDIF  */
    PRINT = 264,                   /* PRINT  */
    NEWLINE = 265,                 /* NEWLINE  */
    SEMICOLON = 266,               /* SEMICOLON  */
    EQU = 267,                     /* EQU  */
    LESSER = 268,                  /* LESSER  */
    GREATER = 269,                 /* GREATER  */
    LE = 270,                      /* LE  */
    GE = 271,                      /* GE  */
    NE = 272,                      /* NE  */
    PLUS = 273,                    /* PLUS  */
    MINUS = 274,                   /* MINUS  */
    MULT = 275,                    /* MULT  */
    DIV = 276,                     /* DIV  */
    LPEREN = 277,                  /* LPEREN  */
    RPEREN = 278,                  /* RPEREN  */
    ASSIGN = 279,                  /* ASSIGN  */
    ID = 280,                      /* ID  */
    INTEGER = 281                  /* INTEGER  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define STRING_LITERAL 258
#define IF 259
#define BYE 260
#define THEN 261
#define ELSE 262
#define ENDIF 263
#define PRINT 264
#define NEWLINE 265
#define SEMICOLON 266
#define EQU 267
#define LESSER 268
#define GREATER 269
#define LE 270
#define GE 271
#define NE 272
#define PLUS 273
#define MINUS 274
#define MULT 275
#define DIV 276
#define LPEREN 277
#define RPEREN 278
#define ASSIGN 279
#define ID 280
#define INTEGER 281

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 65 "interpreter.y"

    int int_val;  // For integer values
    char* strval; // For string literals and variable names
    struct stmt* stmt_ptr;
    struct stmt_list* stmt_list_ptr;

#line 126 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
