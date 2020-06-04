

fin = '2020-06-03-downwardfacing.mp4';
fout = 'output.mp4';
fileinfo = aviinfo(fin);
nframes = fileinfo.NumFrames;
aviobj = avifile(fout, 'compression', 'none', 'fps',fileinfo.FramesPerSecond);
for i = 1:nframes