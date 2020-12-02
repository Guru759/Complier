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

#ifndef YY_YY_SRC_MAIN_TAB_H_INCLUDED
# define YY_YY_SRC_MAIN_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IDENTIFIER = 258,
    INTEGER = 259,
    CHARS = 260,
    BOOL = 261,
    STRINGS = 262,
    TRUE = 263,
    FALSE = 264,
    K_SKIP = 265,
    K_WHILE = 266,
    K_DO = 267,
    K_FOR = 268,
    K_IF = 269,
    K_ELSE = 270,
    K_RETURN = 271,
    F_SCANF = 272,
    F_PRINTF = 273,
    T_CHAR = 274,
    T_INT = 275,
    T_STRING = 276,
    T_BOOL = 277,
    LOP_ADD = 278,
    LOP_SUB = 279,
    LOP_MUL = 280,
    LOP_DIV = 281,
    LOP_AND = 282,
    LOP_OR = 283,
    LOP_NOT = 284,
    LOP_EQ = 285,
    LOP_LT = 286,
    LOP_LE = 287,
    LOP_GT = 288,
    LOP_GE = 289,
    LOP_NE = 290,
    LOP_ASSIGN = 291,
    SEMI = 292,
    LP = 293,
    RP = 294,
    LB = 295,
    RB = 296,
    LC = 297,
    RC = 298,
    COMMA = 299,
    MINUS = 300,
    PLUS = 301
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_SRC_MAIN_TAB_H_INCLUDED  */
