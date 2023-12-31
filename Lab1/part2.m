% step 1 %
clear;
close;
origImg = imread("lake.jpg");

% Getting shear transformation function
a = 0.6;
tForm = maketform('affine',[1 0 0; a 1 0; 0 0 1]);
negTForm = maketform('affine',[1 0 0; -a 1 0; 0 0 1]);
color = [141,2,179]';

% Applying shear transformation
sampler = makeresampler({'cubic','nearest'}, 'fill');
shearImgPos = imtransform(origImg,tForm,sampler, 'FillValues',color);
shearImgNeg = imtransform(origImg,negTForm,sampler, 'FillValues',color);

% Displaying sheared and original Images
origImgFig = figure; imshow(origImg); title("Original Image");
shearImgPosFig = figure; imshow(shearImgPos); title('a = 0.6');
shearImgNegFig = figure; imshow(shearImgNeg); title('a = -0.6');


% step 2 %
[U,V] = meshgrid(0:100:1000,0:134:700); %uses image resolution
[X,Y] = tformfwd(tForm,U,V);
gray = 0.8 * [1 1 1];

% Defining points on original image for the circles
figure(origImgFig);
hold on;
line(U, V, 'Color',gray);
line(U',V','Color',gray);

% Defining points on sheared image for the circles
figure(shearImgPosFig);
hold on;
line(X, Y, 'Color',gray);
line(X',Y','Color',gray);

% Creating and displaying circles
for  u = 0:100:1000
    for v = 0:134:700
        theta = (0: 32)' * (2 * pi/32);
        uc = u + 20 * cos(theta);
        vc = v + 20 * sin(theta);
        [xc,yc] = tformfwd(tForm,uc,vc);  % applying transform function
        figure(origImgFig); line(uc,vc,'Color',gray);
        figure(shearImgPosFig); line(xc,yc,'Color', gray);
    end
end


% step 3 %

% Defining the method sampler
fillMethod = makeresampler({'cubic','nearest'},'fill');
replicateMethod = makeresampler({'cubic','nearest'},'replicate');
boundMethod = makeresampler({'cubic','nearest'},'bound');

% Computing the result image after transformation
fillOrigImg = imtransform(origImg,tForm,fillMethod, ...
                'XData',[-49 1500],'YData',[-49 750], ...
                'FillValues',color);

repOrigImg = imtransform(origImg,tForm,replicateMethod, ...
                'XData',[-49 1500],'YData',[-49 750], ...
                'FillValues',color);

boundOrigImg = imtransform(origImg,tForm,boundMethod, ...
                'XData',[-49 1500],'YData',[-49 750], ...
                'FillValues',color);

% Displaying images
figure;
subplot(2,2,1); imshow(fillOrigImg); title('Filled');
subplot(2,2,2); imshow(repOrigImg); title('Replicate');
subplot(2,2,[3 4]); imshow(boundOrigImg); title('Bound');


% step 4 %

% Defining the method sampler
cirMethod = makeresampler({'cubic','nearest'},'circular');
symMethod = makeresampler({'cubic','nearest'},'symmetric');

% Computing the result image after transformation
cirOrigImg = imtransform(origImg,tForm,cirMethod, ...
                'XData',[-149 1600],'YData',[-149 850], ...
                'FillValues',color);

symOrigImg = imtransform(origImg,tForm,symMethod, ...
                'XData',[-349 1800],'YData',[-349 1050], ...
                'FillValues',color);

% Displaying images
figure;
subplot(1,2,1); imshow(cirOrigImg); title('circular');
subplot(1,2,2); imshow(symOrigImg); title('symmetric');

