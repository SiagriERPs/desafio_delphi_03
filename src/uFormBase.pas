unit uFormBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, JvExControls, Data.DB,
  JvGradientHeaderPanel, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask,
  dxGDIPlusClasses;

type
  TfrmBase = class(TForm)
    pnlTopo: TPanel;
    pnlBotton: TPanel;
    btnMinimizar: TSpeedButton;
    btnFechar: TSpeedButton;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnMinimizarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pnlTopoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1DblClick(Sender: TObject);
  private
    { Private declarations }
  strict protected
    procedure Pintar(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmBase: TfrmBase;

implementation

{$R *.dfm}


procedure TfrmBase.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmBase.btnMinimizarClick(Sender: TObject);
begin
  Self.WindowState := wsMinimized;
end;

procedure TfrmBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then // Enter
  begin
    try
      if (Assigned(TWinControl(ActiveControl)) and (TWinControl(ActiveControl).ClassType <> TDBMemo) and
        (TWinControl(ActiveControl).ClassType <> TMemo)) then
      begin
        Keybd_Event(VK_TAB, 0, 0, 0);
      end;
    except
    end;
  end;

  if Key = VK_UP then // voltar campo com a seta para cima.....
  begin
    try // Colocar aqui para evitar mensagem de erro para o usuário
      if ((TWinControl(ActiveControl).ClassType = TEdit) or (TWinControl(ActiveControl).ClassType = TDBEdit)) then
      begin
        if ActiveControl.CanFocus then
        begin
          Key := 0;
          Perform(WM_NEXTDLGCTL, 1, 0);
        end;
      end;
    except
    end;
  end
end;

procedure TfrmBase.FormShow(Sender: TObject);
begin
  pnlTopo.Caption := Self.Caption;
  pnlBotton.Caption := 'Aliare® copyright 2022';

  for var I := 0 to Pred(Self.ComponentCount) do
  begin
    if (Self.Components[I].ClassType = TDBEdit) and (TDBEdit(Self.Components[I]).Tag = 0) then
      TDBEdit(Self.Components[I]).OnEnter := Pintar
    else if (Self.Components[I].ClassType = TEdit) and (TEdit(Self.Components[I]).Tag = 0) then
      TEdit(Self.Components[I]).OnEnter := Pintar
    else if Self.Components[I].ClassType = TDBMemo then
      TDBMemo(Self.Components[I]).OnEnter := Pintar
    else if Self.Components[I].ClassType = TMemo then
      TMemo(Self.Components[I]).OnEnter := Pintar
    else if Self.Components[I].ClassType = TMaskEdit then
      TMaskEdit(Self.Components[I]).OnEnter := Pintar;
  end;
end;

procedure TfrmBase.Image1DblClick(Sender: TObject);
begin
  close;
end;

procedure TfrmBase.Pintar(Sender: TObject);
const
  CorSemFoco = clWindow;
  CorComFoco = $00D5FFD5;
var
  nI: Integer;
begin
  for nI := 0 to Self.ComponentCount - 1 do
  begin
    if (Self.Components[nI].ClassType = TDBEdit) then
    begin
      if TDBEdit(Self.Components[nI]).Field <> nil then
      begin
        if (not TDBEdit(Self.Components[nI]).Field.Calculated) and (not TDBEdit(Self.Components[nI]).ReadOnly) then
        begin
          if TDBEdit(Self.Components[nI]).Focused then
            TDBEdit(Self.Components[nI]).Color := CorComFoco
          else
            TDBEdit(Self.Components[nI]).Color := CorSemFoco;
        end
        else if (not TDBEdit(Self.Components[nI]).Tag = 0) and (TDBEdit(Self.Components[nI]).ReadOnly) then
        begin
          TDBEdit(Self.Components[nI]).Color := clInfoBk;
          TDBEdit(Self.Components[nI]).TabStop := False;
        end;
      end;
    end
    else if (Self.Components[nI].ClassType = TDBMemo) then
    begin
      if TDBMemo(Self.Components[nI]).Field <> nil then
      begin
        if not TDBMemo(Self.Components[nI]).ReadOnly then
        begin
          if TDBMemo(Self.Components[nI]).Focused then
            TDBMemo(Self.Components[nI]).Color := CorComFoco
          else
            TDBMemo(Self.Components[nI]).Color := CorSemFoco;
        end
        else
        begin
          TDBMemo(Self.Components[nI]).Color := clInfoBk;
        end;
      end;
    end
    else if (Self.Components[nI].ClassType = TMemo) then
    begin
      if TMemo(Self.Components[nI]).Tag = 0 then
      begin
        if TMemo(Self.Components[nI]).ReadOnly then
        begin
          if TMemo(Self.Components[nI]).Focused then
            TMemo(Self.Components[nI]).Color := CorComFoco
          else
          begin
            TMemo(Self.Components[nI]).Color := CorSemFoco;
          end;
        end
        else
        begin
          TMemo(Self.Components[nI]).Color := clInfoBk;
          TMemo(Self.Components[nI]).TabStop := False;
        end;
      end;
    end
    else if (Self.Components[nI].ClassType = TEdit) then
    begin
      if not TEdit(Self.Components[nI]).ReadOnly then
      begin
        if TEdit(Self.Components[nI]).Focused then
          TEdit(Self.Components[nI]).Color := CorComFoco
        else
        begin
          TEdit(Self.Components[nI]).Color := CorSemFoco;
        end;
      end
      else
      begin
        TEdit(Self.Components[nI]).Color := clInfoBk;
        TEdit(Self.Components[nI]).TabStop := False;
      end;
    end
    else if (Self.Components[nI].ClassType = TMaskEdit) then
    begin
      if not TMaskEdit(Self.Components[nI]).ReadOnly then
      begin
        if TMaskEdit(Self.Components[nI]).Focused then
          TMaskEdit(Self.Components[nI]).Color := CorComFoco
        else
          TMaskEdit(Self.Components[nI]).Color := CorSemFoco;
      end
      else
        TMaskEdit(Self.Components[nI]).Color := clInfoBk;
    end;
  end;
end;

procedure TfrmBase.pnlTopoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  if Button = mbleft then
  begin
    ReleaseCapture;
    TForm(Self).Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;

end.
