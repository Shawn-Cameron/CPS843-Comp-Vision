OriginalImg = imread("img.jpg");
greyImg = im2gray(OriginalImg);

subplot(3,3,1), imshow(greyImg)
for i = 1:8
    subplot(3,3,i+1), imshow(bitget(greyImg,i))
end

