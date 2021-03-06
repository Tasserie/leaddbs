function iscoreg=ea_seemscoregistered(options)

% function checks if all anatomical images in folder are coregistered or
% not.

iscoreg=1;
directory=[options.root,options.patientname,filesep];

[~,presentfiles]=ea_assignpretra(options);
if exist(ea_niigz([directory,options.prefs.fa2anat]),'file')
    presentfiles=[presentfiles,{options.prefs.fa2anat}];
end

if length(presentfiles)==1 % only one anatomical image present, nothing to coregister
    return
end

if isempty(presentfiles)
    iscoreg=0;
    return
end
Vref=ea_open_vol([directory,presentfiles{1}]);
for comp=2:length(presentfiles)
    Vcomp=ea_open_vol([directory,presentfiles{comp}]);
    if ~isequal(Vref.dim,Vcomp.dim)
        iscoreg=0;
        return
    end
    if ~isequal(Vref.mat,Vcomp.mat)
        iscoreg=0;
        return
    end
end