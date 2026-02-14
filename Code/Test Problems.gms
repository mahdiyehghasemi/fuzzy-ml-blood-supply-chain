$Title Master Thesis;

$Title Design A Blood Supply Chain;

$Title Model BSC1;

$Title Mahdieh Ghasemi;

$Title University Of Science and Culture;

*parameters and indices and variables introduction:

*indices:

Sets

         ho index of hospitals/ho1,ho2,ho3/

         b index of types of blood/b1,b2,b3/

         t index of time periods/t1,t2,t3/

         i index of candid nodes for blood banks/i1,i2,i3,i4,i5/

         j index of donation centers/j1,j2,j3/

         ko index of blood facilities/k1,k2/

         v index of types of vehicles/v1,v2,v3/

         h objective function /cost,enviroment,social/

         alias (t,tp)

;

*************************************************************************************************************

*parameters:

Parameters

         cbc(i) The cost of setting up a blood bank at the candidate point i

         alpha Blood donation rate calculated by machine learning algorithms/0.80/

         cinv(ko) The cost of purchasing and setting up a unit of type ko storage equipment/k1 600,k2 800/

         rinv(ko,b) The maximum number of blood units of type b that can be stored in equipment ko

         chold(b) The cost of maintaining a unit of type b blood for a period in the blood bank/b1 3,b2 6,b3 8/

         o(v) Transport capacity of type v vehicle/v1 350,v2 400,v3 280/

         s(b) The number of units required to transport one unit of product type b/b1 3,b2 2,b3 4/

         d(ho,b,t) The demand of treatment center ho in period t for type b blood

         a(j,b,t) The amount of blood donated of type b in donation center j in period t

         ctest(i,b) The cost of conducting a test on a unit of blood of type b in the blood bank i

         l(i,ho) The distance between blood bank i and treatment center ho

         cvar(v,b) The variable cost of transporting each unit of type b blood by means of type v per unit distance

         cfix(v) The fixed cost of transporting each unit of blood by vehicle type v/v1 80,v2 30,v3 50/

         oinv(ko,i) Maximum storage equipment of type ko on type i blood bank

         beta(t,b) The state of the amount of healthy blood of type b in period t

         m a very big number /100000000/

         otest(i,b,t) Maximum testable capacity of blood product type b in blood bank i in peroid t

         gvup(v,t) Maximum vehicle type v obtainable in period t

         gbup The upper limit of the number of blood banks that can be built/5/

         gblow The lower limit of the number of blood banks that can be built/1/

         maxe(ho) upper limit of def dor eachtreat center

         budg /20000000/

;

parameter dir(h) 'direction of objective function'
                 /cost -1,enviroment -1,social -1/;

cbc(i)=uniformint(2500,3000);

d(ho,b,t)=uniformint(80,150);

a(j,b,t)=uniformint(200,350);

ctest(i,b)=uniformint(5,15);

l(i,ho)=uniformint(10,25);

cvar(v,b)=uniformint(10,15);

oinv(ko,i)=uniformint(20,35);

beta(t,b)=uniform(0.04,0.15);

otest(i,b,t)=uniformint(350,450);

gvup(v,t)=uniformint(15,25);

rinv(ko,b)=uniform(250,350);



***************************************************************************************************************

*variables:

Variables

         z1 The first objective function of the problem

         z2 The second objective function of the problem

         z3 The third objective function of the problem

         ztotal

         z(h)

positive Variables

         f1 The total cost of building blood bank centers

         f2 Total costs of blood storage in blood banks

         f3 The total costs of conducting tests on donated blood to check their health

         f4 Total fixed costs of sending blood to medical centers

         f5 total variable costs of sending blood to medical centers

         e(ho,b,t) Deficiency rate of type b blood in period t in treatment center ho

         wc(i,b,t) The amount of unusable tested blood of type b and in period t in blood bank i

         wb(i,b,t) The amount of unusable blood of type b and in period t in blood bank i

         qtest(i,b,t) The number of tested blood units of type b in period t and in blood bank i

         qtrns(i,ho,b,v,t) Transfused blood units of type b from bank i to center ho in period t by means v

         qinva(i,b,t) The amount of untested type b blood entering blood bank i in period t

         qinvb(i,b,t) Total untested blood of type b available in blood bank i in period t

         qinvc(i,b,t) The total amount of tested blood of type b in period t that is available in blood bank i

;

integer variables

         y(ko,i) Number of storage equipment type ko in blood bank i

         qveh(v,t) Number of vehicle type v used in period t

;

Binary Variables

         x(i) A binary variable that is equal to 1 if a blood bank is established at candidate point i

         u(i,ho,t,v) Binary variable is equal to 1 if blood is sent from bank b to center ho by device v in period t

;

***************************************************************************************************************

equations

obj1

obj2

obj3

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

         eq311(ko,i)

         eq312(i,b,t)

         eq313(v,t)

         eq314(v,t)

         eq315(i,b,t)

         eq316(ho,b,t)

         eq317(i,ho,t,v)

*eq318(i,ho,t,v)

         eq319(i,b,t)

         eq320(i,b,t)

         eq321(ho,b,t)

         eq322(b,t)

         eq323(i,b,t)

         eq324(i,b,t)

         eq325(i,b,t)

         eq326(i)

         eq327(i)

         eq328(i,b,t)

         eq329(i)

         eq330(i)

         eqzt

         limext

         limbudg

;

***************************************************************************************************************

obj1(h)$(ord(h)=1)  .. Z(h)=e=z1;

obj2(h)$(ord(h)=2)  .. Z(h)=e=z2;

obj3(h)$(ord(h)=3)  .. Z(h)=e=z3;

*Objective Function

*Z1

eq31            ..      z1=e=f1+f2+f3+f4+f5;

eq32            ..      f1=e=sum(i,cbc(i)*x(i));

eq33            ..      f2=e=sum(ko,cinv(ko)*sum(i,y(ko,i)))+sum((i,b,t),qinvb(i,b,t)*chold(b))+sum((i,b,t),qinvc(i,b,t)*chold(b));

eq34            ..      f3=e=sum((i,b),ctest(i,b)*sum(t,qtest(i,b,t)));

eq35            ..      f4=e=sum((i,ho,t,v),cfix(v)*u(i,ho,t,v));

eq36            ..      f5=e=sum((i,ho,b,v,t),cvar(v,b)*qtrns(i,ho,b,v,t)*l(i,ho));

*Z2

eq37            ..      z2=e=sum((i,b,t),wc(i,b,t)+wb(i,b,t));

*Z3

eq38            ..      z3=e=sum((ho,b,t),e(ho,b,t));

*Constraints

eq39            ..      sum(i,x(i))=l=gbup;

eq310           ..      gblow=l=sum(i,x(i));

eq311(ko,i)      ..      y(ko,i)=l=oinv(ko,i);

eq312(i,b,t)    ..      (qinvb(i,b,t)+ qinvc(i,b,t))*s(b)=l=sum(ko,rinv(ko,b)*y(ko,i));

eq313(v,t)      ..      sum((i,ho,b),qtrns(i,ho,b,v,t)*s(b))=l=qveh(v,t)*o(v);

eq314(v,t)      ..      qveh(v,t)=l=gvup(v,t);

eq315(i,b,t)    ..      qtest(i,b,t)=l=otest(i,b,t);

eq316(ho,b,t)    ..      e(ho,b,t)=e=d(ho,b,t)-sum((v,i),qtrns(i,ho,b,v,t));

eq317(i,ho,t,v)  ..      sum(b,qtrns(i,ho,b,v,t))=l=u(i,ho,t,v)*m;

*eq318(i,ho,t,v)  ..      u(i,ho,t,v)*m=l=sum(b,qtrns(i,ho,b,v,t));

eq319(i,b,t)    ..      qtest(i,b,t)=l=qinvb(i,b,t);

eq320(i,b,t)    ..      sum((ho,v),qtrns(i,ho,b,v,t))=l=qinvc(i,b,t);

eq321(ho,b,t)    ..      sum((i,v),qtrns(i,ho,b,v,t))=l=d(ho,b,t);

eq322(b,t)      ..      sum(j,a(j,b,t))=e=sum(i,qinva(i,b,t));

eq323(i,b,t)    ..      qinvc(i,b,t)=e=qinvc(i,b,t-1)+alpha*qtest(i,b,t)-sum((ho,v),qtrns(i,ho,b,v,t))-wc(i,b,t);

eq324(i,b,t)    ..      wc(i,b,t)=e=qinvc(i,b,t)*beta(t,b);

eq325(i,b,t)    ..      wb(i,b,t)=e=qinvb(i,b,t)*beta(t,b);

eq326(i)        ..      sum((b,t),qinvc(i,b,t))+sum((b,t),qinvb(i,b,t))+sum((b,t),qinva(i,b,t))=l=x(i)*m;

eq327(i)        ..      sum((b,t),wc(i,b,t)+wb(i,b,t)+qtest(i,b,t)+sum((ho,v),qtrns(i,ho,b,v,t)))=l=x(i)*m;

eq328(i,b,t)    ..      qinvb(i,b,t)=e=qinvb(i,b,t-1)+qinva(i,b,t)-wb(i,b,t)-qtest(i,b,t);

eq329(i)        ..      sum(ko,y(ko,i))=l=x(i)*m;

eq330(i)        ..      sum((ho,t,v),u(i,ho,t,v))=l=x(i)*m;

eqzt            ..      ztotal=e=((z1-95897)/95897)+((z2-634)/634)+((z3-1980)/1980);

limext          ..      sum((ho,b,t),e(ho,b,t))=l=sum((ho,b,t),d(ho,b,t));

limbudg         ..      f1+f2+f3+f4+f5=l=budg;

***************************************************************************************************************

model BSC1 /all/;


$sTitle eps-constraint Method
Set
   k1(h)  'the first element of k'
   km1(h) 'all but the first elements of k'
   kk(h)  'active objective function in constraint allobj';

k1(h)$(ord(h) = 1) = yes;
km1(h)  = yes;
km1(k1) =  no;

Parameter
   rhs(h)    'right hand side of the constrained obj functions in eps-constraint'
   maxobj(h) 'maximum value from the payoff table'
   minobj(h) 'minimum value from the payoff table'
   numk(h)   'ordinal value of k starting with 1';

Scalar
   iter         'total number of iterations'
   infeas       'total number of infeasibilities'
   elapsed_time 'elapsed time for payoff and e-sonstraint'
   start        'start time'
   finish       'finish time';

Variable
   a_objval 'auxiliary variable for the objective function'
   obj      'auxiliary variable during the construction of the payoff table'
   sl(h)    'slack or surplus variables for the eps-constraints';

Positive Variable sl;

Equation
   con_obj(h) 'constrained objective functions'
   augm_obj   'augmented objective function to avoid weakly efficient solutions'
   allobj     'all the objective functions in one expression';

con_obj(km1).. z(km1) - dir(km1)*sl(km1) =e= rhs(km1);

* We optimize the first objective function and put the others as constraints
* the second term is for avoiding weakly efficient points

augm_obj..
   a_objval =e= sum(k1,dir(k1)*z(k1))
         + 1e-3*sum(km1,power(10,-(numk(km1) - 1))*sl(km1)/(maxobj(km1) - minobj(km1)));

allobj.. sum(kk, dir(kk)*z(kk)) =e= obj;

Model
   mod_payoff    / BSC1, allobj            /
   mod_epsmethod / BSC1, con_obj, augm_obj /;

Parameter payoff(h,h) 'payoff tables entries';

Alias (h,kp);

option limCol = 0, solPrint = off, solveLink = %solveLink.LoadLibrary%;

* Generate payoff table applying lexicographic optimization
loop(kp,
   kk(kp) = yes;
   repeat
      option reslim=200;
      option iterlim=10000;
      option MIP=cplex;
      solve mod_payoff using mip maximizing obj;
      payoff(kp,kk) = z.l(kk);
      z.fx(kk) = z.l(kk);
      kk(h++1) = kk(h);
   until kk(kp);
   kk(kp) = no;

   z.up(h) =  inf;
   z.lo(h) = -inf;
);
if(mod_payoff.modelStat <> %modelStat.Optimal% and
   mod_payoff.modelStat <> %modelStat.Integer Solution%,
   abort 'no optimal solution for mod_payoff');

File fx / MHD.txt /;
put  fx ' PAYOFF TABLE'/;
loop(kp,
   loop(h, put payoff(kp,h):12:2);
   put /;
);

minobj(h) = smin(kp,payoff(kp,h));
maxobj(h) = smax(kp,payoff(kp,h));


$if not set gridpoints $set gridpoints 25
Set
   g1         'grid points' / g0*g%gridpoints% /
   grid(h,g1) 'grid';

Parameter
   gridrhs(h,g1) 'RHS of eps-constraint at grid point'
   maxg(h)      'maximum point in grid for objective'
   posg(h)      'grid position of objective'
   firstOffMax  'some counters'
   lastZero     'some counters'

   numg(g1)      'ordinal value of g starting with 0'
   step(h)      'step of grid points in objective functions'
   jump(h)      'jumps in the grid points traversing';

lastZero = 1;
loop(km1,
   numk(km1) = lastZero;
   lastZero  = lastZero + 1;
);
numg(g1) = ord(g1) - 1;

grid(km1,g1) = yes;
maxg(km1)   = smax(grid(km1,g1), numg(g1));
step(km1)   = (maxobj(km1) - minobj(km1))/maxg(km1);
gridrhs(grid(km1,g1))$(dir(km1) = -1) = maxobj(km1) - numg(g1)/maxg(km1)*(maxobj(km1) - minobj(km1));
gridrhs(grid(km1,g1))$(dir(km1) =  1) = minobj(km1) + numg(g1)/maxg(km1)*(maxobj(km1) - minobj(km1));

put / ' Grid points' /;
loop(g1,
   loop(km1, put gridrhs(km1,g1):12:2);
   put /;
);
put / 'Efficient solutions' /;


posg(km1) = 0;
iter   = 0;
infeas = 0;
start  = jnow;

repeat
   rhs(km1) = sum(grid(km1,g1)$(numg(g1) = posg(km1)), gridrhs(km1,g1));
   option reslim=200;
   option iterlim=10000;
   option MIP=cplex;
   solve mod_epsmethod maximizing a_objval using mip;
   iter = iter + 1;
   if(mod_epsmethod.modelStat<>%modelStat.Optimal% and
      mod_epsmethod.modelStat<>%modelStat.Integer Solution%,
      infeas = infeas + 1;
      put iter:5:0, '  infeasible' /;
      lastZero = 0;
      loop(km1$(posg(km1)  > 0 and lastZero = 0), lastZero = numk(km1));
      posg(km1)$(numk(km1) <= lastZero) = maxg(km1);
   else
      put iter:5:0;
      loop(h, put z.l(h):12:2);
      jump(km1) = 1;

      jump(km1)$(numk(km1) = 1) = 1 + floor(sl.L(km1)/step(km1));
      put '    'z1.l,z2.l,z3.l :12:2;
      loop(km1$(jump(km1)  > 1), put '   jump');
      put /;
   );

   firstOffMax = 0;
   loop(km1$(posg(km1) < maxg(km1) and firstOffMax = 0),
      posg(km1)   = min((posg(km1) + jump(km1)),maxg(km1));
      firstOffMax = numk(km1);
   );
   posg(km1)$(numk(km1) < firstOffMax) = 0;
   abort$(iter > 2000) 'more than 2000 iterations, something seems to go wrong'
until sum(km1$(posg(km1) = maxg(km1)),1) = card(km1) and firstOffMax = 0;

finish = jnow;
elapsed_time = (finish - start)*60*60*24;

put /;
put 'Infeasibilities = ', infeas:5:0 /;
put 'Elapsed time: ',elapsed_time:10:2, ' seconds' /;
