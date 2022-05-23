clc
clear all
close all

File_Name = "trafic_Trim.mp4";
Video_Preopertis = VideoReader(File_Name);

Video_Height = Video_Preopertis.Height;
Video_Width = Video_Preopertis.Width;
Number_Of_Frames = Video_Preopertis.NumFrames;
Colour_Channel_Matrix = zeros(Video_Height,Video_Width,3,'uint8');
Video_Structure = struct('cdata',Colour_Channel_Matrix,'colormap',[]);
 
 Frame_Index = 1;
 while(hasFrame(Video_Preopertis))
      Video_Structure(Frame_Index).data = readFrame(Video_Preopertis);
      Frame_Index = Frame_Index + 1;
 end
 Frame_Data = {Video_Structure.cdata};
 montage(Frame_Data,'ThumbnailSize',[100 Inf]);
 
 