@echo off

set nxslt=..\lib\nxslt\nxslt.exe
set xsltproc=..\lib\libxml\bin\xsltproc.exe 
set winmerge="\Program Files (x86)\WinMerge\WinMergeU.exe" 

set project=AmplaProject.xml
set authstore=AuthStore.xml

set production=..\Production\
set development=..\Development\

call .\Scripts\CleanDir.cmd ..\Working
call .\Scripts\CleanDir.cmd ..\Working\Development
call .\Scripts\CleanDir.cmd ..\Working\Production
call .\Scripts\CleanDir.cmd ..\Output
call .\Scripts\CleanDir.cmd ..\Output\Development
call .\Scripts\CleanDir.cmd ..\Output\Production

set directory=%development%
set type=Development

@echo === Development ===
echo - Normalise Project
%nxslt% %directory%%project% StyleSheets\Project.Normalize.xslt -o ..\Working\%type%\project.xml 
echo - Output Files
%xsltproc% -o ..\Output\%type%\output.files.xml StyleSheets\Output.Project.Files.xslt ..\Working\%type%\project.xml 

set directory=%production%
set type=Production

@echo === Production ===
echo - Normalise Project
%nxslt% %directory%%project% StyleSheets\Project.Normalize.xslt -o ..\Working\%type%\project.xml 
echo - Output Files
%xsltproc% -o ..\Output\%type%\output.files.xml StyleSheets\Output.Project.Files.xslt ..\Working\%type%\project.xml 

%winmerge% ..\Output\Development ..\Output\Production /r


