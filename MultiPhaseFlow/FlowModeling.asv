% Run load data first
LoadData;     % Takes some time depending on CPU frequenzy
%% Input matrix

% % Time mean with input 
% s_0 = 15;
% s_end = 20;
% X   = [mean(Xw220I),mean(Xw220(:,s_0:s_end));
%        mean(Xw250I),mean(Xw250(:,s_0:s_end));
%        mean(Xw300I),mean(Xw300(:,s_0:s_end));
%        mean(Xa01w50I),mean(Xa01w50(:,s_0:s_end));
%        mean(Xa01w100I),mean(Xa01w100(:,s_0:s_end));
%        mean(Xa01w150I),mean(Xa01w150(:,s_0:s_end));
%        mean(Xa01w200I),mean(Xa01w200(:,s_0:s_end));
%        mean(Xa02w50I),mean(Xa02w50(:,s_0:s_end));
%        mean(Xa02w100I),mean(Xa02w100(:,s_0:s_end));
%        mean(Xa02w150I),mean(Xa02w150(:,s_0:s_end));
%        mean(Xa02w200I),mean(Xa02w200(:,s_0:s_end));
%        mean(Xa03w50I),mean(Xa03w50(:,s_0:s_end));
%        mean(Xa03w100I),mean(Xa03w100(:,s_0:s_end));
%        mean(Xa03w150I),mean(Xa03w150(:,s_0:s_end));
%        mean(Xa03w200I),mean(Xa03w200(:,s_0:s_end));
%        mean(Xa03w300I),mean(Xa03w300(:,s_0:s_end));
%        mean(Xa04w50I),mean(Xa04w50(:,s_0:s_end));
%        mean(Xa04w100I),mean(Xa04w100(:,s_0:s_end));
%        mean(Xa04w150I),mean(Xa04w150(:,s_0:s_end));
%        mean(Xa04w200I),mean(Xa04w200(:,s_0:s_end));
%        mean(Xa05w50I),mean(Xa05w50(:,s_0:s_end));
%        mean(Xa05w100I),mean(Xa05w100(:,s_0:s_end));
%        mean(Xa05w150I),mean(Xa05w150(:,s_0:s_end));
%        mean(Xa05w200I),mean(Xa05w200(:,s_0:s_end));
%        mean(Xa06w50I),mean(Xa06w50(:,s_0:s_end));
%        mean(Xa06w100I),mean(Xa06w100(:,s_0:s_end));
%        mean(Xa06w150I),mean(Xa06w150(:,s_0:s_end));
%        mean(Xa06w200I),mean(Xa06w200(:,s_0:s_end));
%        mean(Xa06w300I),mean(Xa06w300(:,s_0:s_end))];

% Time mean
s_0 = 1;
s_end = 40;
X   = [mean(Xa00(1:floor(length(Xa00)/2),s_0:s_end));
       mean(Xa00(floor(length(Xa00)/2)+1:end,s_0:s_end));
       mean(Xa02(1:floor(length(Xa02)/2),s_0:s_end));
       mean(Xa02(floor(length(Xa02)/2)+1:end,s_0:s_end));
       mean(Xa04(1:floor(length(Xa04)/2),s_0:s_end));
       mean(Xa04(floor(length(Xa04)/2)+1:end,s_0:s_end));
       mean(Xw100(1:floor(length(Xw100)/2),s_0:s_end));
       mean(Xw100(floor(length(Xw100)/2)+1:end,s_0:s_end));
       mean(Xw150(1:floor(length(Xw150)/2),s_0:s_end));
       mean(Xw150(floor(length(Xw150)/2)+1:end,s_0:s_end));
       mean(Xw200(1:floor(length(Xw200)/2),s_0:s_end));
       mean(Xw200(floor(length(Xw200)/2)+1:end,s_0:s_end));
       mean(Xw220(1:floor(length(Xw220)/2),s_0:s_end));
       mean(Xw220(floor(length(Xw220)/2)+1:end,s_0:s_end));
       mean(Xw250(1:floor(length(Xw250)/2),s_0:s_end));
       mean(Xw250(floor(length(Xw250)/2)+1:end,s_0:s_end));
       mean(Xw300(1:floor(length(Xw300)/2),s_0:s_end));
       mean(Xw300(floor(length(Xw300)/2)+1:end,s_0:s_end));
       mean(Xa01w50(1:floor(length(Xa01w50)/2),s_0:s_end));
       mean(Xa01w50(floor(length(Xa01w50)/2)+1:end,s_0:s_end));
       mean(Xa01w100(1:floor(length(Xa01w100)/2),s_0:s_end));
       mean(Xa01w100(floor(length(Xa01w100)/2)+1:end,s_0:s_end));
       mean(Xa01w150(1:floor(length(Xa01w150)/2),s_0:s_end));
       mean(Xa01w150(floor(length(Xa01w150)/2)+1:end,s_0:s_end));
       mean(Xa01w200(1:floor(length(Xa01w200)/2),s_0:s_end));
       mean(Xa01w200(floor(length(Xa01w200)/2)+1:end,s_0:s_end));
       mean(Xa02w50(1:floor(length(Xa02w50)/2),s_0:s_end));
       mean(Xa02w50(floor(length(Xa02w50)/2)+1:end,s_0:s_end));
       mean(Xa02w100(1:floor(length(Xa02w100)/2),s_0:s_end));
       mean(Xa02w100(floor(length(Xa02w100)/2)+1:end,s_0:s_end));
       mean(Xa02w150(1:floor(length(Xa02w150)/2),s_0:s_end));
       mean(Xa02w150(floor(length(Xa02w150)/2)+1:end,s_0:s_end));
       mean(Xa02w200(1:floor(length(Xa02w200)/2),s_0:s_end));
       mean(Xa02w200(floor(length(Xa02w200)/2)+1:end,s_0:s_end));
       mean(Xa03w50(1:floor(length(Xa03w50)/2),s_0:s_end));
       mean(Xa03w50(floor(length(Xa03w50)/2)+1:end,s_0:s_end));
       mean(Xa03w100(1:floor(length(Xa03w100)/2),s_0:s_end));
       mean(Xa03w100(floor(length(Xa03w100)/2)+1:end,s_0:s_end));
       mean(Xa03w150(1:floor(length(Xa03w150)/2),s_0:s_end));
       mean(Xa03w150(floor(length(Xa03w150)/2)+1:end,s_0:s_end));
       mean(Xa03w200(1:floor(length(Xa03w200)/2),s_0:s_end));
       mean(Xa03w200(floor(length(Xa03w200)/2)+1:end,s_0:s_end));
       mean(Xa03w300(1:floor(length(Xa03w300)/2),s_0:s_end));
       mean(Xa03w300(floor(length(Xa03w300)/2)+1:end,s_0:s_end));
       mean(Xa04w50(1:floor(length(Xa04w50)/2),s_0:s_end));
       mean(Xa04w50(floor(length(Xa04w50)/2)+1:end,s_0:s_end));
       mean(Xa04w100(1:floor(length(Xa04w100)/2),s_0:s_end));
       mean(Xa04w100(floor(length(Xa04w100)/2)+1:end,s_0:s_end));
       mean(Xa04w150(1:floor(length(Xa04w150)/2),s_0:s_end));
       mean(Xa04w150(floor(length(Xa04w150)/2)+1:end,s_0:s_end));
       mean(Xa04w200(1:floor(length(Xa04w200)/2),s_0:s_end));
       mean(Xa04w200(floor(length(Xa04w200)/2)+1:end,s_0:s_end));
       mean(Xa05w50(1:floor(length(Xa05w50)/2),s_0:s_end));
       mean(Xa05w50(floor(length(Xa05w50)/2)+1:end,s_0:s_end));
       mean(Xa05w100(1:floor(length(Xa05w100)/2),s_0:s_end));
       mean(Xa05w100(floor(length(Xa05w100)/2)+1:end,s_0:s_end));
       mean(Xa05w150(1:floor(length(Xa05w150)/2),s_0:s_end));
       mean(Xa05w150(floor(length(Xa05w150)/2)+1:end,s_0:s_end));
       mean(Xa05w200(1:floor(length(Xa05w200)/2),s_0:s_end));
       mean(Xa05w200(floor(length(Xa05w200)/2)+1:end,s_0:s_end));
       mean(Xa06w50(1:floor(length(Xa06w50)/2),s_0:s_end));
       mean(Xa06w50(floor(length(Xa06w50)/2)+1:end,s_0:s_end));
       mean(Xa06w100(1:floor(length(Xa06w100)/2),s_0:s_end));
       mean(Xa06w100(floor(length(Xa06w100)/2)+1:end,s_0:s_end));
       mean(Xa06w150(1:floor(length(Xa06w150)/2),s_0:s_end));
       mean(Xa06w150(floor(length(Xa06w150)/2)+1:end,s_0:s_end));
       mean(Xa06w200(1:floor(length(Xa06w200)/2),s_0:s_end));
       mean(Xa06w200(floor(length(Xa06w200)/2)+1:end,s_0:s_end));
       mean(Xa06w300(1:floor(length(Xa06w300)/2),s_0:s_end));
       mean(Xa06w300(floor(length(Xa06w300)/2)+1:end,s_0:s_end))];
   
% % Time and sensor mean in sensor sections
% X   = [mean(mean(Xa00(1:5))),mean(mean(Xa00(6:15))),mean(mean(Xa00(16:20))),mean(mean(Xa00(21:30))),mean(mean(Xa00(31:35))),mean(mean(Xa00(36:40)));
%        mean(mean(Xa02(1:5))),mean(mean(Xa02(6:15))),mean(mean(Xa02(16:20))),mean(mean(Xa02(21:30))),mean(mean(Xa02(31:35))),mean(mean(Xa02(36:40)));
%        mean(mean(Xa04(1:5))),mean(mean(Xa04(6:15))),mean(mean(Xa04(16:20))),mean(mean(Xa04(21:30))),mean(mean(Xa04(31:35))),mean(mean(Xa04(36:40)));
%        mean(mean(Xw100(1:5))),mean(mean(Xw100(6:15))),mean(mean(Xw100(16:20))),mean(mean(Xw100(21:30))),mean(mean(Xw100(31:35))),mean(mean(Xw100(36:40)));
%        mean(mean(Xw150(1:5))),mean(mean(Xw150(6:15))),mean(mean(Xw150(16:20))),mean(mean(Xw150(21:30))),mean(mean(Xw150(31:35))),mean(mean(Xw150(36:40)));
%        mean(mean(Xw200(1:5))),mean(mean(Xw200(6:15))),mean(mean(Xw200(16:20))),mean(mean(Xw200(21:30))),mean(mean(Xw200(31:35))),mean(mean(Xw200(36:40)));
%        mean(mean(Xw220(1:5))),mean(mean(Xw220(6:15))),mean(mean(Xw220(16:20))),mean(mean(Xw220(21:30))),mean(mean(Xw220(31:35))),mean(mean(Xw220(36:40)));
%        mean(mean(Xw250(1:5))),mean(mean(Xw250(6:15))),mean(mean(Xw250(16:20))),mean(mean(Xw250(21:30))),mean(mean(Xw250(31:35))),mean(mean(Xw250(36:40)));
%        mean(mean(Xw300(1:5))),mean(mean(Xw300(6:15))),mean(mean(Xw300(16:20))),mean(mean(Xw300(21:30))),mean(mean(Xw300(31:35))),mean(mean(Xw300(36:40)));
%        mean(mean(Xa01w50(1:5))),mean(mean(Xa01w50(6:15))),mean(mean(Xa01w50(16:20))),mean(mean(Xa01w50(21:30))),mean(mean(Xa01w50(31:35))),mean(mean(Xa01w50(36:40)));
%        mean(mean(Xa01w100(1:5))),mean(mean(Xa01w100(6:15))),mean(mean(Xa01w100(16:20))),mean(mean(Xa01w100(21:30))),mean(mean(Xa01w100(31:35))),mean(mean(Xa01w100(36:40)));
%        mean(mean(Xa01w150(1:5))),mean(mean(Xa01w150(6:15))),mean(mean(Xa01w150(16:20))),mean(mean(Xa01w150(21:30))),mean(mean(Xa01w150(31:35))),mean(mean(Xa01w150(36:40)));
%        mean(mean(Xa01w200(1:5))),mean(mean(Xa01w200(6:15))),mean(mean(Xa01w200(16:20))),mean(mean(Xa01w200(21:30))),mean(mean(Xa01w200(31:35))),mean(mean(Xa01w200(36:40)));
%        mean(mean(Xa02w50(1:5))),mean(mean(Xa02w50(6:15))),mean(mean(Xa02w50(16:20))),mean(mean(Xa02w50(21:30))),mean(mean(Xa02w50(31:35))),mean(mean(Xa02w50(36:40)));
%        mean(mean(Xa02w100(1:5))),mean(mean(Xa02w100(6:15))),mean(mean(Xa02w100(16:20))),mean(mean(Xa02w100(21:30))),mean(mean(Xa02w100(31:35))),mean(mean(Xa02w100(36:40)));
%        mean(mean(Xa02w150(1:5))),mean(mean(Xa02w150(6:15))),mean(mean(Xa02w150(16:20))),mean(mean(Xa02w150(21:30))),mean(mean(Xa02w150(31:35))),mean(mean(Xa02w150(36:40)));
%        mean(mean(Xa02w200(1:5))),mean(mean(Xa02w200(6:15))),mean(mean(Xa02w200(16:20))),mean(mean(Xa02w200(21:30))),mean(mean(Xa02w200(31:35))),mean(mean(Xa02w200(36:40)));
%        mean(mean(Xa03w50(1:5))),mean(mean(Xa03w50(6:15))),mean(mean(Xa03w50(16:20))),mean(mean(Xa03w50(21:30))),mean(mean(Xa03w50(31:35))),mean(mean(Xa03w50(36:40)));
%        mean(mean(Xa03w100(1:5))),mean(mean(Xa03w100(6:15))),mean(mean(Xa03w100(16:20))),mean(mean(Xa03w100(21:30))),mean(mean(Xa03w100(31:35))),mean(mean(Xa03w100(36:40)));
%        mean(mean(Xa03w150(1:5))),mean(mean(Xa03w150(6:15))),mean(mean(Xa03w150(16:20))),mean(mean(Xa03w150(21:30))),mean(mean(Xa03w150(31:35))),mean(mean(Xa03w150(36:40)));
%        mean(mean(Xa03w200(1:5))),mean(mean(Xa03w200(6:15))),mean(mean(Xa03w200(16:20))),mean(mean(Xa03w200(21:30))),mean(mean(Xa03w200(31:35))),mean(mean(Xa03w200(36:40)));
%        mean(mean(Xa03w300(1:5))),mean(mean(Xa03w300(6:15))),mean(mean(Xa03w300(16:20))),mean(mean(Xa03w300(21:30))),mean(mean(Xa03w300(31:35))),mean(mean(Xa03w300(36:40)));
%        mean(mean(Xa04w50(1:5))),mean(mean(Xa04w50(6:15))),mean(mean(Xa04w50(16:20))),mean(mean(Xa04w50(21:30))),mean(mean(Xa04w50(31:35))),mean(mean(Xa04w50(36:40)));
%        mean(mean(Xa04w100(1:5))),mean(mean(Xa04w100(6:15))),mean(mean(Xa04w100(16:20))),mean(mean(Xa04w100(21:30))),mean(mean(Xa04w100(31:35))),mean(mean(Xa04w100(36:40)));
%        mean(mean(Xa04w150(1:5))),mean(mean(Xa04w150(6:15))),mean(mean(Xa04w150(16:20))),mean(mean(Xa04w150(21:30))),mean(mean(Xa04w150(31:35))),mean(mean(Xa04w150(36:40)));
%        mean(mean(Xa04w200(1:5))),mean(mean(Xa04w200(6:15))),mean(mean(Xa04w200(16:20))),mean(mean(Xa04w200(21:30))),mean(mean(Xa04w200(31:35))),mean(mean(Xa04w200(36:40)));
%        mean(mean(Xa05w50(1:5))),mean(mean(Xa05w50(6:15))),mean(mean(Xa05w50(16:20))),mean(mean(Xa05w50(21:30))),mean(mean(Xa05w50(31:35))),mean(mean(Xa05w50(36:40)));
%        mean(mean(Xa05w100(1:5))),mean(mean(Xa05w100(6:15))),mean(mean(Xa05w100(16:20))),mean(mean(Xa05w100(21:30))),mean(mean(Xa05w100(31:35))),mean(mean(Xa05w100(36:40)));
%        mean(mean(Xa05w150(1:5))),mean(mean(Xa05w150(6:15))),mean(mean(Xa05w150(16:20))),mean(mean(Xa05w150(21:30))),mean(mean(Xa05w150(31:35))),mean(mean(Xa05w150(36:40)));
%        mean(mean(Xa05w200(1:5))),mean(mean(Xa05w200(6:15))),mean(mean(Xa05w200(16:20))),mean(mean(Xa05w200(21:30))),mean(mean(Xa05w200(31:35))),mean(mean(Xa05w200(36:40)));
%        mean(mean(Xa06w50(1:5))),mean(mean(Xa06w50(6:15))),mean(mean(Xa06w50(16:20))),mean(mean(Xa06w50(21:30))),mean(mean(Xa06w50(31:35))),mean(mean(Xa06w50(36:40)));
%        mean(mean(Xa06w100(1:5))),mean(mean(Xa06w100(6:15))),mean(mean(Xa06w100(16:20))),mean(mean(Xa06w100(21:30))),mean(mean(Xa06w100(31:35))),mean(mean(Xa06w100(36:40)));
%        mean(mean(Xa06w150(1:5))),mean(mean(Xa06w150(6:15))),mean(mean(Xa06w150(16:20))),mean(mean(Xa06w150(21:30))),mean(mean(Xa06w150(31:35))),mean(mean(Xa06w150(36:40)));
%        mean(mean(Xa06w200(1:5))),mean(mean(Xa06w200(6:15))),mean(mean(Xa06w200(16:20))),mean(mean(Xa06w200(21:30))),mean(mean(Xa06w200(31:35))),mean(mean(Xa06w200(36:40)));
%        mean(mean(Xa06w300(1:5))),mean(mean(Xa06w300(6:15))),mean(mean(Xa06w300(16:20))),mean(mean(Xa06w300(21:30))),mean(mean(Xa06w300(31:35))),mean(mean(Xa06w300(36:40)));
%        ];
   
%% Output matrix

% Time mean, flowrates
Ycal =  [0.0, 0;
         0.0, 0;
         0.2, 0;
         0.2, 0;
         0.4, 0;
         0.4, 0;
         0.0, 100;
         0.0, 100;
         0.0, 150;
         0.0, 150;
         0.0, 200;
         0.0, 200;
         0.0, 220;
         0.0, 220;
         0.0, 250;
         0.0, 250;
         0.0, 300;
         0.0, 300;
         0.1, 50;
         0.1, 50;
         0.1, 100;
         0.1, 100;
         0.1, 150;
         0.1, 150;
         0.1, 200;
         0.1, 200;
         0.2, 50;
         0.2, 50;
         0.2, 100;
         0.2, 100;
         0.2, 150;
         0.2, 150;
         0.2, 200;
         0.2, 200;
         0.3, 50;
         0.3, 50;
         0.3, 100;
         0.3, 100;
         0.3, 150;
         0.3, 150;
         0.3, 200;
         0.3, 200;
         0.3, 300;
         0.3, 300;
         0.4, 50;
         0.4, 50;
         0.4, 100;
         0.4, 100;
         0.4, 150;
         0.4, 150;
         0.4, 200;
         0.4, 200;
         0.5, 50;
         0.5, 50;
         0.5, 100;
         0.5, 100;
         0.5, 150;
         0.5, 150;
         0.5, 200;
         0.5, 200;
         0.6, 50;
         0.6, 50;
         0.6, 100;
         0.6, 100;
         0.6, 150;
         0.6, 150;
         0.6, 200;
         0.6, 200;
         0.6, 300;
         0.6, 300];
     
%% Black Box modeling (Pure data driven)
% Ideas:
% - Different sensor combinations.
% - Different sensor mean combinations
% - Try with no mean calculations, collect all input data (different
% flowrates) in one matrix
% - Try with scaled and centered data
% - Try other models, i.e. ARX, DSR..
% - Try with pressure data (using calibrated model).

% % Removing outliers and selecting data
% X = [mean(X(:,1:6),2),X(:,8:26),X(:,28:30),mean(X(:,31:end),2)];

% Size of X and Y
Y = Ycal;
[ns,nx] = size(X);
ny = size(Y,2);
% Input data
X = [X, ones(ns,1)];          % Adding ones for bias estimation
Xcal = X;
[ns,nx] = size(X);

% LS
Bls = inv(X'*X)*X'*Y;
YhatLS = X*Bls;
errLS = Y - YhatLS;
RMSECls=sqrt(sum(errLS.^2))/ns  % Validation

% PCR
[U S V] = svd(X);                   % PCA / SVD
RMSECpcr = zeros(nx,1);
for a = 1:nx                        % PCR for all components
    U1 = U(:,1:a);
    S1 = S(1:a,1:a);
    V1 = V(:,1:a);
    T = U1*S1;                      % Score vector matrix.
    P = V1;                         % Loading vector matrix.
    E = X-T*P';                     % Residuale
    Bpcr = P*inv(T'*T)*T'*Y;        % or Bpcr=V1*inv(S1)*U1'*y;
    YhatPCR = X*Bpcr;
    errPCR = Y - YhatPCR;
    RMSECpcr(a)=sum(sqrt(sum(errPCR).^2)/ns);
end
% a = find(RMSECpcr == min(RMSECpcr));    % Chosing optimal compnents
a = 3;
U1 = U(:,1:a);
S1 = S(1:a,1:a);
V1 = V(:,1:a);
T = U1*S1;                      % Score vector matrix.
P = V1;                         % Loading vector matrix.
E = X-T*P';                     % Residuale
Bpcr = P*inv(T'*T)*T'*Y;        % or Bpcr=V1*inv(S1)*U1'*y;
YhatPCR = X*Bpcr;
errPCR = Y - YhatPCR;
RMSECpcr = sqrt(sum(errPCR.^2))/ns

% PLS
% Allocate memory to the maximum size 
n=max(nx,ny);
T=zeros(ns,n);
P=zeros(nx,n);
U=zeros(ns,n);
Q=zeros(ny,n);
B=zeros(n,1);
W=P;
k=0;
tol=1e-10;
% iteration loop if residual is larger than specfied
while norm(Y)>tol && k<n
    % choose the column of x has the largest square of sum as t.
    % choose the column of y has the largest square of sum as u.    
    [dummy,tidx] =  max(sum(X.*X));
    [dummy,uidx] =  max(sum(Y.*Y));
    t1 = X(:,tidx);
    u = Y(:,uidx);
    t = zeros(ns,1);
    % iteration for outer modeling until convergence
    while norm(t1-t) > tol
        w = X'*u;
        w = w/norm(w);
        t = t1;
        t1 = X*w;
        q = Y'*t1;
        q = q/norm(q);
        u = Y*q;
    end
    % update p based on t
    t=t1;
    p=X'*t/(t'*t);
    pnorm=norm(p);
    p=p/pnorm;
    t=t*pnorm;
    w=w*pnorm;
    
    % regression and residuals
    b = u'*t/(t'*t);
    X = X - t*p';
    Y = Y - b*t*q';
    
    % save iteration results to outputs:
    k=k+1;
    T(:,k)=t;
    P(:,k)=p;
    U(:,k)=u;
    Q(:,k)=q;
    W(:,k)=w;
    B(k)=b;
%    uncomment the following line if you wish to see the convergence
%    disp(norm(Y))
end
Bpls = W*inv(P'*W)*inv(T'*T)*T'*Ycal;
YhatPLS = Xcal*Bpls;
errPLS = Ycal - YhatPLS;
RMSECpls=sqrt(sum(errPLS.^2))/ns    % Validation

%% Results
% Time series test
Yt = ([Xa06w200t(:,s_0:s_end),ones(length(Xa06w200t),1)])*Bpcr;

%% Parameters for unit change
rhog = 1.12;    % [kg/m^3]
rhow = 1000;    % [kg/m^3]

figure(1)
plot(0:0.1:(length(Yt)-1)*0.1,1000*Yt(:,1)/(rhog*60),0:0.1:(length(Yt)-1)*0.1,1000*Yt(:,2)/(rhow*60))
legend('luft','vann')

% Plot
figure(2)
subplot(211)
n = 1:length(Ycal);
plot(n,1000*Ycal(:,1)/(rhog*60),'-r',n,1000*YhatPCR(:,1)/(rhog*60),'-b')
subplot(212)
plot(n,1000*Ycal(:,2)/(rhow*60),'-r',n,1000*YhatPCR(:,2)/(rhow*60),'-b')

%% Analyse av data
% Estimerer
Yt00 = ([Xa00(:,s_0:s_end),ones(length(Xa00),1)])*Bpcr;
Yt01 = ([Xa02(:,s_0:s_end),ones(length(Xa02),1)])*Bpcr;
Yt02 = ([Xa04(:,s_0:s_end),ones(length(Xa04),1)])*Bpcr;
Yt03 = ([Xw100(:,s_0:s_end),ones(length(Xw100),1)])*Bpcr;
Yt04 = ([Xw150(:,s_0:s_end),ones(length(Xw150),1)])*Bpcr;
Yt05 = ([Xw200(:,s_0:s_end),ones(length(Xw200),1)])*Bpcr;
Yt06 = ([Xw220(:,s_0:s_end),ones(length(Xw220),1)])*Bpcr;
Yt07 = ([Xw250(:,s_0:s_end),ones(length(Xw250),1)])*Bpcr;
Yt08 = ([Xw300(:,s_0:s_end),ones(length(Xw300),1)])*Bpcr;
Yt09 = ([Xa01w50(:,s_0:s_end),ones(length(Xa01w50),1)])*Bpcr;
Yt10 = ([Xa01w100(:,s_0:s_end),ones(length(Xa01w100),1)])*Bpcr;
Yt11 = ([Xa01w150(:,s_0:s_end),ones(length(Xa01w150),1)])*Bpcr;
Yt12 = ([Xa01w200(:,s_0:s_end),ones(length(Xa01w200),1)])*Bpcr;
Yt13 = ([Xa02w50(:,s_0:s_end),ones(length(Xa02w50),1)])*Bpcr;
Yt14 = ([Xa02w100(:,s_0:s_end),ones(length(Xa02w100),1)])*Bpcr;
Yt15 = ([Xa02w150(:,s_0:s_end),ones(length(Xa02w150),1)])*Bpcr;
Yt16 = ([Xa02w200(:,s_0:s_end),ones(length(Xa02w200),1)])*Bpcr;
Yt17 = ([Xa03w50(:,s_0:s_end),ones(length(Xa03w50),1)])*Bpcr;
Yt18 = ([Xa03w100(:,s_0:s_end),ones(length(Xa03w100),1)])*Bpcr;
Yt19 = ([Xa03w150(:,s_0:s_end),ones(length(Xa03w150),1)])*Bpcr;
Yt20 = ([Xa03w200(:,s_0:s_end),ones(length(Xa03w200),1)])*Bpcr;
Yt21 = ([Xa03w300(:,s_0:s_end),ones(length(Xa03w300),1)])*Bpcr;
Yt22 = ([Xa04w50(:,s_0:s_end),ones(length(Xa04w50),1)])*Bpcr;
Yt23 = ([Xa04w100(:,s_0:s_end),ones(length(Xa04w100),1)])*Bpcr;
Yt24 = ([Xa04w150(:,s_0:s_end),ones(length(Xa04w150),1)])*Bpcr;
Yt25 = ([Xa04w200(:,s_0:s_end),ones(length(Xa04w200),1)])*Bpcr;
Yt26 = ([Xa05w50(:,s_0:s_end),ones(length(Xa05w50),1)])*Bpcr;
Yt27 = ([Xa05w100(:,s_0:s_end),ones(length(Xa05w100),1)])*Bpcr;
Yt28 = ([Xa05w150(:,s_0:s_end),ones(length(Xa05w150),1)])*Bpcr;
Yt29 = ([Xa05w200(:,s_0:s_end),ones(length(Xa05w200),1)])*Bpcr;
Yt30 = ([Xa06w50(:,s_0:s_end),ones(length(Xa06w50),1)])*Bpcr;
Yt31 = ([Xa06w100(:,s_0:s_end),ones(length(Xa06w100),1)])*Bpcr;
Yt32 = ([Xa06w150(:,s_0:s_end),ones(length(Xa06w150),1)])*Bpcr;
Yt33 = ([Xa06w200(:,s_0:s_end),ones(length(Xa06w200),1)])*Bpcr;
Yt34 = ([Xa06w300(:,s_0:s_end),ones(length(Xa06w300),1)])*Bpcr;

%% Gray box modeling (Partially data driven)
% Ideas
% - Combine physical model and estimation to calculate pressure.

%% White box modeling (Pure physical model)
% Ideas 
% - Pretreat data and use pure physical model to calculate flowrates
