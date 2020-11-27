unit Unit3;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.ConsoleUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  MVCFrameWork.SQLGenerators.Sqlite, ACBrBase, ACBrSocket, ACBrIBPTax;

type
  TDataModule3 = class(TDataModule)
    FDConnection1: TFDConnection;
    ACBrIBPTax1: TACBrIBPTax;
    procedure DataModuleCreate(Sender: TObject);
  private
      { Private declarations }
  public
      { Public declarations }
  end;

var
  DataModule3: TDataModule3;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

procedure TDataModule3.DataModuleCreate(Sender: TObject);
begin
  ACBrIBPTax1.AbrirTabela(ExtractFilePath(ParamStr(0))+'TabelaIBPTaxSC20.2.C.csv');
//  RemoveDataModule(Self);

end;

end.
