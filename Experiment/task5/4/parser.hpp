/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
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
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_PARSER_HPP_INCLUDED
# define YY_YY_PARSER_HPP_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    K_ELSE = 258,
    K_IF = 259,
    K_RETURN = 260,
    K_WHILE = 261,
    K_PRINTF = 262,
    K_READ = 263,
    K_INT = 264,
    K_VOID = 265,
    ID = 266,
    NUM = 267,
    O_ASSIGN = 268,
    O_COMMA = 269,
    O_SEMI = 270,
    O_LSBRACKER = 271,
    O_RSBRACKER = 272,
    O_LMBRACKER = 273,
    O_RMBRACKER = 274,
    O_LLBRACKER = 275,
    O_RLBRACKER = 276,
    O_ADD = 277,
    O_SUB = 278,
    O_MUL = 279,
    O_DIV = 280,
    O_LESS = 281,
    O_L_EQUAL = 282,
    O_GREATER = 283,
    O_G_EQUAL = 284,
    O_EQUAL = 285,
    O_U_EQUAL = 286,
    COMMENT = 287,
    SPACES = 288,
    U_LEGAL = 289,
    U_neg = 290
  };
#endif
/* Tokens.  */
#define K_ELSE 258
#define K_IF 259
#define K_RETURN 260
#define K_WHILE 261
#define K_PRINTF 262
#define K_READ 263
#define K_INT 264
#define K_VOID 265
#define ID 266
#define NUM 267
#define O_ASSIGN 268
#define O_COMMA 269
#define O_SEMI 270
#define O_LSBRACKER 271
#define O_RSBRACKER 272
#define O_LMBRACKER 273
#define O_RMBRACKER 274
#define O_LLBRACKER 275
#define O_RLBRACKER 276
#define O_ADD 277
#define O_SUB 278
#define O_MUL 279
#define O_DIV 280
#define O_LESS 281
#define O_L_EQUAL 282
#define O_GREATER 283
#define O_G_EQUAL 284
#define O_EQUAL 285
#define O_U_EQUAL 286
#define COMMENT 287
#define SPACES 288
#define U_LEGAL 289
#define U_neg 290

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 70 "parser.y"

    int type;
    char * code;
    int addr;
    Node * node;

#line 134 "parser.hpp"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;
extern YYLTYPE yylloc;
int yyparse (void);

#endif /* !YY_YY_PARSER_HPP_INCLUDED  */
