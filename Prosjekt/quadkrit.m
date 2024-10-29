function V = quadkrit(Qx1,Qv,Qw,x1,x0,w,v)

V = ((x1-x0)'*Qx1*(x1-x0))/2 + sum(v'*Qv*v)/2 + sum(w'*Qw*w)/2;