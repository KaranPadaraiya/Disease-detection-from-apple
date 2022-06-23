apple=imread("OIP.jfif");
apple1=imread("OIP (1).jfif");
apple2=imread("OIP (2).jpg");
apple3=imread("OIP (3).jpg");
apple4=imread("OIP (4).jfif");
apple5=imread("OIP (5).jfif");
apple6=imread("OIP (6).jfif");
apple7=imread("OIP (7).jfif");
apple8=imread("OIP (8).jfif");
apple9=imread("OIP (9).jfif");


%smoothing image============================================

H = fspecial('average',5);
imsmooth=imfilter(apple6,H)

%ih=imhist(ibw);
%T = otsuthresh(ih);
%ib= imbinarize(ibw,T);
%ib=imcomplement(ib)
%ib=imfill(ib,"holes");

% detact apple mask==========================================

apple=imresize(imsmooth,[150 150])
[BW,applemask] = fullapple(apple)
[BW,applemask] = fullapple2(applemask)


figure,imshow(applemask)
applemaskbw=rgb2gray(applemask);
%i2=immultiply(applemask,2);
%figure,imshow(applemask)

%Adjust image pixel value====================================

RGB2 = imadjust(applemask,[.2 .3 0; .6 .7 1],[]);
figure,imshowpair(applemaskbw,RGB2,'montage');

I=edge(applemaskbw,"sobel");

SE = strel('disk',2);
id=imclose(I,SE);

figure,imshow(id)

%pading=padarray(img,[1,1],1,'pre')


%bw = imfill(bw,'holes');
%BW2 = imfill(id,[3 3],5);
%figure,imshow(BW2);

id2=bwareaopen(id,50)
figure,imshow(id2)


i3=imsubtract(id,id2);
figure,imshow(i3)

count=0;

for i=1:150;
    for j=1:150;
        if i3(i,j)==1;
            count= count+1;
        end
    end
end

%close all


if count<50;
    display("Apple is fresh");
else
    display("Apple is diseased");
end







