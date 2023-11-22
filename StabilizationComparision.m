Ttime = load('TT');

Xstore6=load('Xstore6');
Thetastore6=load('Thetastore6');
Flagstore6=load('Flagstore6');
EventsNumber6=load('EventsNumber6');
Ustore6=load('Ustore6');

Xstore4=load('Xstore4');
Thetastore4=load('Thetastore4');
Flagstore4=load('Flagstore4');
EventsNumber4=load('EventsNumber4');
Ustore4=load('Ustore4');

D6Xstore=load('D6Xstore');
D6Thetastore=load('D6Thetastore');
D6Flagstore=load('D6Flagstore');
D6EventsNumber=load('D6EventsNumber');
D6Ustore=load('D6Ustore');

B6Xstore=load('B6Xstore');
B6Thetastore=load('B6Thetastore');
B6Flagstore=load('B6Flagstore');
B6EventsNumber=load('B6EventsNumber');
B6Ustore=load('B6Ustore');

Xstore=load('TimeXstore');

figure(1)
plot(Ttime.Ttime,Xstore4.Xstore(1,:),'-r');
hold on
plot(Ttime.Ttime,Xstore6.Xstore(1,:),'-b');
hold on
plot(Ttime.Ttime,D6Xstore.Xstore(1,:),'-k');
hold on
plot(Ttime.Ttime,B6Xstore.Xstore(1,:),'-g');

figure(2)
plot(Ttime.Ttime,Xstore4.Xstore(2,:),'-r');
hold on
plot(Ttime.Ttime,Xstore6.Xstore(2,:),'-b');
hold on
plot(Ttime.Ttime,D6Xstore.Xstore(2,:),'-k');
hold on
plot(Ttime.Ttime,B6Xstore.Xstore(2,:),'-g');

figure(3)
plot(Ttime.Ttime,Thetastore4.Thetastore,'-r');
hold on
plot(Ttime.Ttime,Thetastore6.Thetastore,'-b');
hold on
plot(Ttime.Ttime,D6Thetastore.Thetastore,'-k');
hold on
plot(Ttime.Ttime,B6Thetastore.Thetastore,'-g');

figure(4)
stem(Ttime.Ttime,Flagstore4.Flagstore(2,:),'-r');
hold on
stem(Ttime.Ttime,Flagstore6.Flagstore(2,:),'-b');
hold on
stem(Ttime.Ttime,D6Flagstore.Flagstore(2,:),'-k');
hold on
stem(Ttime.Ttime,B6Flagstore.Flagstore(2,:),'-g');

figure(5)
plot(Ttime.Ttime,EventsNumber4.EventsNumber,'-r');
hold on
plot(Ttime.Ttime,EventsNumber6.EventsNumber,'-b');
hold on
plot(Ttime.Ttime,D6EventsNumber.EventsNumber,'-k');
hold on
plot(Ttime.Ttime,B6EventsNumber.EventsNumber,'-g');

figure(6)
plot(Ttime.Ttime,Ustore4.Ustore,'-r');
hold on
plot(Ttime.Ttime,Ustore6.Ustore,'-b');
hold on
plot(Ttime.Ttime,D6Ustore.Ustore,'-k');
hold on
plot(Ttime.Ttime,B6Ustore.Ustore,'-g');
