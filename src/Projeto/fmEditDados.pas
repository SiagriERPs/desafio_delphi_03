Unit fmEditDados;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, fmBasico, Db,
  StdCtrls, ExtCtrls, DBCtrls, Mask, Variants,  SqlExpr, Vcl.Buttons;

type
  TfmDataEdit = class(TfmAnyForm)
    bbLocaliza: TBitBtn;
    paBotoes: TPanel;
    bbIncluir: TBitBtn;
    bbAlterar: TBitBtn;
    bbGravar: TBitBtn;
    bbCancelar: TBitBtn;
    procedure LimpaCampos;
    function  VerificaCampos : Boolean;
    procedure AlteraBotoes(Status : Boolean);
    procedure bbIncluirClick(Sender: TObject);
    procedure bbAlterarClick(Sender: TObject);
    procedure bbGravarClick(Sender: TObject);
    procedure bbCancelarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDataEdit: TfmDataEdit;
 
implementation

{$R *.DFM}

{Limpa todos os campos do tipo TEdit}
procedure TfmDataEdit.LimpaCampos;
var
   i : Integer;
begin
  with Screen.Forms[0] do
       for i := ComponentCount - 1 downto 0 do
           if Components[i] is TEdit then
              (Components[i] as TEdit).Clear;
end;

{Verifica os campos obrigatórios (Tag = 1) no Formulário}
function TfmDataEdit.VerificaCampos : Boolean;
var
   i : Integer;
begin
  Result := True;
  with Screen.Forms[0] do
       for i := 0 to ComponentCount - 1 do
           if Components[i].Tag <> 0 then begin
              if Components[i] is TDBEdit then
                 if (Trim((Components[i] as TDBEdit).Text) = '') or (Trim((Components[i] as TDBEdit).Text) = '/  /') then begin
                    Beep;
                    ShowMessage('O campo '+(Components[i] as TDBEdit).Hint+' é obrigatório !!!');
                    (Components[i] as TDBEdit).SetFocus;
                    Result := False;
                    Exit;
                 end;
              if Components[i] is TMaskEdit then
                 if ((Components[i] as TMaskEdit).Text = '  /  /    ') then begin
                    Beep;
                    ShowMessage('O campo '+(Components[i] as TMaskEdit).Hint+' é obrigatório !!!');
                    (Components[i] as TMaskEdit).SetFocus;
                    Result := False;
                    Exit;
                 end;
              if Components[i] is TDBMemo then
                 if ((Components[i] as TDBMemo).Text = '') then begin
                    Beep;
                    ShowMessage('O campo '+(Components[i] as TDBMemo).Hint+' é obrigatório !!!');
                    (Components[i] as TDBMemo).SetFocus;
                    Result := False;
                    Exit;
                 end;
              if Components[i] is TMaskEdit then
                 if ((Components[i] as TMaskEdit).Text = '  :  ') then begin
                    Beep;
                    ShowMessage('O campo '+(Components[i] as TMaskEdit).Hint+' é obrigatório !!!');
                    (Components[i] as TMaskEdit).SetFocus;
                    Result := False;
                    Exit;
                 end;
              if Components[i] is TDBLookupComboBox then
                 if (Components[i] as TDBLookupComboBox).KeyValue = Null then begin
                    Beep;
                    ShowMessage('O campo '+(Components[i] as TDBLookupComboBox).Hint+' é obrigatório !!!');
                    (Components[i] as TDBLookupComboBox).SetFocus;
                    Result := False;
                    Exit;
                 end;
              if Components[i] is TDBCheckBox then
                 if (Components[i] as TDBCheckBox).State = cbGrayed then begin
                    Beep;
                    ShowMessage('O campo '+(Components[i] as TDBCheckBox).Hint+' é obrigatório !!!');
                    (Components[i] as TDBCheckBox).SetFocus;
                    Result := False;
                    Exit;
                 end;
          end;
end;

procedure TfmDataEdit.AlteraBotoes(Status : Boolean);
begin
     bbIncluir.Enabled  := Status;
     bbAlterar.Enabled := Status;
     bbGravar.Enabled   := not Status;
     bbCancelar.Enabled := not Status;
     bbLocaliza.Enabled := Status;
     bbFechar.Enabled   := Status;
end;

procedure TfmDataEdit.bbIncluirClick(Sender: TObject);
begin
  inherited;
  try
     Screen.Cursor := crHourglass;
     AlteraBotoes(False);
     try
        DataSource.AutoEdit := True;
        if not DataSource.DataSet.Active then
           DataSource.DataSet.Active := True;
        paMeio.SetFocus;
        Perform(WM_NEXTDLGCTL, 0, 0);
        DataSource.DataSet.Append;
     except
           AlteraBotoes(True);
           raise;
     end;
  finally
         Screen.Cursor := crDefault;
  end;
end;

procedure TfmDataEdit.bbAlterarClick(Sender: TObject);
begin
  inherited;
  try
     Screen.Cursor := crHourglass;
     AlteraBotoes(False);
     try
        DataSource.AutoEdit := True;
        if not DataSource.DataSet.Active then
           DataSource.DataSet.Active := True;
        DataSource.DataSet.Edit;
        paMeio.SetFocus;
        Perform(WM_NEXTDLGCTL, 0, 0);
     except
           AlteraBotoes(True);
           raise;
     end;
  finally
         Screen.Cursor := crDefault;
  end;
end;

procedure TfmDataEdit.bbGravarClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourglass;

       try
          DataSource.DataSet.Post;
          AlteraBotoes(True);
          DataSource.AutoEdit := False;
          Screen.Cursor := crDefault;
       except
             Screen.Cursor := crDefault;
             raise;
       End;

end;

procedure TfmDataEdit.bbCancelarClick(Sender: TObject);
begin
  inherited;
  if TSQLQuery(DataSource.DataSet).State = dsInsert
    then LimpaCampos;
  TSQLQuery(DataSource.DataSet).Cancel;
  DataSource.AutoEdit := False;
  AlteraBotoes(True);
end;

procedure TfmDataEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
    if DataSource.DataSet.State in [dsEdit, dsInsert] then
    begin
      ShowMessage('Finalize as operações antes de fechar a tela !!!');
      CanClose := False;
    end
  else
    CanClose := True;
end;

procedure TfmDataEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  DataSource.DataSet.Close;
  LimpaCampos;
end;

end.
