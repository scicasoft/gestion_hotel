unit fonctions;

interface

uses mysql;

function isnumber(chaine:String):boolean;

implementation

function isnumber(chaine:String):boolean;
var a:real;
    b:integer;
begin
  val(chaine,a,b);
  result:=false;
  if a=a then result:=b=0;
end;

procedure remplissage_info(nom,niveau,chambre:string);
var mysql : pmysql;
begin
  mysql_query(mysql, pChar('INSERT INTO info VALUES ("'+pchar(nom)+'", '+pchar(niveau)+', '+pchar(chambre)+')'));
end;

end.
