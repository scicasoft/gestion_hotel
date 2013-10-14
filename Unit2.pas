unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, mysql,
  Dialogs, StdCtrls, Grids, jpeg, ExtCtrls, fonctions, CheckLst;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    nom: TEdit;
    niveau: TEdit;
    label2: TLabel;
    Label3: TLabel;
    chambre: TEdit;
    Image1: TImage;
    StringGrid2: TStringGrid;
    Button3: TButton;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Button5: TButton;
    Button6: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label9: TLabel;
    Label4: TLabel;
    StringGrid1: TStringGrid;
    Label5: TLabel;
    CheckListBox1: TCheckListBox;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    CheckListBox2: TCheckListBox;
    Button7: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    mysql:PMySql;
  end;

var
  Form2: TForm2;

implementation

uses unit1, Unit3;

var j:integer;

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  stringgrid1.Cells[0,0]:='SERVICES ANNEXES';
  stringgrid2.Cells[0,0]:='CLASSES';
  stringgrid2.Cells[1,0]:='TARIFS NORMALS';
  stringgrid2.Cells[2,0]:='TARIFS SPECIALS';
  button7.Enabled:=false;
  stringgrid1.RowCount:=10;
  stringgrid2.RowCount:=10;
  j:=0;
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
  form1.Close;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  if (edit3.Text<>'') and isnumber(edit4.Text) and isnumber(edit5.Text) then
  begin
    inc(j);
    stringgrid2.Cells[0,j]:=edit3.Text;
    stringgrid2.Cells[1,j]:=edit4.Text;
    stringgrid2.Cells[2,j]:=edit5.Text;
  end
  else
    showmessage('VERIFIER LES TARIFS');
  edit3.Text:='';
  edit4.Text:='';
  edit5.Text:='';
end;

procedure TForm2.Button5Click(Sender: TObject);
var i:integer;
    tempon, ech:String;
    ok:boolean;
begin
  ok:=false;
  if not isnumber(niveau.Text) or not isnumber(chambre.Text) then
  begin
    showmessage('VERIFIER LE NOMBRE DE CHAMBRE ET LE NOMBRE DE NIVEAU');
    niveau.Text:='';
    chambre.Text:='';
  end
  else
    if (stringgrid1.Cells[0,1]='') or (j=0) then
      showmessage('IL FAUT ENTRER AU MOINS UNE CLASSE ET UN SERVICE SPECIAL')
    else
    begin
      MySQL := mysql_init(nil);
      mysql_options(mysql,MYSQL_OPT_COMPRESS,0);
      mysql_real_connect(mysql, 'localhost', 'root', '', nil , 0, nil, 0);
      mysql_select_db(mysql, pchar('hotel'));
      mysql_query(mysql, pChar('INSERT INTO informations VALUES ("'+pchar(nom.Text)+'", '+pchar(niveau.text)+', '+pchar(chambre.Text)+')'));
      ok:=true;
    end;
  i:=1;
  tempon:=stringgrid1.Cells[0,i];
  mysql_select_db(mysql, pchar('hotel'));
  mysql_query(mysql, pchar('delete from services_annexes'));
  while tempon<>'' do
  begin
    mysql_query(mysql, pchar('INSERT INTO services_annexes VALUES ("'+pchar(tempon)+'")'));
    inc(i);
    tempon:=stringgrid1.Cells[0,i];
  end;
  combobox1.Text:=stringgrid2.Cells[0,1];
  mysql_select_db(mysql, pchar('hotel'));
  mysql_query(mysql, pchar('delete from categories'));
  for i:=1 to j do
  begin
    mysql_query(mysql, pchar('INSERT INTO categories VALUES ("'+pchar(stringgrid2.Cells[0,i])+'",'+pchar(stringgrid2.Cells[1,i])+','+pchar(stringgrid2.Cells[2,i])+')'));
    combobox1.Items.Add(stringgrid2.Cells[0,i]);
  end;
  if ok then
  begin
    for i:=1 to strtoint(niveau.Text) do
      for j:=1 to strtoint(chambre.Text) do
      begin
        if i-1 <10 then tempon:='0'+inttostr(i-1)
        else tempon:=inttostr(i-1);
        if j<10 then ech:='00'+inttostr(j);
        if j in [10..99] then ech:='0'+inttostr(j);
        if j>99 then ech:=inttostr(j);
        tempon:=tempon+ech;
        checklistbox1.Items.Add(tempon);
      end;
    button5.Enabled:=false;
    button7.Enabled:=true;
  end;
end;

procedure TForm2.Button1Click(Sender: TObject);
var i,max:integer;
begin
  max:=checklistbox1.Items.Count;
  for i:=0 to max-1 do
  begin
    if checklistbox1.Checked[i] then checklistbox2.Items.Add(checklistbox1.Items.Strings[i]+' : '+combobox1.Text);
  end;
  i:=0;
  while i<checklistbox1.Items.Count do
  begin
    if checklistbox1.Checked[i] then
    begin
      checklistbox1.Items.Delete(i);
      dec(i);
    end;
    inc(i);
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var i,max:integer;
    ech:String;
begin
  max:=checklistbox2.Items.Count;
  for i:=0 to max-1 do
  begin
    ech:=copy(checklistbox2.Items.Strings[i],1,5);
    if checklistbox2.Checked[i] then checklistbox1.Items.Add(ech);
  end;
  i:=0;
  while i<checklistbox2.Items.Count do
  begin
    if checklistbox2.Checked[i] then
    begin
      checklistbox2.Items.Delete(i);
      dec(i);
    end;
    inc(i);
  end;
end;

procedure TForm2.Button4Click(Sender: TObject);
var i:integer;
    num, classe:String;
begin
  if checklistbox1.Items.Count=0 then
    showmessage('LES TRANFERTS NE SONT PAS TERMINES')
  else
  begin
    mysql_select_db(mysql, pChar('hotel'));
    for i:=0 to checklistbox2.Items.Count - 1 do
    begin
      num:=copy(checklistbox2.Items.Names[i],1,5);
      classe:=copy(checklistbox2.Items.Names[i],9,length(checklistbox2.Items.Names[i]));
      mysql_query(mysql, pChar('INSERT INTO chambres VALUES ("'+num+'","'+classe+'","L")'));
    end;
  end;
end;

procedure TForm2.Button7Click(Sender: TObject);
var i:integer;
    num, classe:String;
begin
  if checklistbox1.Items.Count<>0 then
    showmessage('LES TRANFERTS NE SONT PAS TERMINES')
  else
  begin
    mysql_select_db(mysql, pChar('hotel'));
    mysql_query(mysql, pChar('DELETE from chambres'));
    for i:=0 to checklistbox2.Items.Count - 1 do
    begin
      num:=copy(checklistbox2.Items.Strings[i],1,5);
      classe:=copy(checklistbox2.Items.Strings[i],9,length(checklistbox2.Items.Strings[i]));
      mysql_query(mysql, pChar('INSERT INTO chambres VALUES ("'+num+'","'+classe+'","L")'));
    end;
    form2.Close;
  end;
end;

end.
