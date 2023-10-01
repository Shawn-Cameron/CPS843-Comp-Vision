close;

OriginalImg = imread("tree.jpg");
greyImg = rgb2gray(OriginalImg);
J1 = imadjust(greyImg,[],[],1);


subplot(3,3,1), imshow(greyImg)
imshow(bitget(greyImg,1) * 255)

for i = 1:8
    subplot(3,3,i+1), imshow(bitget(greyImg,i) * 255)
end

bit8Img = bitget(greyImg,8) * 255;
bit7Img = bitget(greyImg,7) * 255;
bit6Img = bitget(greyImg,6) * 255;
bit5Img = bitget(greyImg,5) * 255;

figure;

subplot(1,2,1),imshow(bit8Img + bit7Img)
subplot(1,2,2),imshow(bit8Img + bit7Img + bit6Img + bit5Img)

