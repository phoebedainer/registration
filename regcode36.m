clc;
clear all;
close all;

fixed=imread('/Users/PhoebeDainer/Desktop/ToRegister/22-1-036_cleaned/static_single/C1_staticsingle_1.tif');
moving12=imread('/Users/PhoebeDainer/Desktop/ToRegister/22-1-036_cleaned/static_single/C2_staticsingle_1.tif');
moving13=imread('/Users/PhoebeDainer/Desktop/ToRegister/22-1-036_cleaned/static_single/C3_staticsingle_1.tif');
moving14=imread('/Users/PhoebeDainer/Desktop/ToRegister/22-1-036_cleaned/static_single/C4_staticsingle_1.tif');

%  imshowpair(fixed, moving,'Scaling','joint');
% Rfixed = imref2d(size(fixed));
% Rmoving = imref2d(size(moving));
 [optimizer, metric] = imregconfig('multimodal');
% 
optimizer.InitialRadius = 0.001;
optimizer.Epsilon = 1.5e-10;
optimizer.GrowthFactor = 1.01;
optimizer.MaximumIterations = 2000;

% [moving_reg,R_reg] = imregister(moving,Rmoving,fixed,Rfixed,'rigid',optimizer,metric);
% 
% movingRegistered = imregister(moving, fixed, 'rigid', optimizer, metric);
%
tform_C1C2=imregtform(moving12, fixed, 'rigid', optimizer, metric);
tform_C1C3=imregtform(moving13, fixed, 'rigid', optimizer, metric);
tform_C1C4=imregtform(moving14, fixed, 'rigid', optimizer, metric);

shot_01=imread('/Users/PhoebeDainer/Desktop/ToRegister/22-1-036_cleaned/shots/shot_01.tif');
shot_05=imread('/Users/PhoebeDainer/Desktop/ToRegister/22-1-036_cleaned/shots/shot_05.tif');

shot_02=imread('/Users/PhoebeDainer/Desktop/ToRegister/22-1-036_cleaned/shots/shot_02.tif');
shot_06=imread('/Users/PhoebeDainer/Desktop/ToRegister/22-1-036_cleaned/shots/shot_06.tif');

shot_03=imread('/Users/PhoebeDainer/Desktop/ToRegister/22-1-036_cleaned/shots/shot_03.tif');
shot_07=imread('/Users/PhoebeDainer/Desktop/ToRegister/22-1-036_cleaned/shots/shot_07.tif');

shot_04=imread('/Users/PhoebeDainer/Desktop/ToRegister/22-1-036_cleaned/shots/shot_04.tif');
shot_08=imread('/Users/PhoebeDainer/Desktop/ToRegister/22-1-036_cleaned/shots/shot_08.tif');


% imshow(shot_02)

shot_02_reg=imwarp(shot_02,tform_C1C2);
shot_06_reg=imwarp(shot_06,tform_C1C2);
dim0206 = length(shot_02_reg);

largestlength = dim0206;

shot_03_reg=imwarp(shot_03,tform_C1C3);
shot_07_reg=imwarp(shot_07,tform_C1C3);
dim0307 = length(shot_03_reg);

if(dim0307 > largestlength)
    largestlength = dim0307;
end

shot_04_reg=imwarp(shot_04,tform_C1C4);
shot_08_reg=imwarp(shot_08,tform_C1C4);
dim0408 = length(shot_04_reg);

if(dim0408 > largestlength)
    largestlength = dim0408;
end

dim0105 = length(shot_01);

if(dim0105 > largestlength)
    largestlength = dim0105;
end

change0105 = largestlength - dim0105;
change0206 = largestlength - dim0206;
change0307 = largestlength - dim0307;
change0408 = largestlength - dim0408;

%adding zeros

%change0105
    newCols0105 = zeros(size(shot_01,1), change0105);
    shot_01 = horzcat(newCols0105, shot_01);
    shot_05 = horzcat(newCols0105, shot_05);

    newRows0105 = zeros(change0105,size(shot_01,2)); 
    shot_01 = vertcat(newRows0105, shot_01);
    shot_05 = vertcat(newRows0105, shot_05);
    
%change0206
    newCols0206 = zeros(size(shot_02_reg,1), change0206);
    shot_02_reg = horzcat(newCols0206, shot_02_reg);
    shot_06_reg = horzcat(newCols0206, shot_06_reg);

    newRows0206 = zeros(change0206,size(shot_02_reg,2)); 
    shot_02_reg = vertcat(newRows0206, shot_02_reg);
    shot_06_reg = vertcat(newRows0206, shot_06_reg);

%change0307
newCols0307 = zeros(size(shot_03_reg,1), change0307);
shot_03_reg = horzcat(newCols0307, shot_03_reg);
shot_07_reg = horzcat(newCols0307, shot_07_reg);

newRows0307 = zeros(change0307,size(shot_03_reg,2)); 
shot_03_reg = vertcat(newRows0307, shot_03_reg);
shot_07_reg = vertcat(newRows0307, shot_07_reg);


%change0408
    newCols0408 = zeros(size(shot_04_reg,1), change0408);
    shot_04_reg = horzcat(newCols0408, shot_04_reg);
    shot_08_reg = horzcat(newCols0408, shot_08_reg);

    newRows0408 = zeros(change0408,size(shot_04_reg,2)); 
    shot_04_reg = vertcat(newRows0408, shot_04_reg);
    shot_08_reg = vertcat(newRows0408, shot_08_reg);

% figure; imshow(shot_02_reg)

% % 
% % figure
% % imshowpair(fixed, movingRegistered,'Scaling','joint')
% 
 imwrite(shot_01,'shots_registered_new_36/shot_01_reg.tif');
 imwrite(shot_05,'shots_registered_new_36/shot_05_reg.tif');


 imwrite(shot_02_reg,'shots_registered_new_36/shot_02_reg.tif');
 imwrite(shot_06_reg,'shots_registered_new_36/shot_06_reg.tif');

 imwrite(shot_03_reg,'shots_registered_new_36/shot_03_reg.tif');
 imwrite(shot_07_reg,'shots_registered_new_36/shot_07_reg.tif');

 imwrite(shot_04_reg,'shots_registered_new_36/shot_04_reg.tif');
 imwrite(shot_08_reg,'shots_registered_new_36/shot_08_reg.tif');