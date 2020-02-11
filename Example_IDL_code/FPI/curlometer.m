function [ ji, rotb, divb ] = curlometer( sc1r, sc2r, sc3r, sc4r, bi1, bi2, bi3, bi4 )
% INOUT: 4 SC position in km, magnetic field in nT
% OUTPUT: electric current, |curl(B)|, |div(B)| in nA/(m^2)

mu0=4.*pi*1.e-7;

drx(1)=sc2r(1)-sc1r(1);
dry(1)=sc2r(2)-sc1r(2);
drz(1)=sc2r(3)-sc1r(3);
drx(2)=sc3r(1)-sc1r(1);
dry(2)=sc3r(2)-sc1r(2);
drz(2)=sc3r(3)-sc1r(3);
drx(3)=sc4r(1)-sc1r(1);
dry(3)=sc4r(2)-sc1r(2);
drz(3)=sc4r(3)-sc1r(3);

dbx(1)=bi2(1)-bi1(1);
dby(1)=bi2(2)-bi1(2);
dbz(1)=bi2(3)-bi1(3);
dbx(2)=bi3(1)-bi1(1);
dby(2)=bi3(2)-bi1(2);
dbz(2)=bi3(3)-bi1(3);
dbx(3)=bi4(1)-bi1(1);
dby(3)=bi4(2)-bi1(2);
dbz(3)=bi4(3)-bi1(3);

drcdrx=zeros(1,3);
drcdry=zeros(1,3);
drcdrz=zeros(1,3);

for i=1:3
    j0 = i+1;
    j = mod(j0,3);
    if j == 0
        j = 3;
    end
    k0 = i+2;
    k = mod(k0,3);
    if k == 0
        k = 3;
    end
    
    drcdrx(i) = dry(j)*drz(k)-dry(k)*drz(j);
    drcdry(i) = drz(j)*drx(k)-drz(k)*drx(j);
    drcdrz(i) = drx(j)*dry(k)-drx(k)*dry(j);
end

mat = [drcdrx(1) drcdry(1) drcdrz(1); drcdrx(2) drcdry(2) drcdrz(2); ...
    drcdrx(3) drcdry(3) drcdrz(3)];

rhs = [dbx(2)*drx(3)+dby(2)*dry(3)+dbz(2)*drz(3) - (dbx(3)*drx(2)+dby(3)*dry(2)+dbz(3)*drz(2)); ...
    dbx(3)*drx(1)+dby(3)*dry(1)+dbz(3)*drz(1) - (dbx(1)*drx(3)+dby(1)*dry(3)+dbz(1)*drz(3)); ...
    dbx(1)*drx(2)+dby(1)*dry(2)+dbz(1)*drz(2) - (dbx(2)*drx(1)+dby(2)*dry(1)+dbz(2)*drz(1))];

% mat2 = inv(mat);
% ji = mat2*rhs;
ji = mat\rhs;

ji = ji/mu0/1.e3;

rotb = sqrt(ji'*ji);

lhs = drx(1)*drcdrx(1) + dry(1)*drcdry(1) + drz(1)*drcdrz(1);
lhs2 = 0.;
rhs2 = 0.;
for j=1:3
    rhs2 = rhs2 + dbx(j)*drcdrx(j) + dby(j)*drcdry(j) + dbz(j)*drcdrz(j);
    lhs2 = lhs2 + drx(j)*drcdrx(j) + dry(j)*drcdry(j) + drz(j)*drcdrz(j);
end
%  divb = abs(rhs2)/abs(lhs2)/mu0/1.e3
divb = abs(rhs2)/abs(lhs)/mu0/1.e3;
