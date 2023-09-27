% s = c log(1+r), r>= 0
% s = c log^-1(1)
% s = c * r**y

OriginalImg = imread("img.jpg");
greyImg = im2gray(OriginalImg);
imageData = im2double(greyImg);

c = 1;
logTrans = c * log(1+imageData);
inverLogTrans = c * (10 .^ imageData);

y = .3;
powerlaw =  imageData .^ y;


subplot(2,2,1), imshow(greyImg)
subplot(2,2,2), imshow(logTrans)
subplot(2,2,3), imshow(inverLogTrans)
subplot(2,2,4), imshow(powerlaw)

%{
a1 = 10 * log10(1+imageData);
%a2 = 2.5 * log10(1+imageData);
%a3 = 5 * log10(1+imageData);


a2 = 10 * (10 .^ imageData);
%a2 = 1/2 * (10 .^ imageData);
%a3 = 1/2.5 * (10 .^ imageData);

%subplot(2,2,2), imshow(a1)
%subplot(2,2,3), imshow(a2)
subplot(2,2,2), imshow(rescale(a1))
subplot(2,2,3), imshow(rescale(a2))
%subplot(2,2,4), imshow(a3)
%}