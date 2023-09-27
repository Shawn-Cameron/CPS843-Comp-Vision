OriginalImg = imread("img.jpg");
greyImg = im2gray(OriginalImg);

for i = 1:8
    subplot(3,3,i), imshow(bitget(greyImg,i))
end

