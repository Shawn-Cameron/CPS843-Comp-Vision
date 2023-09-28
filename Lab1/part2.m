OriginalImg = imread("img.jpg");
greyImg = rgb2gray(OriginalImg);
J1 = imadjust(greyImg,[],[],1);



subplot(3,3,1), imshow(greyImg)
imshow(bitget(greyImg,1) * 255)
for i = 1:8
    subplot(3,3,i+1), imshow(bitget(greyImg,i) * 255)
end

