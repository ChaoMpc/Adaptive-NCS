
clc
clear all
T=50;
timestep=0.001;
time=0;
m=1;
l=1.5;
M=2;
theta=0.5*m*l/M;
%初始状态
thetahat=0;
d=0;
x0=[0.5, 0.1]';
Xetm=x0;
Timeetm=0;
N=T/timestep+1;
Xstore=zeros(2,T/timestep+1);
ZZstore=zeros(1,T/timestep+1);
Xstore(:,1)=x0;
Thetastore=zeros(1,T/timestep+1);
Flagstore=zeros(2,T/timestep+1);
Ustore=zeros(1,T/timestep+1);
TrueTheta=zeros(1,T/timestep+1);
Flagstore(:,1)=[1,0]';
Thetastore(:,1)=thetahat;
%Control Parameters
k1=5;
k2=5;
beta2=0.01;
delta2=0.01;
c2=1;
Gamma1=0.9;
Gamma2=0.7;
g=9.8;
L2=1;
k=1;
Timeetm=0;
ENN=1;

for time=(0:N-1)*timestep
    Xstore(:,k)=x0;
    TrueTheta(:,k)=theta;
    Thetastore(:,k)=thetahat;
    %Control input computation
    alpha1=-k1*(Xetm(1)-yTr(time));
    u=-k2*(Xetm(2)-alpha1)-thetahat*(-g*sin(Xetm(1)));
    Ustore(1,k)=u;
    %State update
    x=[x0(2), theta'*(-g*sin(x0(1)))+u+d*sin(time)*x0(1)]'.*timestep+x0;%+0.1*randn
  %事件驱动
  if norm(x(1)-Xetm(1),2)< Gamma1*(k1-5/4)/k1*abs(x(1)-yTr(time)) && norm(x-Xetm,2)< Gamma2*(k2-5/4)/(k2+norm(thetahat,2)*L2)*abs(x(2)-alpha1)
      thetahat=thetahat;
  else
      InterTime=time-Timeetm;
      Timeetm=time;
      ENN=ENN+1;
      Flagstore(:,k)=[1,InterTime]';
      Xtemp=Xetm;
      Xetm=x;
     %Adaptive updating
      ee2=x(2)-Xtemp(2);
      thetahat=thetahat-beta2*ee2/(c2+ee2^2)*(-g*sin(Xetm(1)))-delta2*thetahat;
  end
  k=k+1;
  x0=x;
end

Ttime=0:timestep:T;
TTtime=(0:N-1)*timestep;
indexK=1;
YYTr=zeros(1,T/timestep+1);
for indexK=1:N
    YYTr(1,indexK)=yTr((indexK-1)*timestep);
end

figure(1)
plot(Ttime,Xstore(1,:),'-b')
 hold on
 plot(Ttime,YYTr,'-r')
 
figure(2)
plot(Ttime,Thetastore,'.')

EventsNumber=zeros(1,N);
EventsNumber(1,1)=1;
[m,n]=size(Flagstore);
Flagstore(2,1)=NaN;

for i=2:n
    if Flagstore(2,i)>0
        EventsNumber(1,i)=EventsNumber(1,i-1)+1;
    else
        Flagstore(2,i)=NaN;
        EventsNumber(1,i)=EventsNumber(1,i-1);
    end
end
figure(3)
%plot(Ttime,Flagstore(2,:),'.');
stem(Ttime, Flagstore(2,:));

figure(4)
plot(Ttime,EventsNumber,'.');

figure(5)
plot(Ttime,Ustore,'.')

%  save TT Ttime
%  save B6Xstore Xstore
%  save B6Thetastore Thetastore
%  save B6Flagstore Flagstore
%  save B6EventsNumber EventsNumber
%  save B6Ustore Ustore
      
