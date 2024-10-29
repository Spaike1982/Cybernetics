function H = hessian(fun,k,varargin)

J = jacobi(fun,k,varargin{:});
H = cross(J*J');