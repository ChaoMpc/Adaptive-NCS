
clc
clear all
gamma=0.01;
epsilon=0.01;
T=30;
timestep=0.001;
setpoint=pi/2;
time=0;
m=1;
l=1.5;
M=2;
g=9.8;
theta=0.5*m*g*l/M;
%初始状态
thetahat=2;
d=0.05;
x0=[0.5, 0.1]';
% x0=[0.1,0.2]';
Xetm=x0-[setpoint,0]';
Timeetm=0;
N=T/timestep+1;
Xstore=zeros(2,T/timestep+1);
ZZstore=zeros(1,T/timestep+1);
Xstore(:,1)=x0;
Thetastore=zeros(1,T/timestep+1);
Flagstore=zeros(2,T/timestep+1);
Lstore=zeros(1,T/timestep+1);
Zphistore=zeros(1,T/timestep+1);
Ustore=zeros(1,T/timestep+1);
TrueTheta=zeros(1,T/timestep+1);
Zstore=zeros(1,T/timestep+1);
Flagstore(:,1)=[1,0]';
Thetastore(:,1)=thetahat;
K=[3, 2]';
k=1;
Timeetm=0;

for time=(0:N-1)*timestep
     Xstore(:,k)=x0;
    TrueTheta(:,k)=theta;
    Thetastore(:,k)=thetahat;
    Zstore(1,k)=theta-thetahat-phi(Xetm(1)+setpoint)*x0(2);
    u=-K'*Xetm-(thetahat+phi(Xetm(1)+setpoint)*Xetm(2))*phi(Xetm(1)+setpoint);
    Ustore(1,k)=u;
    ZZstore(:,k)=theta-thetahat-phi(Xetm(1)+setpoint)*x0(2);
    Zphistore(1,k)=ZZstore(1,k)*phi(Xetm(1)+setpoint);
  %状态更新
  x=[x0(2), theta'*phi(x0(1))+u+d*sin(time)]'.*timestep+x0;
  %事件驱动
  if norm(x-[setpoint,0]'-Xetm,2)<epsilon
      thetahat=thetahat+(K'*Xetm*phi(Xetm(1)+setpoint)-gamma*(thetahat+Xetm(1)*phi(Xetm(1)+setpoint))).*timestep;
  else
      InterTime=time-Timeetm;
      Timeetm=time;
      Flagstore(:,k)=[1,InterTime]';
      Xtemp=Xetm;
      Xetm=x-[setpoint,0]';
      thetahat=thetahat-(phi(Xetm(1)+setpoint)-phi(Xtemp(1)+setpoint)).*Xetm(2);
  end
  k=k+1;
  x0=x;
end
Ttime=0:timestep:T;
TTtime=(0:N-1)*timestep;


EventsNumber=zeros(1,N);
EventsNumber(1,1)=1;
[m,n]=size(Flagstore);
Flagstore(2,1)=NaN;

for i=2:n
    if Flagstore(2,i)>0
        EventsNumber(1,i)=EventsNumber(1,i-1)+1;
        Thetastore(1,i)=NaN;
        Ustore(1,i)=NaN;
    else
        Flagstore(:,i)=NaN;
        EventsNumber(1,i)=EventsNumber(1,i-1);
    end
end


figure(1)
plot(Ttime,Xstore)
hold on
plot(Ttime,setpoint*ones(1,N),'-r')

figure(2)
plot(Ttime,Thetastore,'.')
hold on
plot(Ttime,TrueTheta,'-r')

figure(3)
plot(Ttime,EventsNumber,'.');

figure(4)
plot(Ttime,Ustore)

% save TTT Ttime
 save TZstore2 Zstore
 save TXstore2 Xstore
 save TThetastore2 Thetastore
 save TEventsNumber2 EventsNumber
 save TUstore2 Ustore
