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
    TRUE = 258,
    FALSE = 259,
    K_SKIP = 260,
    K_WHILE = 261,
    K_DO = 262,
    K_FOR = 263,
    K_IF = 264,
    K_ELSE = 265,
    K_RETURN = 266,
    F_SCANF = 267,
    F_PRINTF = 268,
    T_CHAR = 269,
    T_INT = 270,
    T_STRING = 271,
    T_BOOL = 272,
    LOP_EQ = 273,
    LOP_LT = 274,
    LOP_LE = 275,
    LOP_GT = 276,
    LOP_GE = 277,
    LOP_NE = 278,
    LOP_ASSIGN = 279,
    LOP_ADD = 280,
    LOP_SUB = 281,
    LOP_MUL = 282,
    LOP_DIV = 283,
    LOP_AND = 284,
    LOP_OR = 285,
    LOP_NOT = 286,
    SEMI = 287,
    LP = 288,
    RP = 289,
    LB = 290,
    RB = 291,
    LC = 292,
    RC = 293,
    IDENTIFIER = 294,
    INTEGER = 295,
    CHAR = 296,
    BOOL = 297,
    STRING = 298,
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
