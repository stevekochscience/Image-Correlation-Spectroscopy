function [image_data_corr,noiseblock] = wnCorr(image_data);

figure
colormap(hot(256));
imagesc(image_data(:,:,1))
title('Please select a background region');
[im, rect] = imcrop;
close;
rect = floor(rect);

image_data_corr = uint16(zeros(size(image_data))); % Pre-allocates matrix

for i=1:size(image_data,3)
    image_data_corr(:,:,i) = (image_data(:,:,i) - uint16(ceil(mean2(imcrop(image_data(:,:,i),rect)))));
    noiseblock(:,:,i) = imcrop(image_data(:,:,i),rect);
end


%imhist(imcrop(image_data(:,:,1),rect));

negindex = find(image_data_corr < 0);
image_data_corr(negindex) = 0;