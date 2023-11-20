close all;
% Reading Images
Img1 = imread("lowLight1.jpg");
Img2 = imread("lowLight2.jpg");

% Applying Localized Brightening
locBright = imlocalbrighten(Img1);

% Displaying images and histogram
figure;
subplot(2,2,1), imshow(Img1), title("Original Image");
subplot(2,2,2), imhist(Img1), title("Original Image hist");
subplot(2,2,3), imshow(locBright), title("Brightened Image");
subplot(2,2,4), imhist(locBright), title("Brightened Image hist");

% Setting custom brightning amount
amount = 0.25;
locBrightAmt = imlocalbrighten(Img1,amount);

% Including Alpha Blending
locBrightAmtAlpha = imlocalbrighten(Img1,amount, AlphaBlend=true);

% Displaying images
figure;
subplot(2,2,1), imshow(Img1), title("Original Image");
subplot(2,2,2), imshow(locBright), title("Brightened Image");
subplot(2,2,3), imshow(locBrightAmt), title("Brightened Image with amount");
subplot(2,2,4), imshow(locBrightAmtAlpha), title("Brightened Image with amount and Alpha");

% Brightening and displaying the image with a different method
figure; 
subplot(2,2,[1,2]), imshow(Img2), title("Original Image");
subplot(2,2,3), imshow(imlocalbrighten(Img2)), title("Local Brightening");
subplot(2,2,4), imshow(histeq(Img2)), title("Historgram Equalization");