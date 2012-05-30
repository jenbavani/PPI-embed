% Add the user's current working directory and all subfolders to the path

addpath(pwd)

allfiles = dir
folders = allfiles([allfiles.isdir])

for i = 1:size(folders,1)
    f = folders(i)
    fname = f.name
    if fname(1) ~= '.'
        fpath = [pwd filesep fname]
        addpath(fpath)
end