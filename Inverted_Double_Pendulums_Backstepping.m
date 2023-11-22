
clc
clear all
T=30;
timestep=0.001;
time=0;
%system paramters
m1=2;
m2=2.5;
J1=0.5;
J2=0.625;
k=1;
l=0.5;
r=0.5;
b=0.4;
g=9.8;
%ture value of theta
theta1=[m1*g*r/J1-k*r^2/(4*J1),k*r/(2*J1)*(l-b),k*r^2/(4*J1)]';
theta2=[m2*g*r/J2-k*r^2/(4*J2),k*r/(2*J2)*(l-b),k*r^2/(4*J2)]';
%初始状态
thetahat1=zeros(3,1);
thetahat2=zeros(3,1);
x0=[-pi/3.6,pi/4,0,0]';
Xetm=x0;
Timeetm=0;
N=T/timestep+1;
Xstore=zeros(4,T/timestep+1);
Xstore(:,1)=x0;
Thetastore1=zeros(3,T/timestep+1);
Thetastore2=zeros(3,T/timestep+1);
Flagstore=zeros(2,T/timestep+1);
Ustore=zeros(2,T/timestep+1);
TrueTheta1=zeros(3,T/timestep+1);
TrueTheta2=zeros(3,T/timestep+1);
Flagstore(:,1)=[1,0]';
Thetastore1(:,1)=thetahat1;
Thetastore2(:,1)=thetahat2;
%Control Parameters
k11=5;
k12=5;
k21=5;
k22=5;
beta12=15;
delta12=1;
beta22=15;
delta22=1;
Gamma11=0.2;
Gamma12=0.2;
Gamma21=0.2;
Gamma22=0.2;
c12=1;
c22=1;
L12=1;
L22=1;
%Control
kk=1;
Timeetm=0;
ENN=1;

for time=(0:N-1)*timestep
    Xstore(:,kk)=x0;
    TrueTheta1(:,kk)=theta1;
    TrueTheta2(:,kk)=theta2;
    Thetastore1(:,kk)=thetahat1;
    Thetastore2(:,kk)=thetahat2;
    %Control input computation
    alpha1=-k11*Xetm(1);
    alpha2=-k21*Xetm(2);
    u1=J1*(-k12*(Xetm(3)-alpha1)-thetahat1'*[sin(Xetm(1)),1,sin(Xetm(4))]');
    u2=J2*(-k22*(Xetm(4)-alpha2)-thetahat2'*[sin(Xetm(2)),1,sin(Xetm(3))]');
    Ustore(:,kk)=[u1,u2]';
    %State update
    x=[x0(3), x0(4), theta1'*[sin(x0(1)),1,sin(x0(4))]'+u1/J1, theta2'*[sin(x0(2)),1,sin(x0(3))]'+u2/J2 ]'.*timestep+x0;%+0.1*randn
  %事件驱动
  if norm(x(1)-Xetm(1),2)< Gamma11*(k11-5/4)/k11*abs(x(1)) && norm(x(2)-Xetm(2),2)< Gamma21*(k21-5/4)/k21*abs(x(2))&& norm(x-Xetm,2)< Gamma12*(k12-5/4)/(k12+norm(thetahat1,2)*L12)*abs(x(3)-alpha1)&& norm(x-Xetm,2)< Gamma22*(k22-5/4)/(k22+norm(thetahat2,2)*L22)*abs(x(4)-alpha2)
      thetahat1=thetahat1;
      thetahat2=thetahat2;
  else
      InterTime=time-Timeetm;
      Timeetm=time;
      ENN=ENN+1;
      Flagstore(:,kk)=[1,InterTime]';
      Xtemp=Xetm;
      Xetm=x;
     %Adaptive updating
      ee12=x(3)-Xtemp(3);
      ee22=x(4)-Xtemp(4);
      thetahat1=thetahat1-beta12*ee12/(c12+ee12^2)*[sin(Xetm(1)),1,sin(Xetm(4))]'-delta12*thetahat1;
      thetahat2=thetahat2-beta22*ee22/(c22+ee22^2)*[sin(Xetm(2)),1,sin(Xetm(3))]'-delta22*thetahat2;
  end
  kk=kk+1;
  x0=x;
end
Ttime=0:timestep:T;
TTtime=(0:N-1)*timestep;
subTtime=20:timestep:25;
Len=max(size(subTtime));
Startpoint=20/timestep+1;

figure(1)
plot(Ttime,Xstore)
axes('position',[0.55,0.55,0.3,0.3]);
plot(subTtime,Xstore(1,Startpoint:Startpoint+Len-1),'-r');
hold on
plot(subTtime,Xstore(2,Startpoint:Startpoint+Len-1),'-b');
hold on
plot(subTtime,Xstore(3,Startpoint:Startpoint+Len-1),'-k');
hold on
plot(subTtime,Xstore(4,Startpoint:Startpoint+Len-1),'-g');




figure(2)
plot(Ttime,Thetastore1,'-r')
hold on
plot(Ttime,Thetastore2,'-b')
axes('position',[0.55,0.55,0.3,0.3])
plot(subTtime,Thetastore1(1,Startpoint:Startpoint+Len-1),'-r');
hold on
plot(subTtime,Thetastore1(2,Startpoint:Startpoint+Len-1),'-b');
hold on
plot(subTtime,Thetastore1(3,Startpoint:Startpoint+Len-1),'-g');
hold on
plot(subTtime,Thetastore2(1,Startpoint:Startpoint+Len-1),'-k');
hold on
plot(subTtime,Thetastore2(2,Startpoint:Startpoint+Len-1),'.');
hold on
plot(subTtime,Thetastore2(3,Startpoint:Startpoint+Len-1),'-p');




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
plot(Ttime,Ustore(1,:),'-r')
hold on
plot(Ttime,Ustore(2,:),'-b')

% 
%   save InvertedTT Ttime
%   save BInFlagstore Flagstore
%   save BInEventsNumber EventsNumber
%   save BInUstore Ustore
%       
