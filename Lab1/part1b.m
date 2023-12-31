close;

% Reading in image
OriginalImg = imread("tree.jpg");
greyImg = rgb2gray(OriginalImg);

% Collecting and Displaying the Bitplane images
subplot(3,3,1), imshow(greyImg); title('Original Image');
for i = 1:8
    subplot(3,3,i+1), imshow(bitget(greyImg,i) * 255); title(['bit-plane ', num2str(i)]);
end

% Getting the highest 4 bitplanes and converting them to the correct spot
% in the image
bit8Img = (2^7) * bitget(greyImg,8);
bit7Img = (2^6) * bitget(greyImg,7);
bit6Img = (2^5) * bitget(greyImg,6);
bit5Img = (2^4) * bitget(greyImg,5);

% Combining and displaying bit-plane images
figure;
subplot(1,2,1),imshow(bit8Img + bit7Img); title('2 highest bit-planes');
subplot(1,2,2),imshow(bit8Img + bit7Img + bit6Img + bit5Img); title('4 highest bit-planes');

