
clc
clear all
T=10;
timestep=0.001;
time=0;
gamma=0.01;
epsilon=0.01;
%system paramters
m1=1;
m2=1.5;
J1=2;
J2=5;
k=0.1;
l=0.1;
r=0.5;
b=0.01;
g=9.8;
BJinv=[J1,0;0,J2];
%ture value of theta
theta1=[m1*g*r/J1-k*r^2/(4*J1),k*r/(2*J1)*(l-b),k*r^2/(4*J1)]';
theta2=[m2*g*r/J2-k*r^2/(4*J2),k*r/(2*J2)*(l-b),k*r^2/(4*J2)]';
%初始状态
thetahat=zeros(6,1);
%x0=[-pi/3.6,pi/4,0,0]';
x0=[-0.5, 0.1,0.5,-0.1]';
Xetm=x0;
Timeetm=0;
N=T/timestep+1;
Xstore=zeros(4,T/timestep+1);
Xstore(:,1)=x0;
Thetastore=zeros(6,T/timestep+1);
Flagstore=zeros(2,T/timestep+1);
Ustore=zeros(2,T/timestep+1);
TrueTheta=zeros(6,T/timestep+1);
Flagstore(:,1)=[1,0]';
Thetastore(:,1)=thetahat;
%Control Parameters
K=[10 0 10 0
    0 10 0 10];
%Control
kk=1;
Timeetm=0;
ENN=1;

for time=(0:N-1)*timestep
    Xstore(:,kk)=x0;
    TrueTheta(1:3,kk)=theta1;
    TrueTheta(4:6,kk)=theta2;
    Thetastore(:,kk)=thetahat;
    %Control input computation
    u=BJinv*(-K*Xetm-APHI(Xetm)'*thetahat-APHI(Xetm)'*APHI(Xetm)*Xetm(3:4));
    Ustore(:,kk)=u;
    %State update
    x=[x0(3), x0(4), theta1'*[sin(x0(1)),1,sin(x0(4))]'+u(1)/J1, theta2'*[sin(x0(2)),1,sin(x0(3))]'+u(2)/J2 ]'.*timestep+x0;%+0.1*randn
  %事件驱动
  if norm(x-Xetm,2)<epsilon
    thetahat=thetahat+(APHI(Xetm)*K*Xetm-gamma.*(thetahat+APHI(Xetm)*Xetm(3:4))).*timestep;
  else
      InterTime=time-Timeetm;
      Timeetm=time;
      ENN=ENN+1;
      Flagstore(:,kk)=[1,InterTime]';
      Xtemp=Xetm;
      Xetm=x;
     %Adaptive updating
     thetahat=thetahat-(APHI(Xetm)-APHI(Xtemp))*Xetm(3:4);
  end
  kk=kk+1;
  x0=x;
end
Ttime=0:timestep:T;
TTtime=(0:N-1)*timestep;

figure(1)
plot(Ttime,Xstore)

figure(2)
plot(Ttime,Thetastore);

EventsNumber=zeros(1,N);
EventsNumber(1,1)=1;
[m,n]=size(Flagstore);
Flagstore(2,1)=NaN;

for i=2:n
    if Flagstore(1,i)>0
        EventsNumber(1,i)=EventsNumber(1,i-1)+1;
    else
        Flagstore(1,i)=NaN;
        Flagstore(2,i)=NaN;
        EventsNumber(1,i)=EventsNumber(1,i-1);
    end
end

figure(3)
stem(Ttime,Flagstore(2,:),'-b');
axes('position',[0.55, 0.55,0.3,0.3]);
stem(Ttime,Flagstore(2,:),'-b');

figure(4)
plot(Ttime,EventsNumber,'.');

figure(5)
plot(Ttime,Ustore)

   save InvertIIX Xstore
   save InvertIITheta Thetastore
   save InvertIIFlag Flagstore
   save InvertIIEventsNumber EventsNumber
   save InvertIIUstore Ustore