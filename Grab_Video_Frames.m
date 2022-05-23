function [Frame_Data,Video_Structure] = Grab_Video_Frames(File_Name)
Video_Properties = VideoReader(File_Name);

Video_Height = Video_Properties.Height;
Video_Width = Video_Properties.Width;
Number_Of_Frames = Video_Properties.NumFrames;

Colour_Channel_Matrix = zeros(Video_Height,Video_Width,3,'uint8');
Video_Structure = struct('cdata',Colour_Channel_Matrix,'colormap',[]);

Frame_Index = 1; 

while(hasFrame(Video_Properties))    
  Video_Structure(Frame_Index).cdata = readFrame(Video_Properties);
  Frame_Index = Frame_Index + 1;    
end

Frame_Data = {Video_Structure.cdata};
end