I = imread('HandWriting.png');
I = rgb2gray(I);
figure;
imshow(I)
pause;

close;
figure;
I = imadjust(I,stretchlim(I),[]);
imshow(I);

pause;
figure;
I = imadjust(I,[],[],.41);
imshow(I);


pause;

BW = imbinarize(I,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);
figure; 
imshowpair(I, BW, 'montage');

pause;

results = ocr(BW);
results.Text
close all; clear;