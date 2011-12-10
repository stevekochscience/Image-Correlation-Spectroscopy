function [XDim,YDim,TDim, PMTVoltage, PMTOffset, PMTGain, LaserPower] = FluoInfo(filename);

% Gives the spatial (XDim) and temporal (TDim) resolutions for a Fluoview
% Tiff file, as well at PMT info.  TDim may be ZDim for a Z stack.  Will
% not work for XYZT images stacks.
% David Kolin
% Aug 16, 2004

fid_image=fopen(filename,'r','l'); 
firstchunk = fread(fid_image,25000,'uchar');
hexchunk = (dec2hex(firstchunk))';
% this section gets the "encoded" time and spatial resolutions
match = ['000000045820000000'];
hexchunk = reshape(hexchunk,1,size(hexchunk,1)*size(hexchunk,2));
marker = findstr(match,hexchunk);
XDimLocation = marker + 62;
YDimLocation = marker + 262;
TDimLocation = marker + 462; 
XDim = hex2num(reverse(hexchunk(XDimLocation:XDimLocation+17)));
YDim = hex2num(reverse(hexchunk(YDimLocation:YDimLocation+17)));
TDim = hex2num(reverse(hexchunk(TDimLocation:TDimLocation+17)));
% this section gets the PMT voltage, gain and offset
matchheaderinfo = ['504D5420566F6C74616765'];    % finds "PMT Voltage"
marker2 = findstr(matchheaderinfo,hexchunk);
matchopen = ['4F70656E']; %finds "Open"
marker3 = findstr(matchopen,hexchunk);
matchequals = ['3D']; %finds all equals signs
marker4 = findstr(matchequals,hexchunk);
matchequals = ['25']; %finds all % signs
marker5 = findstr(matchequals,hexchunk);
for i = 1:size(marker2,2)
    PMTVoltage(i) = str2num(hexchunk(marker2(i)+33:2:marker2(i)+38));
    PMTOffset(i) = str2num(hexchunk(marker2(i)+65));
    PMTGain(i) = str2num(strrep(hexchunk(marker2(i)+89:2:marker2(i)+99),'E','.'));
end

for i = 1:size(marker3,2)
   LaserPower(i) = str2num(strrep(hexchunk(marker4(find((marker4 - marker3(i))>0,1,'first'))+3:2:marker5(find((marker5 - marker3(i))>0,1,'first'))),'E','.'));  
end

fclose(fid_image);