obj=VideoReader('film_circulatie1.mp4');
nFrames=obj.NumberOfFrames;
vidHeight=obj.Height;
vidWidth=obj.Width;


Nume = ['Img',num2str(i),'.png']
        imwrite(obj, Nume);