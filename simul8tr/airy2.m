function y = airy2(x)
%
% AIRY
%
%   The command y = airy(r) computes the first-order Airy disk
%  over the domain r which can be either a vector or matrix.
%  The Airy disk describes the Fraunhofer diffraction pattern
%  of a circular aperature in terms of light intensity:
%
%             | J1(2pir) |2 
%        I  = |----------|
%             |    r     |  
%  
%  Where J1 is a Bessel function of integer order 1.
%
%  See also SINC, BESSEL
%
%                                                           RJM 10/18/94
warning('off','MATLAB:divideByZero');
y=bessel(1,x)./x;
warning('off','MATLAB:divideByZero');
[n,m]=find(x==0);
for i=1:length(n),
  y(n(i),m(i))=.5;
end

y=y.^2;