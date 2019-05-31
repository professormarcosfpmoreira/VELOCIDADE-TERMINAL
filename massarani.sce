//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//%%%%%%%% Este programa calcula a velocidade terminal  
//%%%%%%%% AUTOR: MARCOS MOREIRA
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear 

//*****************************************
//****  DADOS DE ENTRADA DA PARTÍCULA  ****
//*****************************************
disp('O QUE VOCÊ DESEJA CALCULAR ?')
disp('SE FOR A VELOCIDADE TERMINAL DIGITE O NÚMERO 1 ')
disp('SE FOR O DIÂMETRO DA PARTÍCULA DIGITE O NÚMERO 2 ')
disp(' ')
desejo=input('QUAL ALTERNATIVA ? = ')

if desejo==1 then
disp('DIÂMETRO DA PARTÍCULA (em micra)')
dp=input('dp= ');
dp=1e-6*dp;
end
if desejo==2 then
disp('VELOCIDADE TERMINAL (em m/s)')
velocidade=input('velocidade terminal = ');
end

disp('DIGITE A ESFERICIDADE')
esfericidade=input('esfericidade = ');

disp('DIGITE A MASSA ESPECÍFICA DO SÓLIDO (g/cm^3)')
ro_solido=input('massa específica do sólido = ');
ro_solido=ro_solido*1000;


//*****************************************
//****  DADOS DE ENTRADA PARA O FLUIDO ****
//*****************************************

disp('DIGITE A VISCOSIDADE DO FLUIDO (em cP)')
viscosidade=input('viscosidade do fluido = ');
viscosidade=1e-3*viscosidade;

disp('DIGITE A MASSA ESPECÍFICA DO FLUIDO (g/cm^3)')
ro_fluido=input('massa específica do fluido = ');
ro_fluido=ro_fluido*1000;

//*****************************************
//****  DADOS DE ENTRADA PARA O CAMPO  ****
//*****************************************
disp('DIGITE A ACELERAÇÃO DO CAMPO (m/s^2)')
g=input('aceleração = ');


//*****************************************
//*****************************************
//*****************************************
function y=vterminal(esfericidade,dp,ro_solido,ro_fluido,viscosidade)

//*******************************************
// CALCULANDO A VELOCIDADE TERMINAL *********
//*******************************************

CdRe2=(4/3)*dp^3*(ro_solido-ro_fluido)*ro_fluido*g/(viscosidade^2);
if esfericidade == 1 then
Re=((CdRe2/24)^(-0.95)+(CdRe2/0.43)^(-0.95/2))^(-1/0.95);
y=(viscosidade*Re)/(ro_fluido*dp);
elseif esfericidade < 1 then
k1=0.843*(log(esfericidade/0.065))/(log(10));
k2=5.31-4.88*esfericidade;
Re=((k1*CdRe2/24)^(-1.2)+(CdRe2/k2)^(-1.2/2))^(-1/1.2);
y=(viscosidade*Re)/(ro_fluido*dp);
end
endfunction

//*****************************************
//*****************************************
//*****************************************
function y=diametro(esfericidade,velocidade,ro_solido,ro_fluido,viscosidade)
//*******************************************
// CALCULANDO O DIÂMETRO DA PARTÍCULA *******
//*******************************************
Cd_Re=(4/3)*viscosidade*(ro_solido-ro_fluido)*g/(ro_fluido^2*velocidade^3);
if esfericidade == 1 then
Re=((24/Cd_Re)^(0.88/2)+(0.43/Cd_Re)^(0.88))^(1/0.88);
y=(viscosidade*Re)/(ro_fluido*velocidade);
elseif esfericidade < 1 then
k1=0.843*(log(esfericidade/0.065))/(log(10));
k2=5.31-4.88*esfericidade;
Re=((24/(k1*Cd_Re))^(1.3/2)+(k2/Cd_Re)^(1.3))^(1/1.3);
y=(viscosidade*Re)/(ro_fluido*velocidade);
end
endfunction

//*****************************
// IMPRIMINDO OS VALORES ******
//***************************** 

if desejo==1 then
printf('A velocidade terminal é de (em m/s) = %6.4e\n',vterminal(esfericidade,dp,ro_solido,ro_fluido,viscosidade));
end

if desejo==2 then
printf('O diâmetro da partícula é de (em metros) = %6.4e\n',diametro(esfericidade,velocidade,ro_solido,ro_fluido,viscosidade));
end

