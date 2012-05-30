% Add all folders in the user's current working directory to the path

allfiles = dir
folders = allfiles([allfiles.isdir])

for i = 1:size(folders,1)
    f = folders(i)
    fname = [pwd filesep f.name]
    addpath(fname)
end