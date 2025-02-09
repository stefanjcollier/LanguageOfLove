/* File Parser.mly */
%{
	open Path
%}

%token <string> WORD
%token EXP_END EOL PROG_END
%token LCURL RCURL EMPTY_SET COMMA
%token CONCAT
%token UNION INTERSECT SUBTRACT
%token OUTPUT 

%left CONCAT UNION INTERSECT SUBTRACT
%start main
%type <Path.program> main
%%

main: prog PROG_END EOL { $1 }
;

prog:
 | expr EXP_END EOL { $1 }
 | expr EXP_END EOL prog { Statements( $1, $4) }
 | expr EXP_END prog { Statements( $1, $3) }
;

expr : 
 | languageExpr 		{ Statement($1) }
 | wordExpr 			{ WStatement($1) }
 | OUTPUT languageExpr { Output($2) }
;

languageExpr :
 | LCURL langbody RCURL 		{ LangLiteral($2) }
 | EMPTY_SET					{ LangLiteral(Empty_Set) }
 | languageExpr UNION languageExpr { Union($1, $3) }
 | languageExpr INTERSECT languageExpr { Union($1, $3) }
 | languageExpr SUBTRACT languageExpr { Union($1, $3) }
;

langbody :
 | wordExpr					{ Cons ($1, Empty_Set)}
 | wordExpr COMMA langbody	{ Cons ($1, $3)}
;

wordExpr: 
 | WORD { $1 }
 | wordExpr CONCAT wordExpr { $1^$3 }
;

