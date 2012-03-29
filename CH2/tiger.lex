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
","	=> (Tokens.COMMA(yypos,yypos+1));
type    => (Tokens.TYPE(yypos,yypos+4));
var  	=> (Tokens.VAR(yypos,yypos+3));
function => (Tokens.FUNCTION(yypos,yypos+8));
break   => (Tokens.BREAK(yypos,yypos+5));
of      => (Tokens.OF(yypos,yypos+2));
end     => (Tokens.END(yypos,yypos+3));
"123"	=> (Tokens.INT(123,yypos,yypos+3));

.       => (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());

