I = imread('HandWriting.png');
I = rgb2gray(I);
imwrite(I, 'J .jpg');
CS = imadjust(I,stretchlim(I),[]);%Contrast Stretching
imwrite(CS,'CS.jpg');
II = imadjust(CS,[],[],.41);%Increase Intensity

imwrite(II,'II.jpg');
BW = imbinarize(I,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);

imwrite(BW,'BW.jpg');
se = strel('line',11,90);
SC=strel('rectangle',[2 2]);
SH=imclose(BW,SC);
imwrite(SH,'SH.jpg');
SG1=strel('square',3);
SG2=strel('square',7);
A=imdilate(BW,SG1);
A=imerode(A,SG2);
imshow(A);
imwrite(A,'A.jpg');
