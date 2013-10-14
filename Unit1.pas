unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, mysql,
  Dialogs, ComCtrls, StdCtrls, Menus, ExtCtrls, fonctions, Grids, CheckLst;

type
  TForm1 = class(TForm)
    pc1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet4: TTabSheet;
    Timer1: TTimer;
    TabSheet6: TTabSheet;
    MainMenu1: TMainMenu;
    Edition1: TMenuItem;
    Application1: TMenuItem;
    Quitter1: TMenuItem;
    Chambres1: TMenuItem;
    Clients1: TMenuItem;
    Accueil1: TMenuItem;
    Factures1: TMenuItem;
    Rservations1: TMenuItem;
    Statistiques1: TMenuItem;
    PageControl2: TPageControl;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    PageControl3: TPageControl;
    TabSheet12: TTabSheet;
    Parametres1: TMenuItem;
    Aide1: TMenuItem;
    APropos1: TMenuItem;
    StringGrid1: TStringGrid;
    ListBox2: TListBox;
    Button1: TButton;
    StringGrid2: TStringGrid;
    Button2: TButton;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit7: TEdit;
    Edit10: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    CheckBox1: TCheckBox;
    date_entree: TDateTimePicker;
    ComboBox1: TComboBox;
    CheckListBox1: TCheckListBox;
    Button3: TButton;
    Label4: TLabel;
    StringGrid3: TStringGrid;
    Button5: TButton;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    procedure init_chambres;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure Accueil1Click(Sender: TObject);
    procedure Chambres1Click(Sender: TObject);
    procedure Clients1Click(Sender: TObject);
    procedure Factures1Click(Sender: TObject);
    procedure Rservations1Click(Sender: TObject);
    procedure Statistiques1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    mysql:PMySql;
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit3;

CONST dbname='hotel';
var activer, activer1:boolean;
    Resultat: PMYSQL_RES;
    row: PMYSQL_ROW;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  tabsheet1.TabVisible:=false;
  tabsheet2.TabVisible:=false;
  tabsheet3.TabVisible:=false;
  tabsheet4.TabVisible:=false;
  tabsheet5.TabVisible:=false;
  tabsheet6.TabVisible:=true;
  activer:=true;
  activer1:=true;
  init_chambres;
end;

procedure TForm1.init_chambres;
var i:integer;
begin
  listbox2.Clear;
  combobox3.Clear;

  listbox2.Items.Add('des Chambres');
  listbox2.Items.Add('Les Chambres Libres');
  listbox2.Items.Add('Les Chambres Reservees');
  listbox2.Items.Add('Les Chambres Occupees');

  stringgrid1.Cells[0,0]:='Chambres';
  stringgrid1.Cells[1,0]:='Categories';
  stringgrid1.Cells[2,0]:='Etats';

  MySQL := mysql_init(nil);
  mysql_options(mysql,MYSQL_OPT_COMPRESS,0);
  mysql_real_connect(mysql, 'localhost', 'root', '', nil , 0, nil, 0);

  mysql_select_db(mysql, pChar('hotel'));
  mysql_query(mysql, pChar('SELECT * FROM categories'));
  Resultat:=mysql_use_result(MySQL);
  row:= mysql_fetch_row(Resultat);
  combobox3.Text:=row[0];
  while row<>nil do
  begin
    listbox2.Items.Add('Les Chambres '+row[0]);
    combobox3.Items.Add(row[0]);
    row:= mysql_fetch_row(Resultat);
  end;

  mysql_query(mysql, pChar('SELECT * FROM chambres'));
  Resultat:=mysql_use_result(MySQL);
  row:= mysql_fetch_row(Resultat);
  i:=0;
  while row<>nil do
  begin
    inc(i);
    Stringgrid1.Cells[0,i]:=row[0];
    Stringgrid1.Cells[1,i]:=row[1];
    if row[2]='L' then Stringgrid1.Cells[2,i]:='Libre';
    if row[2]='O' then Stringgrid1.Cells[2,i]:='Occupee';
    if row[2]='R' then Stringgrid1.Cells[2,i]:='Reservee';
    row:= mysql_fetch_row(Resultat);
  end;
  stringgrid1.RowCount:=i+1;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  form1.Caption:='Gestion d''hotel (scicasoft & falysoft)  *  '+DateToStr(date)+'    '+Timetostr(time);;
end;

procedure TForm1.Quitter1Click(Sender: TObject);
begin
  mysql_close(MySQL);
  close;
end;

procedure TForm1.Accueil1Click(Sender: TObject);
begin
  tabsheet1.TabVisible:=false;
  tabsheet2.TabVisible:=false;
  tabsheet3.TabVisible:=false;
  tabsheet4.TabVisible:=false;
  tabsheet5.TabVisible:=false;
  tabsheet6.TabVisible:=true;
end;

procedure TForm1.Chambres1Click(Sender: TObject);
begin
  tabsheet1.TabVisible:=true;
  tabsheet2.TabVisible:=false;
  tabsheet3.TabVisible:=false;
  tabsheet4.TabVisible:=false;
  tabsheet5.TabVisible:=false;
  tabsheet6.TabVisible:=false;
end;

procedure TForm1.Clients1Click(Sender: TObject);
begin
  tabsheet1.TabVisible:=false;
  tabsheet2.TabVisible:=false;
  tabsheet3.TabVisible:=true;
  tabsheet4.TabVisible:=false;
  tabsheet5.TabVisible:=false;
  tabsheet6.TabVisible:=false;
end;

procedure TForm1.Factures1Click(Sender: TObject);
begin
  tabsheet1.TabVisible:=false;
  tabsheet2.TabVisible:=false;
  tabsheet3.TabVisible:=false;
  tabsheet4.TabVisible:=true;
  tabsheet5.TabVisible:=false;
  tabsheet6.TabVisible:=false;
end;

procedure TForm1.Rservations1Click(Sender: TObject);
begin
  tabsheet1.TabVisible:=false;
  tabsheet2.TabVisible:=true;
  tabsheet3.TabVisible:=false;
  tabsheet4.TabVisible:=false;
  tabsheet5.TabVisible:=false;
  tabsheet6.TabVisible:=false;
end;

procedure TForm1.Statistiques1Click(Sender: TObject);
begin
  tabsheet1.TabVisible:=false;
  tabsheet2.TabVisible:=false;
  tabsheet3.TabVisible:=false;
  tabsheet4.TabVisible:=false;
  tabsheet5.TabVisible:=true;
  tabsheet6.TabVisible:=false;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  MySQL := mysql_init(nil);
  mysql_options(mysql,MYSQL_OPT_COMPRESS,0);
  if mysql_real_connect(mysql, 'localhost', 'root', '', nil , 0, nil, 0)=nil  then
  begin
    showmessage('LA CONNECTION A LA BASE A ECHOUE VEUILLEZ LANCER LE SERVEUR LOCAL');
    close;
  end
  else
  begin
    if mysql_select_db(mysql, pChar(dbname)) <> 0 then
    begin
      showmessage('IL FAUT CREER LA BASE');
      close;
    end
    else
      if activer then
      begin
        mysql_query(mysql, pChar('SELECT * FROM informations'));
        Resultat:=mysql_use_result(MySQL);
        row:= mysql_fetch_row(Resultat);
        if Row = nil then
        begin
            form2:=tform2.Create(Application);
            activer:=false;
        end;
      end;
  end;
end;

procedure TForm1.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  button1.Caption:='Modifier Categorie Chambre '+stringgrid1.Cells[0,arow];
end;

procedure TForm1.Button1Click(Sender: TObject);
var ech:string;
begin
  ech:=stringgrid1.Cells[0,stringgrid1.Row];
  mysql_select_db(mysql, pChar('hotel'));
  mysql_query(mysql, pChar('UPDATE chambres set classe="'+pchar(combobox3.Text)+'" where num_chambre="'+pchar(ech)+'"'));
  init_chambres;
end;

procedure TForm1.ListBox2Click(Sender: TObject);
var i:integer;
    ech:String;
begin
  MySQL := mysql_init(nil);
  mysql_options(mysql,MYSQL_OPT_COMPRESS,0);
  mysql_real_connect(mysql, 'localhost', 'root', '', nil , 0, nil, 0);
  mysql_select_db(mysql, pChar('hotel'));
  case listbox2.ItemIndex of
    0:mysql_query(mysql, pChar('SELECT * FROM chambres'));
    1:mysql_query(mysql, pChar('SELECT * FROM chambres where etat="L"'));
    2:mysql_query(mysql, pChar('SELECT * FROM chambres where etat="R"'));
    3:mysql_query(mysql, pChar('SELECT * FROM chambres where etat="O"'));
  end;

  if listbox2.ItemIndex>3 then
  begin
    ech:=listbox2.Items.strings[listbox2.ItemIndex];
    mysql_query(mysql, pChar('SELECT * FROM chambres where classe="'+pchar(copy(ech,14,length(ech)))+'"'));
  end;

  Resultat:=mysql_use_result(MySQL);
  row:= mysql_fetch_row(Resultat);
  i:=0;
  while row<>nil do
  begin
    inc(i);
    Stringgrid1.Cells[0,i]:=row[0];
    Stringgrid1.Cells[1,i]:=row[1];
    if row[2]='L' then Stringgrid1.Cells[2,i]:='Libre';
    if row[2]='O' then Stringgrid1.Cells[2,i]:='Occupee';
    if row[2]='R' then Stringgrid1.Cells[2,i]:='Reservee';
    row:= mysql_fetch_row(Resultat);
  end;
  if i=0 then
  begin
    i:=1;
    stringgrid1.Cells[0,1]:='';
    stringgrid1.Cells[1,1]:='';
    stringgrid1.Cells[2,1]:='';
  end;
    stringgrid1.RowCount:=i+1;
    stringgrid1.FixedRows:=1;
end;

end.
