grammar Niklaus;

options { output = AST ; 	}

expr	:	term (ADDOP^ term)*;

term	:	factor (MULTOP^ factor)*;

factor	:	ID | INT | ( '('! expr ')'! );

read_var 	:	READ^ ID';'! ;

write_exp 	:	WRITE^ expr';'! ;

instruction:		(write_exp|read_var|condition|affectation|comparaison|loop)*;

affectation 
	:	ID EGAL^ expr';'! ;
program 
	:	PROGRAM^ ID ';'!  declaration?  '{'! instruction '}'! ; 

comparaison
	:	 expr SIGNE^ expr;
	
condition 	:	IF^ '(' comparaison ')' '{'! instruction '}'! ELSE '{'! instruction '}'!;

loop	:	WHILE^ '('! comparaison ')'! '{'! instruction '}'!;

declaration 	:	 VAR^ ( ID ','! )* ID ';'! ; 

SIGNE 	:	 '<' | '>' | '<>' | '<='|'>=' |'=';

READ	: 'read';
VAR	:	 'var';

WRITE 	: 'write';

EGAL 	:':=';

WHILE 	:'while';

IF	:'if';

ELSE	:'else';

INT :	'0'..'9'+
    ;
    PROGRAM 
    	:	'program';

COMMENT
    :   '//' ~('\n'|'\r')* '\r'? '\n' {$channel=HIDDEN;}
    ;

WS  :   ( ' '
        | '\t'
        | '\r'
        | '\n'
        ) {$channel=HIDDEN;}
    ;

ADDOP	:	'+' | '-' | 'mod' ;

MULTOP	:	'*' | '/';

ID  :	('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*;