
$Title Master Thesis;

$Title Design A Blood Supply Chain;

$Title Model BSC1;

$Title Mahdieh Ghasemi;

$Title University Of Science And Culture;

*parameters and indices and variables introduction:

*indices:

Sets

         h index of hospitals/h1,h2/

         b index of types of blood/b1,b2/

         t index of time periods/t1,t2,t3/

         i index of candid nodes for blood banks/i1,i2,i3/

         j index of donation centers/j1,j2/

         k index of blood facilities/k1,k2/

         v index of types of vehicles/v1,v2/

         alias (t,tp)

;

*************************************************************************************************************

*parameters:

Parameters

         cbc(i) The cost of setting up a blood bank at the candidate point i/i1 1200,i2 800,i3 1000/

         alpha Blood donation rate calculated by machine learning algorithms/1/

         cinv(k) The cost of purchasing and setting up a unit of type k storage equipment/k1 600,k2 800/

         rinv(k,b) The maximum number of blood units of type b that can be stored in equipment k/k1.b1 1000,k1.b2 1500,k2.b1 1500,k2.b2 1000/

         chold(b) The cost of maintaining a unit of type b blood for a period in the blood bank/b1 3,b2 5/

         o(v) Transport capacity of type v vehicle/v1 50,v2 80/

         s(b) The number of units required to transport one unit of product type b/b1 3,b2 2/

         d(h,b,t) The demand of treatment center h in period t for type b blood

         a(j,b,t) The amount of blood donated of type b in donation center j in period t

         ctest(i,b) The cost of conducting a test on a unit of blood of type b in the blood bank i

         l(i,h) The distance between blood bank i and treatment center h

         cvar(v,b) The variable cost of transporting each unit of type b blood by means of type v per unit distance

         cfix(v) The fixed cost of transporting each unit of blood by vehicle type v/v1 80,v2 30/

         oinv(k,i) Maximum storage equipment of type k on type i blood bank

         beta(t,b) The state of the amount of healthy blood of type b in period t

         m a very big number /1000000/

         otest(i,b,t) Maximum testable capacity of blood product type b in blood bank i in peroid t

         gvup(v,t) Maximum vehicle type v obtainable in period t

         gbup The upper limit of the number of blood banks that can be built/3/

         gblow The lower limit of the number of blood banks that can be built/1/

;

table d(h,b,t)

         t1      t2      t3

h1.b1    100     150     180

h1.b2    200     250     150

h2.b1    200     150     120

h2.b2    80      250     150

;

table a(j,b,t)

         t1      t2      t3

j1.b1    150     200     250

j1.b2    150     200     100

j2.b1    300     200     100

j2.b2    100     250     200

;

table ctest(i,b)

         b1      b2

i1       18      25

i2       15      30

i3       12      20

;

table l(i,h)

         h1      h2

i1       5       8

i2       8       10

i3       10      12

;

table cvar(v,b)

         b1      b2

v1       3       4

v2       2       3

;

table oinv(k,i)

         i1      i2      i3

k1       8       10      12

k2       10      12      15

;

table beta(t,b)

         b1      b2

t1       0.1     0.15

t2       0.05    0.1

t3       0.15    0.2

;

table otest(i,b,t)

         t1      t2      t3

i1.b1    150     150     150

i1.b2    200     250     250

i2.b1    250     300     350

i2.b2    100     150     150

i3.b1    100     150     250

i3.b2    150     250     350

;

table gvup(v,t)

         t1      t2      t3

v1       10      12      15

v2       10      15      20

;

***************************************************************************************************************

*variables:

Variables

         f1 The total cost of building blood bank centers

         f2 Total costs of blood storage in blood banks

         f3 The total costs of conducting tests on donated blood to check their health

         f4 Total fixed costs of sending blood to medical centers

         f5 total variable costs of sending blood to medical centers

         e(h,b,t) Deficiency rate of type b blood in period t in treatment center h

         wc(i,b,t) The amount of unusable tested blood of type b and in period t in blood bank i

         wb(i,b,t) The amount of unusable blood of type b and in period t in blood bank i

         qtest(i,b,t) The number of tested blood units of type b in period t and in blood bank i

         qtrns(i,h,b,v,t) Transfused blood units of type b from bank i to center h in period t by means v

         qinva(i,b,t) The amount of untested type b blood entering blood bank i in period t

         qinvb(i,b,t) Total untested blood of type b available in blood bank i in period t

         qinvc(i,b,t) The total amount of tested blood of type b in period t that is available in blood bank i

         z1 The first objective function of the problem

         z2 The second objective function of the problem

         z3 The third objective function of the problem

;

Binary Variables

         x(i) A binary variable that is equal to 1 if a blood bank is established at candidate point i

         u(i,h,t,v) Binary variable is equal to 1 if blood is sent from bank b to center h by device v in period t

;

integer variables

         y(k,i) Number of storage equipment type k in blood bank i

         qveh(v,t) Number of vehicle type v used in period t

;

***************************************************************************************************************

equations

*Objective Function

*Z1

         eq31

         eq32

         eq33

         eq34

         eq35

         eq36

*z2

         eq37

*z3

         eq38

*Constraints

         eq39

         eq310

         eq311(k,i)

         eq312(i,b,t)

         eq313(v,t)

         eq314(v,t)

         eq315(i,b,t)

         eq316(h,b,t)

         eq317(i,h,t,v)

         eq318(i,h,t,v)

         eq319(i,b,t)

         eq320(i,b,t)

         eq321(h,b,t)

         eq322(b,t)

         eq323(i,b,t)

         eq324(i,b,t)

         eq325(i,b,t)

         eq326(i)

         eq327(i)

         eq328(i,b,t)

         eq329(i)

         eq330(i)

;

***************************************************************************************************************

*Objective Function

*Z1

eq31            ..      z1=e=f1+f2+f3+f4+f5;

eq32            ..      f1=e=sum(i,cbc(i)*x(i));

eq33            ..      f2=e=sum(k,cinv(k)*sum(i,y(k,i)))+sum((i,b,t),qinvb(i,b,t)*chold(b))+sum((i,b,t),qinvc(i,b,t)*chold(b));

eq34            ..      f3=e=sum((i,b),ctest(i,b)*sum(t,qtest(i,b,t)));

eq35            ..      f4=e=sum((i,h,t,v),cfix(v)*u(i,h,t,v));

eq36            ..      f5=e=sum((i,h,b,v,t),cvar(v,b)*qtrns(i,h,b,v,t)*l(i,h));

*Z2

         eq37            ..      z2=e=sum((i,b,t),wc(i,b,t)+wb(i,b,t));

*Z3

         eq38            ..      z3=e=sum((h,b,t),e(h,b,t));

*Constraints

eq39            ..      sum(i,x(i))=l=gbup;

eq310           ..      gblow=l=sum(i,x(i));

eq311(k,i)      ..      y(k,i)=l=oinv(k,i);

eq312(i,b,t)    ..      (qinvb(i,b,t)+ qinvc(i,b,t))*s(b)=l=sum(k,rinv(k,b)*y(k,i));

eq313(v,t)      ..      sum((i,h,b),qtrns(i,h,b,v,t)*s(b))=l=qveh(v,t)*o(v);

eq314(v,t)      ..      qveh(v,t)=l=gvup(v,t);

eq315(i,b,t)    ..      qtest(i,b,t)=l=otest(i,b,t);

eq316(h,b,t)    ..      e(h,b,t)=e=d(h,b,t)-sum((v,i),qtrns(i,h,b,v,t));

eq317(i,h,t,v)  ..      sum(b,qtrns(i,h,b,v,t))=l=u(i,h,t,v)*m;

eq318(i,h,t,v)  ..      u(i,h,t,v)*m=l=sum(b,qtrns(i,h,b,v,t));

eq319(i,b,t)    ..      qtest(i,b,t)=l=qinvb(i,b,t);

eq320(i,b,t)    ..      sum((h,v),qtrns(i,h,b,v,t))=l=qinvc(i,b,t);

eq321(h,b,t)    ..      sum((i,v),qtrns(i,h,b,v,t))=l=d(h,b,t);

eq322(b,t)      ..      sum(j,a(j,b,t))=e=sum(i,qinva(i,b,t));

eq323(i,b,t)    ..      qinvc(i,b,t)=e=qinvc(i,b,t)+alpha*qtest(i,b,t-1)-sum((h,v),qtrns(i,h,b,v,t-1))-wc(i,b,t-1);

eq324(i,b,t)    ..      wc(i,b,t)=e=qinvc(i,b,t)*beta(t,b);

eq325(i,b,t)    ..      wb(i,b,t)=e=qinvb(i,b,t)*beta(t,b);

eq326(i)        ..      sum((b,t),qinvc(i,b,t))+sum((b,t),qinvb(i,b,t))+sum((b,t),qinva(i,b,t))=l=x(i)*m;

eq327(i)        ..      sum((b,t),wc(i,b,t)+wb(i,b,t)+qtest(i,b,t)+sum((h,v),qtrns(i,h,b,v,t)))=l=x(i)*m;

eq328(i,b,t)    ..      qinvb(i,b,t)=e=qinvb(i,b,t-1)+qinva(i,b,t-1)-wb(i,b,t-1)-qtest(i,b,t-1);

eq329(i)        ..      sum(k,y(k,i))=l=x(i)*m;

eq330(i)        ..      sum((h,t,v),u(i,h,t,v))=l=x(i);

***************************************************************************************************************

model BSC1 /all/;

option optca=0,optcr=0;

option limcol=1000 , limrow = 1000;

option MIP=CPLEX;

solve BSC1 using MIP minimizing z3;

display z1.l,z2.l,z3.l,wc.l,wb.l,qtest.l,qtrns.l,qinva.l,qinvb.l,qinvc.l,qveh.l,y.l,x.l,e.l,f1.l,f2.l,f3.l,f4.l,f5.l;






