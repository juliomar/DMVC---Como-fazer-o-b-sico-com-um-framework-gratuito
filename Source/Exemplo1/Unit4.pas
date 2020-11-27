unit Unit4;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons,
  ACBrIBPTax;

type

  [ MVCPath('/ibpt') ]
  TIPBTController = class(TMVCController)
  public
    [ MVCPath('/sc') ]
    [ MVCHTTPMethod([ httpGET ]) ]
    procedure GetSC;

    [ MVCPath('/sc/($id)') ]
    [ MVCHTTPMethod([ httpGET ]) ]
    procedure GetSCUnico(id: string);

    constructor Create;override;
    destructor Destroy;override;
  end;

implementation

uses
  System.SysUtils,
  MVCFramework.Logger,
  System.StrUtils, Unit3, System.Generics.Collections;

  { TIPBTController }

constructor TIPBTController.Create;
begin
  inherited;
  DataModule3 := TDataModule3.Create(nil);
end;

destructor TIPBTController.Destroy;
begin

  inherited;
end;

procedure TIPBTController.GetSCUnico(id: string);
var
  Libpt : TACBrIBPTaxRegistro;
  ex, descricao: String;
  tabela: Integer;
  aliqFedNac, aliqFedImp, aliqEstadual,
      aliqMunicipal: Double ;

begin
  DataModule3.ACBrIBPTax1.Procurar(id,ex, descricao,tabela,aliqFedNac, aliqFedImp, aliqEstadual,
      aliqMunicipal );

  Libpt := TACBrIBPTaxRegistro.Create;
  Libpt.NCM := id;
  Libpt.Descricao := descricao;
  Libpt.Excecao := ex;
  Libpt.Tabela := TACBrIBPTaxTabela(tabela);
  Libpt.FederalNacional := aliqFedNac;
  Libpt.FederalImportado := aliqFedImp;
  Libpt.Estadual := aliqEstadual;
  Libpt.Municipal := aliqMunicipal;

  Render(Libpt);
end;

procedure TIPBTController.GetSC;
var
  LIbpt : TObjectList<TACBrIBPTaxRegistro>;
begin
  LIbpt := DataModule3.ACBrIBPTax1.Itens;

  Render<TACBrIBPTaxRegistro>(LIbpt);
end;

end.
