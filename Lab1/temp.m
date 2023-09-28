%{
L = 256;
J = imread('img.jpg');
I = rgb2gray(J)
log_I = uint8(log(double(I)+1) .* ((L - 1)/log(L)));
exp_I = uint8((exp(double(I)) .^ (log(L) / (L-1))) - 1);
subplot(2, 2, [1 2]); imshow(I); title('Input');
subplot(2, 2, 3); imshow(log_I); title('\itlog(I)');
subplot(2, 2, 4); imshow(exp_I); title('\itexp(I)');
%}

tempi=imread('img.jpg');
a = rgb2gray(tempi)

ad=im2double(a);
x=ad;
[r,c]=size(ad);
factor=1;
for i=1:r
    for j = 1:c
  x(i,j)= exp(ad(i,j)^factor)-1;
    end
end
subplot(1,2,1);imshow(ad);title('before');
subplot(1,2,2);imshow(x);title('after');