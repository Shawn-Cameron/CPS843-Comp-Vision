% Reading the image
Img = imread("img2.jpg");

% Blurring the image
blurredImg = imgaussfilt(Img,40);

% Calculating mask
mask = Img - blurredImg;


% Applying the high-boost filtering with k = 1 and k = 5
sharpImgk1 = Img + 1 * mask;
sharpImgk5 = Img + 5 * mask;

% Displaying the images
figure;
subplot(2, 2, 1), imshow(Img), title('Original Image');
subplot(2, 2, 2), imshow(blurredImg), title('Blurred Image');
subplot(2, 2, 3), imshow(sharpImgk1), title('Sharpened Image (k=1)');
subplot(2, 2, 4), imshow(sharpImgk5), title('Sharpened Image (k=5)');
