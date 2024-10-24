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
    IF = 258,                      /* IF  */
    BYE = 259,                     /* BYE  */
    THEN = 260,                    /* THEN  */
    ELSE = 261,                    /* ELSE  */
    ENDIF = 262,                   /* ENDIF  */
    PRINT = 263,                   /* PRINT  */
    NEWLINE = 264,                 /* NEWLINE  */
    SEMICOLON = 265,               /* SEMICOLON  */
    EQU = 266,                     /* EQU  */
    LESSER = 267,                  /* LESSER  */
    GREATER = 268,                 /* GREATER  */
    LE = 269,                      /* LE  */
    GE = 270,                      /* GE  */
    NE = 271,                      /* NE  */
    PLUS = 272,                    /* PLUS  */
    MINUS = 273,                   /* MINUS  */
    MULT = 274,                    /* MULT  */
    DIV = 275,                     /* DIV  */
    LPEREN = 276,                  /* LPEREN  */
    RPEREN = 277,                  /* RPEREN  */
    ASSIGN = 278,                  /* ASSIGN  */
    STRING_LITERAL = 279,          /* STRING_LITERAL  */
    INTEGER = 280,                 /* INTEGER  */
    ID = 281                       /* ID  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define IF 258
#define BYE 259
#define THEN 260
#define ELSE 261
#define ENDIF 262
#define PRINT 263
#define NEWLINE 264
#define SEMICOLON 265
#define EQU 266
#define LESSER 267
#define GREATER 268
#define LE 269
#define GE 270
#define NE 271
#define PLUS 272
#define MINUS 273
#define MULT 274
#define DIV 275
#define LPEREN 276
#define RPEREN 277
#define ASSIGN 278
#define STRING_LITERAL 279
#define INTEGER 280
#define ID 281

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 11 "interpreter.y"

    int int_val;       // For integer values
    char* strval;      // For string literals
    int sym_index;     // For symbol table indices

#line 125 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
