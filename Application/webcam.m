 % webcam capture
cam1 = webcam;
preview(cam1);
pause(5);
img = snapshot(cam1);
closePreview(cam1);
imshow(img);
clear('cam1');
clc;
