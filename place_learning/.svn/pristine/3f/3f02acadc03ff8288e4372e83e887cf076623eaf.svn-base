function Num_resp = send_TEM_serial_command(s, Address, command_code, val)
% AA is address, right now just 1 through 4
% command is one of codes
% right now this function does no error checking...

if nargin == 3
    val = '';
else
    if (length(val) ~= 8)
        warning('val input is incorrect and will be ignored')
        val = '';
    end
end
str = [Address command_code val];

% compute checksum:
tmp_sum = 0;
for j = 1:length(str)
   tmp_sum = tmp_sum + double(str(j));
end
tmp_sum = mod(tmp_sum, 256);

send_str = ['*' str lower(dec2hex(tmp_sum))];
[out,count,msg] = query(s,send_str,'%s\n');

% throw in some error checking here
% clean up the returned data
if ((out(1) ~= '*')|(length(out) ~=12))
    warning(['return value not as expected: ' out])

else
     %modify to take care of two's comp:
     % comment out b\c of no fixed point toolbox
     %Num_resp = hex2num(q, out(2:9));
     %Num_resp1 = hex2dec_twos(out(2:9),8)
     
     %Num_resp = nhex2dec(out(2:9),32);  
     %Num_resp = hex2dec(out(2:9));  
     Num_resp = out(2:9);

end 
end