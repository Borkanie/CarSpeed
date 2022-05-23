rgb=imread('TEST2.bmp');

imshow(rgb)
showShape('line',[440 800 760 700],'Color','green')
% P1=[450;875];
% P2=[395;885];
% P3=[505;865];
figure
value=[542];
caption = sprintf('Area = %f', value);
text(10, 10, caption, 'FontSize', 30);