function image_data=rd_imgser(filename,sizex,sizey,numimg)
%sizex and sizey are dimensions of image
%numimg is the number of images in the series
% if display_tag = 1, figure of large matrix is displayed

%Reads whole raw file as big 2D matrix

h = waitbar(0,'Reading RAW file...');
fid_image=fopen(filename,'r','l'); 
bigmatrix = fread(fid_image,[sizex,sizey*numimg],'uchar');
bigmatrix = bigmatrix';

% Splits large 2D matrix into 3D matrix, where each z slice is an image

waitbar(0.5,h,'Generating Image Series...');
image_data = zeros(sizey,sizex,numimg);  % preallocate 3-D array 

for frame=1:numimg
    for pixel=((frame-1)*sizey)+1:frame*sizey
    image_data(pixel-(frame-1)*sizey,:,frame) = bigmatrix(pixel,:);
    end
end
close(h)