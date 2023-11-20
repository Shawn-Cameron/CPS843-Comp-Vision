% closes all figures
close all; 

% reading in the image
ColoredIMG = imread("img.jpg");
Img = rgb2gray(ColoredIMG);

% Preforming edge detection
robertsED = edge(Img,'roberts');
prewittED = edge(Img,'prewitt');
sobelED = edge(Img,'sobel');

% Displaying all images
figure, imshow(ColoredIMG), title("Original Img");
figure, imshow(Img), title("Grey Scale");
figure, imshow(robertsED), title("Roberts");
figure, imshow(prewittED), title("Prewitt");
figure, imshow(sobelED), title("Sobel");


