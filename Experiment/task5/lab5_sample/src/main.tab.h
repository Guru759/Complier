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
    T_VOID = 278,
    LOP_ADD = 279,
    LOP_SUB = 280,
    LOP_MUL = 281,
    LOP_DIV = 282,
    LOP_REM = 283,
    LOP_AND = 284,
    LOP_OR = 285,
    LOP_NOT = 286,
    LOP_EQ = 287,
    LOP_LT = 288,
    LOP_LE = 289,
    LOP_GT = 290,
    LOP_GE = 291,
    LOP_NE = 292,
    LOP_ASSIGN = 293,
    LOP_ADDA = 294,
    LOP_SUBA = 295,
    LOP_ADAD = 296,
    LOP_SBSB = 297,
    SEMI = 298,
    LP = 299,
    RP = 300,
    LB = 301,
    RB = 302,
    LC = 303,
    RC = 304,
    COMMA = 305,
    MINUS = 306,
    PLUS = 307,
    LOWER_THEN_ELSE = 308
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
