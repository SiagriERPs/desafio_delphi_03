unit View.frmContratos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Datasnap.DBClient, Datasnap.Provider, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmContratos = class(TForm)
    pTopo: TPanel;
    lblTitulo: TLabel;
    bbFechar: TBitBtn;
    Panel1: TPanel;
    pcLista: TPageControl;
    tsLista: TTabSheet;
    dbgLista: TDBGrid;
    Panel2: TPanel;
    edtLista: TEdit;
    bbEditar: TBitBtn;
    bbExcluir: TBitBtn;
    bbIncluir: TBitBtn;
    tsCadastro: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    edtID: TDBEdit;
    Panel3: TPanel;
    bbGravar: TBitBtn;
    bbCancelar: TBitBtn;
    dbgLimite: TDBGrid;
    qyLista: TFDQuery;
    dspLista: TDataSetProvider;
    cdsLista: TClientDataSet;
    dsLista: TDataSource;
    qyItens: TFDQuery;
    dspItens: TDataSetProvider;
    cdsItens: TClientDataSet;
    dsItens: TDataSource;
    dsDistribuidor: TDataSource;
    qyDistribuidor: TFDQuery;
    qyProdutor: TFDQuery;
    dsProdutor: TDataSource;
    cdsListaID: TIntegerField;
    cdsListaPRODUTORID: TIntegerField;
    cdsListaDISTRIBUIDORID: TIntegerField;
    cdsListaSTATUS: TIntegerField;
    cdsListaDISTRIBUIDOR_NOME: TStringField;
    cdsListaPRODUTOR_NOME: TStringField;
    cmbProdutor: TDBLookupComboBox;
    Label3: TLabel;
    cmbDistribuidor: TDBLookupComboBox;
    Label4: TLabel;
    dsStatus: TDataSource;
    qyStatus: TFDQuery;
    Label5: TLabel;
    cmbStatus: TDBLookupComboBox;
    cdsListaSTATUS_NOME: TStringField;
    qyProdutos: TFDQuery;
    dsProdutos: TDataSource;
    cdsItensID: TIntegerField;
    cdsItensCONTRATOID: TIntegerField;
    cdsItensPRODUTOID: TIntegerField;
    cdsItensQUANTIDADE: TFMTBCDField;
    cdsItensVALOR: TFMTBCDField;
    cdsItensTOTAL: TFMTBCDField;
    cdsItensPRODUTO_NOME: TStringField;
    Label6: TLabel;
    cdsListaTOTAL: TFMTBCDField;
    cdsListaDT: TDateField;
    cdsListaDT_APROVADO: TDateField;
    cdsListaDT_CONCLUIDO: TDateField;
    cdsListaDT_CANCELADO: TDateField;
    Label7: TLabel;
    edtContratoTotal: TDBEdit;
    edtContratoDT: TDBEdit;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    dbnItens: TDBNavigator;
    cmbProduto: TDBLookupComboBox;
    edtQuantidade: TDBEdit;
    edtItensID: TDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    qyLimite: TFDQuery;
    dsLimite: TDataSource;
    edtLimite: TDBEdit;
    cmbFiltroProdutor: TDBLookupComboBox;
    cmbFiltroDistribuidor: TDBLookupComboBox;
    qyLimiteID: TIntegerField;
    qyLimitePRODUTORID: TIntegerField;
    qyLimiteDISTRIBUIDORID: TIntegerField;
    qyLimiteLIMITE: TFMTBCDField;
    qyLimiteSALDO: TFMTBCDField;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    bbFiltrar: TBitBtn;
    bbImprimir: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure bbFecharClick(Sender: TObject);
    procedure pcListaChange(Sender: TObject);
    procedure pcListaDrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure dbgListaDblClick(Sender: TObject);
    procedure dbgListaKeyPress(Sender: TObject; var Key: Char);
    procedure edtListaEnter(Sender: TObject);
    procedure edtListaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtListaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbIncluirClick(Sender: TObject);
    procedure bbExcluirClick(Sender: TObject);
    procedure bbEditarClick(Sender: TObject);
    procedure bbCancelarClick(Sender: TObject);
    procedure bbGravarClick(Sender: TObject);
    procedure dbnItensClick(Sender: TObject; Button: TNavigateBtn);
    procedure bbFiltrarClick(Sender: TObject);
    procedure bbImprimirClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaItens;
  public
    { Public declarations }
  end;

var
  frmContratos: TfrmContratos;

implementation
uses UDM, View.frmContratosReport;
{$R *.dfm}

procedure TfrmContratos.bbCancelarClick(Sender: TObject);
begin
    if cdsLista.State in [dsedit,dsinsert] then
    begin
        cdsLista.Cancel;
        cdsLista.Refresh;
    end;
    pcLista.TabIndex:=0;
end;

procedure TfrmContratos.bbEditarClick(Sender: TObject);
begin
    if pcLista.TabIndex = 0 then
    begin
        if dbgLista.Fields[0].Text <> '' then
        begin
            cdsLista.Locate('ID',dbgLista.FieldS[0].Text,[loPartialKey]);
            cdsLista.Edit;
            pcLista.TabIndex:=1;

            cdsItens.Refresh;
        end;
    end;
end;

procedure TfrmContratos.bbExcluirClick(Sender: TObject);
var
    sql : string;
begin
    if pcLista.TabIndex = 0 then
    begin
        if dbgLista.Fields[0].Text <> '' then
        begin
            sql := 'DELETE FROM CONTRATOS_ITENS '+
                   'WHERE (CONTRATOID = ' + dbgLista.Fields[0].Text + ')';

            with DM.script do
            begin
                SQLScripts.Clear;
                SQLScripts.Add;
                with SQLScripts[0].SQL do begin
                  Add(sql);
                end;
                ExecuteAll;
            end;
            cdsItens.Refresh;

            cdsLista.Locate('ID',dbgLista.Fields[0].Text,[loPartialKey]);
            cdsLista.Delete;
            cdsLista.ApplyUpdates(0);
            cdsLista.Refresh;
        end;
    end else begin
        pcLista.TabIndex:=0
    end;
end;

procedure TfrmContratos.bbFecharClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmContratos.bbFiltrarClick(Sender: TObject);
var
  filtro: string;
begin

    filtro := 'WHERE 1=1 ';

    if cmbFiltroProdutor.KeyValue > 0 then
    begin
        filtro := filtro + ' AND (PRODUTORID = ' + IntToStr(cmbFiltroProdutor.KeyValue) + ')';
    end;

    if cmbFiltroDistribuidor.KeyValue > 0 then
    begin
        filtro := filtro + ' AND (DISTRIBUIDORID = ' + IntToStr(cmbFiltroDistribuidor.KeyValue) + ')';
    end;

    qyLista.Close;
    qyLista.SQL.Clear;
    qyLista.SQL.Add('SELECT * FROM CONTRATOS ' + filtro + ';');
    qyLista.Open;
    cdslista.Refresh;
end;

procedure TfrmContratos.bbGravarClick(Sender: TObject);
var
    sql : string;
begin
    if edtLimite.Field.Value < 0 then
    begin
        if (cmbStatus.Field.Value=0) or (cmbStatus.Field.Value=1) then
        begin
            Application.MessageBox('Limite de crédito atingido.' +#13+ 'Cancele o contrato ou diminua os itens.', 'Agro', MB_ICONQUESTION);
            Exit;
        end;
    end;

    if cdsLista.State in [dsedit,dsinsert] then
    begin
        cdsLista.Post;
    end;

    if cdsItens.State in [dsedit,dsinsert] then
    begin
        cdsItens.Post;
    end;

    cdsLista.ApplyUpdates(0);
    cdsLista.Refresh;

    cdsItens.ApplyUpdates(0);
    AtualizaItens;
    cdsItens.Refresh;

    //Limites
    qyLimite.Close;
    qyLimite.Open;
    qyLimite.Active := True;

    if pcLista.TabIndex <> 0 then
    begin
        pcLista.TabIndex:=0
    end;
    edtLista.Text := '';
end;

procedure TfrmContratos.bbImprimirClick(Sender: TObject);
var
  filtro: string;
begin

    bbFiltrarClick(Sender);

    filtro := 'WHERE 1=1 ';

    if cmbFiltroProdutor.KeyValue > 0 then
    begin
        filtro := filtro + ' AND (C.PRODUTORID = ' + IntToStr(cmbFiltroProdutor.KeyValue) + ') ';
    end;

    if cmbFiltroDistribuidor.KeyValue > 0 then
    begin
        filtro := filtro + ' AND (C.DISTRIBUIDORID = ' + IntToStr(cmbFiltroDistribuidor.KeyValue) + ') ';
    end;



    frmContratosReport := TfrmContratosReport.Create(Self);
    frmContratosReport.qyReport.Close;
    frmContratosReport.qyReport.SQL.Clear;
    frmContratosReport.qyReport.SQL.Add('SELECT C.ID AS CONTRATO, P.NOME AS NM_PRODUTOR, D.nome AS NM_DISTRIBUIDOR, C.total, C.DT, ' +
                                        '        coalesce(C.dt_aprovado,'''') as APROVADO, coalesce(C.dt_concluido, '''') AS CONCLUIDO, coalesce(C.dt_cancelado, '''') AS CANCELADO ' +
                                        'FROM  CONTRATOS C ' +
                                        'INNER JOIN PRODUTOR P ON P.id = C.produtorid '+
                                        'INNER JOIN DISTRIBUIDOR D ON D.id = C.distribuidorid ' + filtro + ';');
    frmContratosReport.qyReport.Open;
    frmContratosReport.qyReport.Active := True;
    frmContratosReport.rltContratos.Preview;
end;

procedure TfrmContratos.bbIncluirClick(Sender: TObject);
begin
    if not(cdsLista.State in [dsedit,dsinsert]) then
    begin
        cdsLista.Insert;
        edtID.Field.Value := 0;
        cmbStatus.Field.Value := 0;
    end;

    if pcLista.TabIndex <> 1 then
    begin
        pcLista.TabIndex:=1
    end;
end;

procedure TfrmContratos.dbgListaDblClick(Sender: TObject);
begin
    if dbgLista.Fields[0].Text <> '' then
    begin
        cdsLista.Locate('ID',dbgLista.FieldS[0].Text,[loPartialKey]);
        cdsLista.Edit;
        pcLista.TabIndex:=1;
    end;
end;

procedure TfrmContratos.dbgListaKeyPress(Sender: TObject; var Key: Char);
begin
   if (key in ['a'..'z']) or (key in ['A'..'Z']) or (Key in ['1','2','3','4','5','6','7','8','9','0']) then
   begin
      edtLista.Text := key;
      edtLista.SetFocus;
   end;
end;

procedure TfrmContratos.dbnItensClick(Sender: TObject;
  Button: TNavigateBtn);
begin
    if Button=nbInsert then
    begin
        if edtID.Field.Value=0 then
        begin
            if cdsLista.State in [dsedit,dsinsert] then
            begin
                cdsLista.Post;
            end;
            cdsLista.ApplyUpdates(0);
            cdsLista.Refresh;
        end;
        edtItensID.Field.Value := 0;
    end;
    if (Button=nbPost) or (Button=nbDelete) then
    begin
        if cdsItens.State in [dsedit,dsinsert] then
            cdsItens.Post;

        cdsItens.ApplyUpdates(0);
        cdsItens.Refresh;
        AtualizaItens();

        cdsLista.ApplyUpdates(0);
        cdsLista.Refresh;

        qyLimite.Close;
        qyLimite.Open;
        qyLimite.Active := True;
    end;
    dbnItens.Refresh;
end;

procedure TfrmContratos.edtListaEnter(Sender: TObject);
begin
    edtLista.Selstart:= Length(edtLista.text);
end;

procedure TfrmContratos.edtListaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   try
      if (key = VK_DOWN) and (dbgLista.FieldCount > 1) then
      begin
         dbgLista.SetFocus;
         dbgLista.SelectedIndex := dbgLista.SelectedIndex + 1;
      end;
      if key = VK_UP then
         dbgLista.SetFocus;

      If ( Chr(Key) = #13) Then
      begin
          if (copy(edtLista.Text,1,1) = '1') or (copy(edtLista.Text,1,1) = '2') or
          (copy(edtLista.Text,1,1) = '3') or (copy(edtLista.Text,1,1) = '4') or
          (copy(edtLista.Text,1,1) = '5') or (copy(edtLista.Text,1,1) = '6') or
          (copy(edtLista.Text,1,1) = '7') or (copy(edtLista.Text,1,1) = '8') or
          (copy(edtLista.Text,1,1) = '9') or (copy(edtLista.Text,1,1) = '0') then
          begin
              qyLista.Close;
              qyLista.SQL.Clear;
              qyLista.SQL.Add('SELECT * FROM CONTRATOS WHERE ID = ' + (edtLista.Text) + ' ');
              qyLista.Open;
              cdslista.Refresh;
              if cdslista.RecordCount >= 1 then
              begin
                  if dbgLista.Fields[0].Text <> '' then
                  begin
                      cdsLista.Locate('ID',dbgLista.FieldS[0].Text,[loPartialKey]);
                      cdsLista.Edit;
                      pcLista.TabIndex:=1;
                  end;
              end
              else
              begin
                  Application.MessageBox('Contrato não encontrado.', 'Agro', MB_ICONQUESTION);
                  edtLista.Text := '';
                  edtLista.SetFocus;
              end;
          end
          else
          begin
              if dbgLista.Fields[0].Text <> '' then
              begin
                  if dbgLista.Fields[0].Text <> '' then
                  begin
                      cdsLista.Locate('ID',dbgLista.FieldS[0].Text,[loPartialKey]);
                      cdsLista.Edit;
                      pcLista.TabIndex:=1;
                  end;
              end;
          end;
      end;
   except
      on e :Exception do
      Application.MessageBox(pchar('Erro ao executar a consulta.' + #13 + e.Message), 'Agro', MB_OK + MB_ICONERROR);
   end;
end;

procedure TfrmContratos.edtListaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if not ( (copy(edtLista.Text,1,1) = '1') or (copy(edtLista.Text,1,1) = '2') or (copy(edtLista.Text,1,1) = '3') or (copy(edtLista.Text,1,1) = '4') or (copy(edtLista.Text,1,1) = '5') or (copy(edtLista.Text,1,1) = '6') or (copy(edtLista.Text,1,1) = '7') or (copy(edtLista.Text,1,1) = '8') or (copy(edtLista.Text,1,1) = '9') or (copy(edtLista.Text,1,1) = '0')) then
    begin
        edtLista.MaxLength := 6;
        edtLista.Text := ''; //no momento nao vamos fazer pesquisas por caracteres
    end else
    begin
        edtLista.MaxLength := 6;
    end;
end;

procedure TfrmContratos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if cdsLista.State in [dsedit,dsinsert] then
    begin
        cdsLista.Cancel
    end;
    frmContratos.Release;
end;

procedure TfrmContratos.FormCreate(Sender: TObject);
begin
    if Dm.Conexao.Connected then
    begin
        pcLista.TabIndex := 0;
    end else begin
        Close;
    end;
end;

procedure TfrmContratos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   If ( Chr(Key) = #27) Then
    begin
        if pcLista.TabIndex = 0 then
        begin
            if edtLista.Text='' then
            begin
                Close
            end else
            begin
                edtLista.Text := ''
            end;
        end else begin
            if cdsLista.State in [dsedit,dsinsert] then
            begin
                cdsLista.Cancel
            end;
            pcLista.TabIndex:=0;
        end;
    end;

    If ( Chr(Key) = #45) Then
    begin
        bbIncluirClick(Sender)
    end;

    If ( Chr(Key) = #46) Then
    begin
        if pcLista.TabIndex = 0 then bbExcluirClick(Sender);
    end;

    If ( Chr(Key) = #113) Then         //F2
    begin
        if pcLista.TabIndex = 0 then
        begin
            if dbgLista.Fields[0].Text <> '' then
            begin
                cdsLista.Locate('ID',dbgLista.FieldS[0].Text,[loPartialKey]);
                cdsLista.Edit;
                pcLista.TabIndex:=1;
            end;
        end;
    end;

    If ( Chr(Key) = #119) Then        //F8
    begin
        if pcLista.TabIndex = 1 then bbGravarClick(Sender)
    end;
end;

procedure TfrmContratos.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
    begin
        Key := #0;
        Perform(Wm_NextDlgCtl,0,0);
    end;
end;

procedure TfrmContratos.FormShow(Sender: TObject);
begin
   try

      //Distribuidor
      qyDistribuidor.Close;
      qyDistribuidor.Open;
      qyDistribuidor.Active := True;

      //Produtor
      qyProdutor.Close;
      qyProdutor.Open;
      qyProdutor.Active := True;

      //Status
      qyStatus.Close;
      qyStatus.Open;
      qyStatus.Active := True;

      //Produtos
      qyProdutos.Close;
      qyProdutos.Open;
      qyProdutos.Active := True;

      //Contratos
      cdsLista.Active := False;
      qyLista.Close;
      qyLista.Open;
      qyLista.Active := True;
      cdsLista.Active := True;

      //Itens
      cdsItens.Active := False;
      qyItens.Close;
      qyItens.Open;
      qyItens.Active := True;
      cdsItens.Active := True;

      //Limites
      qyLimite.Close;
      qyLimite.Open;
      qyLimite.Active := True;

   except
      on e :Exception do
      Application.MessageBox('Erro ao listar os dados.', 'Agro', MB_OK + MB_ICONERROR);
   end;
   EDTLISTA.SetFocus;
end;

procedure TfrmContratos.pcListaChange(Sender: TObject);
begin
    if pcLista.TabIndex in[1] then
    begin
        if dbgLista.Fields[0].Text <> ''  then
        begin
            if not(cdsLista.State in [dsinsert,dsEdit]) then
            begin
                cdsLista.Locate('ID',dbgLista.FieldS[0].Text,[loPartialKey]);
                cdsLista.Edit;
            end;
        end;
    end else begin
        if (cdsLista.State in [dsinsert,dsEdit]) then
        begin
            cdsLista.Cancel
        end;
    end;
end;

procedure TfrmContratos.pcListaDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
    Control.Canvas.Font.Color:=clDefault;
    Control.Canvas.brush.Color:=clWhite;
    Control.Canvas.TextOut(Rect.left+10, Rect.top+3, pcLista.Pages[TabIndex].Caption);
    pcLista.Pages[TabIndex].Brush.Color := clWhite;
    pcLista.Pages[TabIndex].Repaint;
end;

procedure TfrmContratos.AtualizaItens;
var
    sql: string;
begin
     sql := 'UPDATE CONTRATOS_ITENS ' +
            'SET CONTRATOS_ITENS.total = COALESCE(CONTRATOS_ITENS.quantidade,0) * COALESCE((SELECT (P.preco) FROM produtos P WHERE P.ID = CONTRATOS_ITENS.Produtoid), 0), ' +
            '    CONTRATOS_ITENS.VALOR = COALESCE((SELECT (P.preco) FROM produtos P WHERE P.ID = CONTRATOS_ITENS.Produtoid), 0) ' +
            'WHERE (CONTRATOID = ' + IntToStr(edtID.Field.Value) + ')';

      with DM.script do
      begin
          SQLScripts.Clear;
          SQLScripts.Add;
          with SQLScripts[0].SQL do begin
            Add(sql);
          end;
          ExecuteAll;
      end;
      cdsItens.ApplyUpdates(0);
      cdsItens.Refresh;
end;

end.
