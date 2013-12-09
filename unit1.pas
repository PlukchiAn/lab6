unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, Math;

type

  { TForm1 }
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Chart1LineSeries2: TLineSeries;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    function ExecFX(x: Real): Real;//Основная функция
    procedure CheckForm();
    procedure ChordMethod();//Метод хорд
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  Form1: TForm1;
  x1, x2,y1:real;
implementation

{$R *.lfm}
function TForm1.ExecFX(x:real):real;
begin
  result:=Power(x,4)+2*power(x,3)-x-1;
  end;
procedure TForm1.CheckForm;
begin
  try
    StrToFloat(edit1.Text);
    StrToFloat(edit2.Text);
    StrToFloat(edit3.Text);
    StrToFloat(edit4.Text);
    if StrToFloat(edit1.Text) >= StrToFloat(edit2.Text) then
      Showmessage('Левая граница не может быть больше правой. Введите верные данные.');
  except
    Showmessage('Введите верные данные.');
  end;
  end;
 procedure TForm1.ChordMethod;
var
y2, k, b, x, y, d1, d2: Real;
begin
  Memo1.Clear;
  Memo1.Lines.Add('Корни уравнения, найденные методом хорд с шагом '+ edit4.Text+
  ' и погрешностью '+ edit3.Text + ':');
  x1 := StrToFloat(edit1.Text); //border
  y1 := ExecFX(x1);
  repeat
     x2 := x1 + StrToFloat(edit4.Text); //right border
     y2 := ExecFX(x2);
     if (y1 * y2) < 0 then begin
       repeat
         y1 := ExecFX(x1);
         y2 := ExecFX(x2);
         k := (y1 - y2) / (x1 - x2);//
         b := y1 - k * x1;
         x := -b / k;
         y := k * x + b;
         d1 := sqr(x1 - x) + sqr(y1 - y);
         d2 := sqr(x2 - x) + sqr(y2 - y);
         if d1 > d2 then begin
           d1 := d2;
           x1 := x;
         end else x2 := x;
       until d1 < StrToFloat(edit3.Text);
       Memo1.Lines.Add('x:'+FloatToStr(x1));
     end;
     x1 := x2;
     y1 := y2;
  until x2 > StrToFloat(edit2.Text);
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
  Chart1.Visible:=false;
  Form1.Height:=314;
  Form1.Width:=376;
  Edit1.Text:=('-3,0');
  Edit2.Text:=('2');
  Edit3.Text:=('0,001');
  Edit4.Text:=('0,1');
end;
 procedure TForm1.Button1Click(Sender: TObject);
 begin
 CheckForm;
 ChordMethod;
 end;
procedure TForm1.Button2Click(Sender: TObject);
begin
 Form1.Height:=314;
  Form1.Width:=376;
 Memo1.Clear;
 Chart1LineSeries1.Clear;
 Chart1LineSeries2.Clear;
 Chart1.Visible:=false;
end;
procedure TForm1.Button3Click(Sender: TObject);
begin
  Chart1.Visible:=true;
  Form1.Height:=314;
  Form1.Width:=590;
  Chart1LineSeries1.Clear;
  Chart1LineSeries2.Clear;
  x1:=StrToFloat(edit1.Text);
  x2:=StrToFloat(edit2.Text);
  While x1<=x2 do begin
 if x1<>0 then
 Chart1Lineseries1.AddXY(x1,Power(x1,4)+2*power(x1,3)-x1-1,'',clred);
 x1:=x1+0.0001;
end;
end;

end.

