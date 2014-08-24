function [hexstring]=ndec2hex(x,n)
% x : input decimal number
% n :   number of bits to perform 2's complements
% hexstring : hex representation of two's complement of x
if x<0
    x=x+2^n;
end
hexstring=dec2hex(x,n/4);