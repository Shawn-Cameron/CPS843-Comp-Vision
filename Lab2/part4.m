close all;
% Load image and convert to grey scale
Img = rgb2gray(imread('img.jpg'));

% Adding noise to the image
noiseLevel1 = 0.05;
noiseLevel2 = 0.15;
noiseImg1 = imnoise(Img,"gaussian",0,noiseLevel1);
noiseImg2 = imnoise(Img,"gaussian",0,noiseLevel2);

% Displaying the noisy images
figure;
subplot(2,2,[1,2]), imshow(Img), title("Original Grey scale image");
subplot(2,2,3), imshow(noiseImg1), title("Noise level 1");
subplot(2,2,4), imshow(noiseImg2), title("Noise level 2");

% Applying Average filter with sizes 3 and 9
filtSize1 = 3;
filtSize2 = 9;
avgFiltSize1Lvl1 = imfilter(noiseImg1,fspecial("average",filtSize1),"replicate");
avgFiltSize1Lvl2 = imfilter(noiseImg2,fspecial("average",filtSize1),"replicate");
avgFiltSize2Lvl1 = imfilter(noiseImg1,fspecial("average",filtSize2),"replicate");
avgFiltSize2Lvl2 = imfilter(noiseImg2,fspecial("average",filtSize2),"replicate");


%Applying Gaussian filter
std = 4;
gausFilt1 = imgaussfilt(noiseImg1,std);
gausFilt2 = imgaussfilt(noiseImg2,std);

% Displaying results
figure;
subplot(2,2,1), imshow(avgFiltSize1Lvl1), title("Avg Filter size "+ num2str(filtSize1)+ ", Noise Level 1");
subplot(2,2,2), imshow(avgFiltSize1Lvl2), title("Avg Filter size "+ num2str(filtSize1)+ ", Noise Level 2");
subplot(2,2,3), imshow(avgFiltSize2Lvl1), title("Avg Filter size "+ num2str(filtSize2)+ ", Noise Level 1");
subplot(2,2,4), imshow(avgFiltSize2Lvl2), title("Avg Filter size "+ num2str(filtSize2)+ ", Noise Level 2");

figure;
subplot(1,2,1), imshow(gausFilt1), title("Gaussian Filter, Noise Level 1");
subplot(1,2,2), imshow(gausFilt2), title("Gaussian Filter, Noise Level 2");