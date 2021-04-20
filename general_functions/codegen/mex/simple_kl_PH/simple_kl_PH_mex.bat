@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2018a
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2018a\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=simple_kl_PH_mex
set MEX_NAME=simple_kl_PH_mex
set MEX_EXT=.mexw64
call "C:\PROGRA~1\MATLAB\R2018a\sys\lcc64\lcc64\mex\lcc64opts.bat"
echo # Make settings for simple_kl_PH > simple_kl_PH_mex.mki
echo COMPILER=%COMPILER%>> simple_kl_PH_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> simple_kl_PH_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> simple_kl_PH_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> simple_kl_PH_mex.mki
echo LINKER=%LINKER%>> simple_kl_PH_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> simple_kl_PH_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> simple_kl_PH_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> simple_kl_PH_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> simple_kl_PH_mex.mki
echo OMPFLAGS= >> simple_kl_PH_mex.mki
echo OMPLINKFLAGS= >> simple_kl_PH_mex.mki
echo EMC_COMPILER=lcc64>> simple_kl_PH_mex.mki
echo EMC_CONFIG=optim>> simple_kl_PH_mex.mki
"C:\Program Files\MATLAB\R2018a\bin\win64\gmake" -j 1 -B -f simple_kl_PH_mex.mk
