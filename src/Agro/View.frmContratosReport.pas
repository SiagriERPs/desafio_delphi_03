unit View.frmContratosReport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  RLReport, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmContratosReport = class(TForm)
    rltContratos: TRLReport;
    qyReport: TFDQuery;
    dsReport: TDataSource;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    Label1: TLabel;
    RLDBText1: TRLDBText;
    qyReportCONTRATO: TIntegerField;
    qyReportNM_PRODUTOR: TStringField;
    qyReportNM_DISTRIBUIDOR: TStringField;
    qyReportTOTAL: TFMTBCDField;
    qyReportDT: TDateField;
    qyReportAPROVADO: TStringField;
    qyReportCONCLUIDO: TStringField;
    qyReportCANCELADO: TStringField;
    Label2: TLabel;
    RLDBText2: TRLDBText;
    Label3: TLabel;
    RLDBText3: TRLDBText;
    Label4: TLabel;
    Label5: TLabel;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    Label6: TLabel;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmContratosReport: TfrmContratosReport;

implementation
uses UDM;
{$R *.dfm}

end.
