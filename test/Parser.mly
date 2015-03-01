/* File Parser.mly */
%{
	open Path
%}

%token <string> WORD
%token CONCAT EXP_END EOL PROG_END
%left CONCAT
%start main
%type <Path.results> main
%%
/*
main: prog PROG_END EOL { $1 }
;

prog:  
| wordExpr EXP_END EOL { $1 }
| wordExpr EXP_END EOL prog { $1 ^"\n" ^ $4 }
| wordExpr EXP_END prog { $1 ^"\n"^ $3 }
;

wordExpr: 
| WORD { $1 }
| wordExpr CONCAT wordExpr { $1^$3 }
;
*/

main : prog PROG_END EOL { $1 }
;

prog:  
| wordExpr EXP_END EOL { Word($1) }
| wordExpr EXP_END EOL prog { MoreWords( Word($1), $4) }
| wordExpr EXP_END prog { MoreWords( Word($1), $3) }
;
wordExpr: 
| WORD { $1 }
| wordExpr CONCAT wordExpr { $1^$3 }
;
/**/
