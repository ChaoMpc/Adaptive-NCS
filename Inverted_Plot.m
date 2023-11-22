

InvertedTT=load('InvertedTT');
InFlagstore=load('InFlagstore');
InEventsNumber=load('InEventsNumber');
InUstore=load('InUstore');


BInFlagstore=load('BInFlagstore');
BInEventsNumber=load('BInEventsNumber');
BInUstore=load('BInUstore');

figure(1)
stem(InvertedTT.Ttime,InFlagstore.Flagstore(2,:),'-r');
hold on
stem(InvertedTT.Ttime,BInFlagstore.Flagstore(2,:),'-b');

figure(2)
plot(InvertedTT.Ttime,InEventsNumber.EventsNumber,'-r');
hold on
plot(InvertedTT.Ttime,BInEventsNumber.EventsNumber,'-b');

figure(3)
plot(InvertedTT.Ttime,InUstore.Ustore,'-r');
hold on
plot(InvertedTT.Ttime,BInUstore.Ustore,'-b');