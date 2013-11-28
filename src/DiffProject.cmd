rem @echo off

set nxslt=..\lib\nxslt\nxslt.exe
set graphviz=..\lib\GraphViz-2.30.1\bin
set dotml=..\lib\dotml-1.4
set xsltproc=..\lib\libxml\bin\xsltproc.exe 
set winmerge="D:\Program Files (x86)\WinMerge\WinMergeU.exe" 

set project=AmplaProject.xml
set authstore=AuthStore.xml

set production=..\Production\
set development=..\Development\

if EXIST Working goto Working_exists
mkdir Working
:Working_exists

if NOT EXIST Working\Production goto working_production_create
rmdir Working\Production /S /Q

:Working_production_create
mkdir Working\Production

if NOT EXIST Working\Development goto working_development_create
rmdir Working\Development /S /Q

:Working_development_create
mkdir Working\Development

set directory=%production%
set type=Production

@echo === Normalise ===
%nxslt% %directory%%project% StyleSheets\Project.Normalize.xslt -o Working\%type%\project.xml 
%xsltproc% -o Working\%type%\output.files.xml StyleSheets\Output.Project.Files.xslt Working\%type%\project.xml 

set directory=%development%
set type=Development

@echo === Normalise ===
%nxslt% %directory%%project% StyleSheets\Project.Normalize.xslt -o Working\%type%\project.xml 
%xsltproc% -o Working\%type%\output.files.xml StyleSheets\Output.Project.Files.xslt Working\%type%\project.xml 

%winmerge% Working\Development Working\Production /r


