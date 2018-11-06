clc
clear all;
close all;
I=imread('dataset/test_3.png');
figure;
imshow(I);
impixelinfo;
title('Select start and destination');
m=size(I,1);
[x, y] =getpts;

fprintf('Start: (%i,%i)\n',x(1),m-y(1));
fprintf('Destination:(%0.0i,%0.0i)\n',x(2),m-y(2));
% 
r=3;
c=2;
figure,
subplot(r,c,1);
imshow(I);
title('Original image');
 
J=rgb2gray(I);

subplot(r,c,2);imshow(J);
title('grayscale image');


K=imadjust(J,[0.6 0.9],[]);
%K=histeq(J);
subplot(r,c,3);
imshow(K);
title('After adjusting intensities ');


level = graythresh(K);  
I=imbinarize(K,level);    
subplot(r,c,4);
imshow(I);
title('Binary image after thresholding');


B = medfilt2(I);
subplot(r,c,5);imshow(B);
title('median filtered image');

im = bwareaopen(B,600);
Binary = imfill(im,'holes');
im=imcomplement(im);
subplot(r,c,6);imshow(im);
title('removing connected components(pixel <6)');

% Load a map file and create an occupancy grid.

map = robotics.OccupancyGrid(im,1);


% Create a roadmap with 800 nodes.

prmSimple = robotics.PRM(map,800);
figure, show(prmSimple)

% Calculate a simple path.

startLocation = [x(1) m-y(1)];
endLocation = [x(2) m-y(2)];
path = findpath(prmSimple,startLocation,endLocation);
figure, show(prmSimple);


% BW = bwmorph(im,'remove');
% figure,imshow(BW);
% title('morphological filtering');
% 
% BW1 = edge(BW,'sobel');
% figure,imshow(BW1);
% title('edge detection(sobel)');
% 
% H = vision.AlphaBlender;
% J = im2single(J);
% BW1 = im2single(BW1);
% Y = step(H,J,BW1);
% figure,imshow(Y)
% title('overlay on grayscale image');
% 
% figure,imshow(J);
% hold on;
% contour(BW1,100);
% hold off;


