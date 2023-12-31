% Part 1 %
close;

% Reading in image
OriginalImg = imread("tree.jpg");
greyImg = rgb2gray(OriginalImg);

% Applying log transformation functions
logTrans =   uint8( (255/log10(256)) * log10(double(greyImg) + 1) );
inverLogTrans =  uint8( 10.^(double(greyImg)) .^ (log10(256)/255) - 1); 

% Applying power law
powerlawLog =  im2double(greyImg) .^ 0.3 ;
powerlawInv =  im2double(greyImg) .^ 3 ;

% Displaying images
subplot(3,2,1), imshow(OriginalImg); title('Original Image');
subplot(3,2,2), imshow(greyImg); title('Grey Image');
subplot(3,2,3), imshow(logTrans); title('Log Transform')
subplot(3,2,4), imshow(inverLogTrans); title("Inverse Log Transform")
subplot(3,2,5), imshow(powerlawLog); title("Power Law 0.3")
subplot(3,2,6), imshow(powerlawInv); title("Power Law 3")


% Part 3 %

% Displaying orginal images
figure;
subplot(2,3,1), imshow(greyImg); title('Input: Before');
subplot(2,3,2), imshow(logTrans); title('Log Transform: Before')
subplot(2,3,3), imshow(inverLogTrans); title("Inverse Log Transform: Before")
subplot(2,3,4), imhist(greyImg); title("Input: Before")
subplot(2,3,5), imhist(logTrans); title("Log Transform: Before")
subplot(2,3,6), imhist(inverLogTrans); title("Inverse Log Transform: Before")

% Performing histogram equaliztion
greyImgEq = histeq(greyImg);
logTransEq = histeq(logTrans);
InverLogTransEq = histeq(inverLogTrans);

% Displaying Equalized images
figure;
subplot(2,3,1), imshow(greyImgEq); title('Input: After');
subplot(2,3,2), imshow(logTransEq); title('Log Transform: After')
subplot(2,3,3), imshow(InverLogTransEq); title("Inverse Log Transform: After")
subplot(2,3,4), imhist(greyImgEq); title("Input: After")
subplot(2,3,5), imhist(logTransEq); title("Log Transform: After")
subplot(2,3,6), imhist(InverLogTransEq); title("Inverse Log Transform: After")

