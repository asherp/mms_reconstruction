function [ angle ] = dangle( v1,v2 )
%Angle between 2 vectors v1 and v2

  v1n = v1/norm(v1);
  v2n = v2/norm(v2);
  angle = acosd( abs( dot( v1 , v2 ) ) );


end

