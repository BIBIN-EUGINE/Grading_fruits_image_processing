tic;
%MATLAB code for finding ripness, size and defects of the apple

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputing the image
Im1 = imread('IMG_1253.jpg'); 
figure,imagesc(Im1);
title('Input Color Image');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%coverting to the gray scale
grayIm1 = rgb2gray(Im1);
figure,imagesc(grayIm1),colorbar(),colormap gray;
title('Gray Scale Image');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adding noise to the image (if you donot want to add noise, uncomment the lines 14 and 15)
% grayIm1(1:10:end,1:10:end) = max(grayIm1(:)); 
% figure,imagesc(grayIm1),colormap gray;
% title(' Noisy Image');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% grayIm1 = medfilt2(grayIm1); % solution for the noise
% figure,imagesc(grayIm1),colormap gray;
% title('Filtered Gray Scale Image');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Find the magnitude and phase spectrum(for analysising the input image)
img   = fftshift(Im1(:,:,2));
F     = fft2(img);
figure,imagesc(100*log(1+abs(fftshift(F)))); colormap(gray); 
title('magnitude spectrum');
figure,imagesc(angle(F));  colormap(gray);
title('phase spectrum');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Histogram
[M,N,L]=size(Im1);
grayimg=zeros(M,N);
grayimg(:)=0.3*Im1(:,:,1) + 0.59*Im1(:,:,2) + 0.11*Im1(:,:,3);
imin=min(min(grayimg));
grayimg=grayimg-imin;
imax=max(max(grayimg));
grayimg= floor(grayimg/imax*64);
figure,hist(grayimg(:),32);
xlabel('Intensity');
ylabel('No. of pixels');
title('Histogram of The Input image');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%feature extraction
Threshold = 180;
binaryIm1 = grayIm1>Threshold;
figure, imagesc(binaryIm1),colorbar(),colormap gray;
title('Binary Image');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%edge detection
bw = edge(binaryIm1,'canny');
figure,imagesc(bw),colorbar(),colormap gray;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% filling the holes
bw1 = imfill(bw,'holes');
figure,imagesc(bw1),colorbar();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%size of the apple
count2 = 0;
[m,n] = size(binaryIm);
for i=1:m
    for j=1:n
        if(binaryIm(i,j)==0)
            count2 = count2 +1;
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Applying threshold values to  find the size
if(count2 > 1800000)
    title('Large Sized Apple');
else if(count2<1000000)
        title('Small Sized Apple');
    else
        title('Medium Sized Apple');
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Finding the ripness
Im2 = Im1;
idx = all(Im1>=160,3);
Im1(repmat(idx,[1,1,3])) = 0;
figure,image(Im1);% Converting to new image with black background
title('Background Changed');
figure,image(Im2);%
grayIm1 = rgb2gray(Im1); % New gray scale image
[M,N] = size(grayIm1());
alpha = 20; %Thresholding for extracting the red components
count = 1;
count1 = 1;
for i = 1:M
    for j = 1:N
        if(grayIm1(i,j)>alpha && grayIm1(i,j)<alpha + 120)
            count = count + 1;
        elseif(grayIm1(i,j)>alpha+120)
            count1 = count1 + 1;
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R = count/count1; % ratio red components by non red components
if (R>1)
    title('Ripe');
else if(R>0.7 && R<1)
        title('Semi Ripe');
    else
        title('Unripe');
    end
end

toc;


    

