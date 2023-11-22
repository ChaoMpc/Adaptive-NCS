Ttime = load('TTT');

TXstore1=load('TXstore1');
TZstore1=load('TZstore1');
TThetastore1=load('TThetastore1');
TEventsNumber1=load('TEventsNumber1');
TUstore1=load('TUstore1');

TXstore2=load('TXstore2');
TZstore2=load('TZstore2');
TThetastore2=load('TThetastore2');
TEventsNumber2=load('TEventsNumber2');
TUstore2=load('TUstore2');

TXstore3=load('TXstore3');
TThetastore3=load('TThetastore3');
TEventsNumber3=load('TEventsNumber3');
TUstore3=load('TUstore3');

TXstore4=load('TXstore4');
TThetastore4=load('TThetastore4');
TEventsNumber4=load('TEventsNumber4');
TUstore4=load('TUstore4');

TrueTheta=load('TrueTheta');

N=max(size(Ttime.Ttime));

figure(1)
 plot(Ttime.Ttime,TXstore1.Xstore(1,:),'-r');
 hold on
 plot(Ttime.Ttime,TXstore3.Xstore(1,:),'-b');
 hold on
 plot(Ttime.Ttime,pi/2*ones(1,N),'-g');
 hold on
 plot(Ttime.Ttime, TXstore1.Xstore(2,:),'-k');
 hold on
 plot(Ttime.Ttime, TXstore3.Xstore(2,:),'-y');
 axes('position',[0.55, 0.55,0.3,0.3]);
  plot(Ttime.Ttime,TXstore1.Xstore(1,:),'-r');
 hold on
 plot(Ttime.Ttime,TXstore3.Xstore(1,:),'-b');
 hold on
 plot(Ttime.Ttime,pi/2*ones(1,N),'-g');
 hold on
 plot(Ttime.Ttime, TXstore1.Xstore(2,:),'-k');
 hold on
 plot(Ttime.Ttime, TXstore3.Xstore(2,:),'-y');
% plot(TXstore1.Xstore(1,:),TXstore1.Xstore(2,:),'-b');
% hold on
% plot(TXstore2.Xstore(1,:),TXstore2.Xstore(2,:),'-r');
% hold on
% plot(TXstore3.Xstore(1,:),TXstore3.Xstore(2,:),'-g');
% hold on
% plot(TXstore4.Xstore(1,:),TXstore4.Xstore(2,:),'-p');
% hold on
% plot(pi/2,0,'.');


figure(2)
plot(Ttime.Ttime,TThetastore1.Thetastore,'-r');
hold on
plot(Ttime.Ttime,TThetastore3.Thetastore,'-b');
hold on
plot(Ttime.Ttime,TrueTheta.TrueTheta,'-g');

figure(3)
plot(Ttime.Ttime,TUstore1.Ustore,'-r');
hold on
plot(Ttime.Ttime,TUstore3.Ustore,'-b');

figure(4)
plot(Ttime.Ttime,TXstore2.Xstore(1,:),'-r');
hold on
plot(Ttime.Ttime,TXstore4.Xstore(1,:),'-b');
hold on
plot(Ttime.Ttime,pi/2*ones(1,N),'-g')
hold on
plot(Ttime.Ttime,TXstore2.Xstore(2,:),'-k');
hold on
plot(Ttime.Ttime,TXstore4.Xstore(2,:),'-y');
axes('position',[0.55, 0.55,0.3,0.3]);
plot(Ttime.Ttime,TXstore2.Xstore(1,:),'-r');
hold on
plot(Ttime.Ttime,TXstore4.Xstore(1,:),'-b');
hold on
plot(Ttime.Ttime,pi/2*ones(1,N),'-g')
hold on
plot(Ttime.Ttime,TXstore2.Xstore(2,:),'-k');
hold on
plot(Ttime.Ttime,TXstore4.Xstore(2,:),'-y');

figure(5)
plot(Ttime.Ttime,TThetastore2.Thetastore,'-r');
hold on
plot(Ttime.Ttime,TThetastore4.Thetastore,'-b');
hold on
plot(Ttime.Ttime,TrueTheta.TrueTheta,'-g');

figure(6)
plot(Ttime.Ttime,TUstore2.Ustore,'-r');
hold on
plot(Ttime.Ttime,TUstore4.Ustore,'-b');

figure(7)
plot(Ttime.Ttime,TEventsNumber1.EventsNumber,'-r');
hold on
plot(Ttime.Ttime,TEventsNumber2.EventsNumber,'-b');
hold on
plot(Ttime.Ttime,TEventsNumber3.EventsNumber,'-g');
hold on
plot(Ttime.Ttime,TEventsNumber4.EventsNumber,'-k');

figure(8)
plot(Ttime.Ttime,TZstore1.Zstore(1,:),'-r');
hold on
plot(Ttime.Ttime,TZstore2.Zstore(1,:),'-b');
axes('position',[0.55, 0.55,0.3,0.3]);
plot(Ttime.Ttime,TZstore1.Zstore(1,:),'-r');
hold on
plot(Ttime.Ttime,TZstore2.Zstore(1,:),'-b');
