type pos = int
type lexresult = Tokens.token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
fun err(p1,p2) = ErrorMsg.error p1

fun eof() = let val pos = hd(!linePos) in Tokens.EOF(pos,pos) end

digits = [0-9]+

%% 
%%
\n	=> (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
\t      => (linePos := yypos+2;continue());
type    => (Tokens.TYPE(yypos,yypos+4));
var  	=> (Tokens.VAR(yypos,yypos+3));
function => (Tokens.FUNCTION(yypos,yypos+8));
break   => (Tokens.BREAK(yypos,yypos+5));
of      => (Tokens.OF(yypos,yypos+2));
end     => (Tokens.END(yypos,yypos+3));
in      => (Tokens.IN(yypos,yypos+2));
nil     => (Tokens.NIL(yypos,yypos+3));
let     => (Tokens.LET(yypos,yypos+3));
do      => (Tokens.DO(yypos,yypos+2));
to      => (Tokens.TO(yypos,yypos+2));
for     => (Tokens.FOR(yypos,yypos+3));
while   => (Tokens.WHILE(yypos,yypos+5));
else    => (Tokens.ELSE(yypos,yypos+4));
then    => (Tokens.THEN(yypos,yypos+4));
if      => (Tokens.IF(yypos,yypos+2));
array   => (Tokens.ARRAY(yypos,yypos+5));
":="      => (Tokens.ASSIGN(yypos,yypos+6));
or      => (Tokens.OR(yypos,yypos+2));
and     => (Tokens.AND(yypos,yypos+3));
ge      => (Tokens.GE(yypos,yypos+2));
gt      => (Tokens.GT(yypos,yypos+2));
le      => (Tokens.LE(yypos,yypos+2));
lt      => (Tokens.LT(yypos,yypos+2));
neq     => (Tokens.NEQ(yypos,yypos+3));
eq      => (Tokens.EQ(yypos,yypos+2));
divide  => (Tokens.DIVIDE(yypos,yypos+6));
times   => (Tokens.TIMES(yypos,yypos+5));
minus   => (Tokens.MINUS(yypos,yypos+5));
plus    => (Tokens.PLUS(yypos,yypos+4));
"."     => (Tokens.DOT(yypos,yypos+3));
"}"       => (Tokens.RBRACE(yypos,yypos+1));
"{"       => (Tokens.LBRACE(yypos,yypos+1));
"]"       => (Tokens.RBRACK(yypos,yypos+1));
"["       => (Tokens.LBRACK(yypos,yypos+1));
")"       => (Tokens.RPAREN(yypos,yypos+1));
"("       => (Tokens.LPAREN(yypos,yypos+1));
";"       => (Tokens.SEMICOLON(yypos,yypos+1));
":"       => (Tokens.COLON(yypos,yypos+1));
","       => (Tokens.COMMA(yypos,yypos+1));
(\" [a-zA-Z0-9]* \")  => (Tokens.STRING(x,yypos,yypos+x.length));
{digits}  => (Tokens.INT(Int.fromString yytext,yypos,yypos+size yytext));
[a-zA-Z_] [a-zA-Z_0-9]*  => (Tokens.ID(yytext,yypos,yypos+size yytext);
\z      => (eof());
("/*" [a-zA-Z0-9]* "*/") => (continue());
.       => (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());

