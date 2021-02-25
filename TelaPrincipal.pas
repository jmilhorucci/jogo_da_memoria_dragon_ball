unit TelaPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, Menus, Vcl.Imaging.pngimage;

type
  TFormTelaPrincipal = class(TForm)
    LabelPontos: TLabel;
    btnReinicia: TButton;
    AreaDoJogo: TPanel;
    btnCartaG1: TSpeedButton;
    btnCartaGK1: TSpeedButton;
    btnCartaGSSJUm1: TSpeedButton;
    btnCartaGSSJDois1: TSpeedButton;
    btnCartaGSSJQuatro1: TSpeedButton;
    btnCartaGSSJTres1: TSpeedButton;
    btnCartaGK2: TSpeedButton;
    btnCartaGSSJTres2: TSpeedButton;
    btnCartaGSSJUm2: TSpeedButton;
    btnCartaGSSJDois2: TSpeedButton;
    btnCartaGSSJQuatro2: TSpeedButton;
    btnCartaGSSJDeus1: TSpeedButton;
    btnCartaGSSJDeus2: TSpeedButton;
    btnCartaGSSJBlue1: TSpeedButton;
    btnCartaGSSJBlue2: TSpeedButton;
    btnCartaGSSJBKaioken1: TSpeedButton;
    btnCartaGSSJBKaioken2: TSpeedButton;
    btnCartaGSSJUI1: TSpeedButton;
    btnCartaGSSJUI2: TSpeedButton;
    btnCartaGSSJUIFull1: TSpeedButton;
    btnCartaGSSJUIFull2: TSpeedButton;
    btnCartaGBlackRose1: TSpeedButton;
    btnCartaGBlackRose2: TSpeedButton;
    Cronometro: TTimer;
    chkEmbaralha: TCheckBox;
    btnCartaG2: TSpeedButton;
    Image1: TImage;
    MainMenu1: TMainMenu;
    procedure ClickBotao(Sender: TObject);
    procedure CronometroTimer(Sender: TObject);
    procedure btnReiniciaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCartaSerena1Click(Sender: TObject);
  private
    B1, B2: TSpeedButton; // O par de botões de cada jogada...
    Pontos, Acertos: integer;
    procedure PerdePontos(N: integer);
    procedure GanhaPontos(N: integer);
    procedure FimDeJogo(mensagem: string);
  public
    procedure ReiniciaJogo;
    procedure LimpaBotao(Botao: TSpeedButton);
    procedure Embaralha;
  end;

var
  FormTelaPrincipal: TFormTelaPrincipal;

implementation

{$R *.DFM}

procedure TFormTelaPrincipal.ReiniciaJogo;
begin
  B2 := nil;
  { o "nil" acima significa que B2 estará VAZIA
    e não apontará para NENHUM botão! }
  Pontos := 60; // inicia com 60 pontos
  Acertos := 0;
  { Limpa todos os botões: }
  LimpaBotao(btnCartaGK1);
  LimpaBotao(btnCartaGK2);
  LimpaBotao(btnCartaG1);
  LimpaBotao(btnCartaG2);
  LimpaBotao(btnCartaGSSJUm1);
  LimpaBotao(btnCartaGSSJUm2);
  LimpaBotao(btnCartaGSSJDois1);
  LimpaBotao(btnCartaGSSJDois2);
  LimpaBotao(btnCartaGSSJTres1);
  LimpaBotao(btnCartaGSSJTres2);
  LimpaBotao(btnCartaGSSJQuatro1);
  LimpaBotao(btnCartaGSSJQuatro2);
  LimpaBotao(btnCartaGSSJDeus1);
  LimpaBotao(btnCartaGSSJDeus2);
  LimpaBotao(btnCartaGSSJBlue1);
  LimpaBotao(btnCartaGSSJBlue2);
  LimpaBotao(btnCartaGSSJBKaioken1);
  LimpaBotao(btnCartaGSSJBKaioken2);
  LimpaBotao(btnCartaGSSJUI1);
  LimpaBotao(btnCartaGSSJUI2);
  LimpaBotao(btnCartaGSSJUIFull1);
  LimpaBotao(btnCartaGSSJUIFull2);
  LimpaBotao(btnCartaGBlackRose1);
  LimpaBotao(btnCartaGBlackRose2);
  { Verifica op. de embaralhar: }
  if chkEmbaralha.Checked then
    Embaralha;
  { Habilita a tela p/ jogar: }
  AreaDoJogo.Enabled := True;
  Cronometro.Enabled := True; // liga o cronometro
end;

procedure TFormTelaPrincipal.CronometroTimer(Sender: TObject);
begin
  PerdePontos(1); // perde um ponto por segundo
end;

procedure TFormTelaPrincipal.ClickBotao(Sender: TObject);
begin
  if B2 = nil then // vazio (ver ReiniciaJogo)
    B2 := B1; // o botão anterior
  B1 := TSpeedButton(Sender); // O botão clicado
  B1.Spacing := 4; // Retira os espaços p/ mostrar a figura
  if (B2 = nil) or (B1 = B2) then
    Exit // sai desta procedure
  else if B2.Tag = B1.Tag then
  begin
    { A propriedade Tag é um número que vc pode usar
      à vontade - aqui usamos para identificar os pares
      de botões. }
    B1 := nil;
    B2 := nil;
    GanhaPontos(5);
  end
  else
  begin // ERROU!
    LimpaBotao(B2);
    B2 := nil;
    PerdePontos(2);
  end;
end;

procedure TFormTelaPrincipal.PerdePontos(N: integer);
begin
  Pontos := Pontos - N;
  LabelPontos.Caption := 'Tempo Restante: ' + IntToStr(Pontos);
  if Pontos <= 0 then
    FimDeJogo('Você perdeu... Tente outra vez!');
end;

procedure TFormTelaPrincipal.GanhaPontos(N: integer);
begin
  Pontos := Pontos + N;
  Acertos := Acertos + 1;
  LabelPontos.Caption := 'Tempo Restante: ' + IntToStr(Pontos);
  if Acertos = 12 then
    FimDeJogo('Parabéns! você acertou !!! ');
end;

procedure TFormTelaPrincipal.FimDeJogo(mensagem: string);
begin
  Cronometro.Enabled := False; // desliga o cronometro
  ShowMessage('Fim de Jogo: ' + mensagem);
  AreaDoJogo.Enabled := False; // impede de mexer no jogo
end;

procedure TFormTelaPrincipal.btnReiniciaClick(Sender: TObject);
begin
  ReiniciaJogo;
end;

procedure TFormTelaPrincipal.LimpaBotao(Botao: TSpeedButton);
begin
  Botao.Spacing := 200; // cobre a figura com espaços
  Botao.Down := False;
end;

procedure TFormTelaPrincipal.FormCreate(Sender: TObject);
begin
  ReiniciaJogo;
end;

procedure TFormTelaPrincipal.Embaralha;
var
  aBotao: array [1 .. 12, 1 .. 2] of TSpeedButton;
  i, j, p, id: integer;
  imagem: TBitmap;
  nome: string;
begin
  { Coloca os botões no array: }
  aBotao[1][1] := btnCartaGK1;
  aBotao[1][2] := btnCartaGK2;
  aBotao[2][1] := btnCartaG1;
  aBotao[2][2] := btnCartaG2;
  aBotao[3][1] := btnCartaGSSJUm1;
  aBotao[3][2] := btnCartaGSSJUm2;
  aBotao[4][1] := btnCartaGSSJDois1;
  aBotao[4][2] := btnCartaGSSJDois2;
  aBotao[5][1] := btnCartaGSSJTres1;
  aBotao[5][2] := btnCartaGSSJTres2;
  aBotao[6][1] := btnCartaGSSJQuatro1;
  aBotao[6][2] := btnCartaGSSJQuatro2;
  aBotao[7][1] := btnCartaGSSJDeus1;
  aBotao[7][2] := btnCartaGSSJDeus2;
  aBotao[8][1] := btnCartaGSSJBlue1;
  aBotao[8][2] := btnCartaGSSJBlue2;
  aBotao[9][1] := btnCartaGSSJBKaioken1;
  aBotao[9][2] := btnCartaGSSJBKaioken2;
  aBotao[10][1] := btnCartaGSSJUI1;
  aBotao[10][2] := btnCartaGSSJUI2;
  aBotao[11][1] := btnCartaGSSJUIFull1;
  aBotao[11][2] := btnCartaGSSJUIFull2;
  aBotao[12][1] := btnCartaGBlackRose1;
  aBotao[12][2] := btnCartaGBlackRose2;

  { Troca as imagens entre os botões, aleatóriamente: }
  Randomize;
  imagem := TBitmap.Create;
  for i := 1 to 12 do
    for j := 1 to 2 do
    begin
      p := Random(11) + 1; // gera um número entre 1..6
      { Guarda as informações do botão escolhido... }
      id := aBotao[i][j].Tag;
      imagem.Assign(aBotao[i][j].Glyph);
      nome := aBotao[i][j].Caption;
      { ...e troca com o botão atual: }
      aBotao[i][j].Glyph.Assign(aBotao[p][j].Glyph);
      aBotao[p][j].Glyph.Assign(imagem);
      aBotao[i][j].Tag := aBotao[p][j].Tag;
      aBotao[p][j].Tag := id;
      aBotao[i][j].Caption := aBotao[p][j].Caption;
      aBotao[p][j].Caption := nome;
    end; // for j
  imagem.Free;
end;

procedure TFormTelaPrincipal.btnCartaSerena1Click(Sender: TObject);
begin
  if B2 = nil then // vazio (ver ReiniciaJogo)
    B2 := B1; // o botão anterior
  B1 := TSpeedButton(Sender); // O botão clicado
  B1.Spacing := 4; // Retira os espaços p/ mostrar a figura
  if (B2 = nil) or (B1 = B2) then
    Exit // sai desta procedure
  else if B2.Tag = B1.Tag then
  begin
    { A propriedade Tag é um número que vc pode usar
      à vontade - aqui usamos para identificar os pares
      de botões. }
    B1 := nil;
    B2 := nil;
    GanhaPontos(5);
  end;
end;

end.
