%part 1
clear;
close;
origImg = imread("lake.jpg");

a = 0.6;
tForm = maketform('affine',[1 0 0; a 1 0; 0 0 1]);
negTForm = maketform('affine',[1 0 0; -a 1 0; 0 0 1]);
color = [141,2,179]';

sampler = makeresampler({'cubic','nearest'}, 'fill');
shearImgPos = imtransform(origImg,tForm,sampler, 'FillValues',color);
shearImgNeg = imtransform(origImg,negTForm,sampler, 'FillValues',color);

origImgFig = figure; imshow(origImg); title("Original Image");
shearImgPosFig = figure; imshow(shearImgPos); title('a = 0.6');
%shearImgNegFig = figure; imshow(shearImgNeg); title('a = -0.6');


%part 2
[U,V] = meshgrid(0:100:1000,0:134:700); %uses image resolution
[X,Y] = tformfwd(tForm,U,V);
gray = 0.8 * [1 1 1];

figure(origImgFig);
hold on;
line(U, V, 'Color',gray);
line(U',V','Color',gray);

figure(shearImgPosFig);
hold on;
line(X, Y, 'Color',gray);
line(X',Y','Color',gray);

for  u = 0:100:1000
    for v = 0:134:700
        theta = (0: 32)' * (2 * pi/32);
        uc = u + 20 * cos(theta);
        vc = v + 20 * sin(theta);
        [xc,yc] = tformfwd(tForm,uc,vc);
        %figure(origImgFig); line(uc,vc,'Color',gray);
        %figure(shearImgPosFig); line(xc,yc,'Color', gray);
    end
end


%part 3
close;

fillMethod = makeresampler({'cubic','nearest'},'fill');
replicateMethod = makeresampler({'cubic','nearest'},'replicate');
boundMethod = makeresampler({'cubic','nearest'},'bound');

fillOrigImg = imtransform(origImg,tForm,fillMethod, ...
                'XData',[-49 1500],'YData',[-49 750], ...
                'FillValues',color);

repOrigImg = imtransform(origImg,tForm,replicateMethod, ...
                'XData',[-49 1500],'YData',[-49 750], ...
                'FillValues',color);

boundOrigImg = imtransform(origImg,tForm,boundMethod, ...
                'XData',[-49 1500],'YData',[-49 750], ...
                'FillValues',color);

figure; imshow(fillOrigImg); title('Filled');
figure; imshow(repOrigImg); title('Replicate');
figure; imshow(boundOrigImg); title('Bound');


%part 4

cirMethod = makeresampler({'cubic','nearest'},'circular');
symMethod = makeresampler({'cubic','nearest'},'symmetric');

cirOrigImg = imtransform(origImg,tForm,cirMethod, ...
                'XData',[-49 3500],'YData',[-49 1750], ...
                'FillValues',color);

symOrigImg = imtransform(origImg,tForm,symMethod, ...
                'XData',[-49 3500],'YData',[-49 1750], ...
                'FillValues',color);

figure; imshow(cirOrigImg); title('circular');
figure; imshow(symOrigImg); title('symmetric');

