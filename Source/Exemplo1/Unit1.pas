unit Unit1;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons,
  MVCFramework.ActiveRecord,
  System.Generics.Collections;

type

  [ MVCPath('/api') ]
  TMyController = class(TMVCController)
  public
    [ MVCPath ]
    [ MVCHTTPMethod([ httpGET ]) ]
    procedure Index;

  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;

  public
      //Sample CRUD Actions for a "Customer" entity
    [ MVCPath('/artistas') ]
    [ MVCHTTPMethod([ httpGET ]) ]
    procedure GetArtistas;

    [ MVCPath('/artistas/($id)') ]
    [ MVCHTTPMethod([ httpGET ]) ]
    procedure GetArtista(id: Integer);

    [ MVCPath('/artistas') ]
    [ MVCHTTPMethod([ httpPOST ]) ]
    procedure CreateArtista;

    [ MVCPath('/artistas/($id)') ]
    [ MVCHTTPMethod([ httpPUT ]) ]
    procedure UpdateArtista(id: Integer);

    [ MVCPath('/artistas/($id)') ]
    [ MVCHTTPMethod([ httpDELETE ]) ]
    procedure DeleteArtista(id: Integer);


    constructor Create;override;
    destructor Destroy;override;
  end;

implementation

uses
  System.SysUtils,
  MVCFramework.Logger,
  System.StrUtils,
  EntitiesU, Unit3;

procedure TMyController.Index;
begin
    //use Context property to access to the HTTP request and response
  Render('Hello DelphiMVCFramework World');
end;

procedure TMyController.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
    { Executed after each action }
  inherited;
end;

procedure TMyController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
    { Executed before each action
      if handled is true (or an exception is raised) the actual
     action will not be called }
  inherited;
end;

procedure TMyController.GetArtistas;
var
  LArtistas: TObjectList<TArtist>;
begin
  LArtistas := TMVCActiveRecord.All<TArtist>;

  Render<TArtist>(LArtistas);
end;

procedure TMyController.GetArtista(id: Integer);
var
  LArtista : TArtist;
begin
  LArtista := TMVCActiveRecord.GetByPK<TArtist>(id);

  Render(LArtista);
end;

constructor TMyController.Create;
begin
  inherited;
  DataModule3 := TDataModule3.Create(nil);

  ActiveRecordConnectionsRegistry.AddDefaultConnection(DataModule3.FDConnection1);

end;

procedure TMyController.CreateArtista;
var
  LArtista : TArtist;
begin
  LArtista := Context.Request.BodyAs<TArtist>;

  LArtista.Insert;

  Render(201, LArtista);
end;

procedure TMyController.UpdateArtista(id: Integer);
var
  LArtista :TArtist;
begin
  LArtista := Context.Request.BodyAs<TArtist>;
  LArtista.Artistid := id;

  LArtista.Update;

  Render(LArtista);
end;

procedure TMyController.DeleteArtista(id: Integer);
var
  LArtista :TArtist;
begin
  LArtista := TMVCActiveRecord.GetByPK<TArtist>(id);

  if Assigned(LArtista) then
  begin
    LArtista.Delete;
    Render(200,'Apagado');
  end
  else
    Render(404,'Artista não encontrado.');
end;

destructor TMyController.Destroy;
begin

  ActiveRecordConnectionsRegistry.RemoveDefaultConnection;
//  DataModule3.Free;
  inherited;
end;

end.
