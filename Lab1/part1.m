% Part 1
%fix equations
L= 256;
OriginalImg = imread("img.jpg");
greyImg = rgb2gray(OriginalImg);


logTrans =  uint8( ((L - 1)/log(L)) * log(1+double(greyImg)) );
inverLogTrans = uint8( (exp(double(greyImg)) .^ (log(L)/(L-1))) - 1);

powerlawLog =  im2double(greyImg) .^ 0.3 ;
powerlawInv =  im2double(greyImg) .^ 3 ;


subplot(3,2,[1,2]), imshow(greyImg); title('Input');
subplot(3,2,3), imshow(logTrans); title('Log Transform')
subplot(3,2,4), imshow(inverLogTrans); title("Inverse Log Transform")
subplot(3,2,5), imshow(powerlawLog); title("Power Law 0.3")
subplot(3,2,6), imshow(powerlawInv); title("Power Law 3")


%part 3
figure;

subplot(2,3,1), imshow(greyImg); title('Input');
subplot(2,3,2), imshow(logTrans); title('Log Transform')
subplot(2,3,3), imshow(inverLogTrans); title("Inverse Log Transform")
subplot(2,3,4), imhist(greyImg); title("Input")
subplot(2,3,5), imhist(logTrans); title("Log")
subplot(2,3,6), imhist(inverLogTrans); title("Inverse")

greyImgEq = histeq(greyImg);
logTransEq = histeq(logTrans);
InverLogTransEq = histeq(inverLogTrans);

figure;
subplot(2,3,1), imshow(greyImgEq); title('Input');
subplot(2,3,2), imshow(logTransEq); title('Log Transform')
subplot(2,3,3), imshow(InverLogTransEq); title("Inverse Log Transform")
subplot(2,3,4), imhist(greyImgEq); title("Input")
subplot(2,3,5), imhist(logTransEq); title("Log")
subplot(2,3,6), imhist(InverLogTransEq); title("Inverse")

