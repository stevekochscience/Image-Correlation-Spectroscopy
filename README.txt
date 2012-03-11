December 9, 2011: Steve Koch: I downloaded this set of software from the Wiseman group website (http://wiseman-group.mcgill.ca/dkolin/ICSMATLAB%2028-02-06.zip) today.  With Dr. Wiseman's permission, I am hoping to have a student get this code working and to upload the project to github as open source.  According to Wiseman, as expected this code is out of date.  However, could be better than nothing and helpful as open source.

Link to my notebook: https://docs.google.com/open?id=0BxLNnjMk2r_qNTE4M2MzY2YtNGU4ZC00NmM3LWI1NjgtMDllMzQ1YjNiMjBl

Below here is the original README file:
ICS Analysis v1.0
February 26, 2006
-----------------

Copyright
---------
Copyright 2003-2006, Wiseman Research Group, McGill University.


System Requirements
-------------------

* MATLAB 7, with Image Processing and Optimization Toolboxes.  Earlier versions may work as well, but have not been tested.

* There are no hardware requirements, per se.  Processor speed will play a large role in the analysis time, and the amount of system RAM will dictate the maximum size of the image series which can be analyzed.  A 1.5 GHz machine with 512 MB RAM should be sufficient for most data sets.

* These .m files should be platform independent, but have only been tested on a Windows XP machine.


Installation Instructions
-------------------------

Just unzip the .m files, and ensure they're in your MATLAB path. (From in MATLAB: File --> Set Path... --> Add with Subfolders...).


Tutorial
--------

A brief tutorial is included in /ICSMATLAB/tutorial/ICSTutorial.html.


File Formats
------------

Only 8-bit RAW and 16-bit Fluoview TIFF files can be imported in this release.  Support for additional formats may be added in a future release.


Disclaimer
----------

This software is provided as is, without any warranty whatsoever.


Contact Info
------------

Please send bug reports and suggestions to david.kolin@gmail.com.


File List
---------

%% Files for importing data %%

rd_img16.m % reads Fluoview tiff image series from Olympus microscopes
FluoInfo.m % gets acquisition parameters from a Fluoview file
reverse.m % needed by FluoInfo
serimcrop.m % interactively crops an image series
rd_imgser.m % reads 8-bit .raw files
wnCorr.m % interactively removes mean value of background counts from an image series

%% Files for ICS %%

corrfunc.m % calculates 2D spatial autocorrelation function (SACF)
gaussfit.m % fits 2D SACF with 2D Gaussian
gauss2d.m % used by gaussfit.m
gauss2dwxy.m % used by gaussfit.m
autocrop.m % used by gaussfit.m
initialguess.m % used by gaussfit.m
plotgaussfit.m % plots the 2D SACF superimposed with the fitted gaussian

%% Files for TICS %%

ticsNOAVG.m % calculates the temporal autocorrelation function (TACF)
difffit.m % fits TACF to 2D diffusion model
diffusion.m % used by difffit.m
flowfit.m % fits TACF to 2D flow model
flow.m % used by flowfit.m
diffflowfit.m % fits TACF to 2D diffusion/flow model
diffusionflow.m % used by diffflowfit.m
difffit3d.m % fits TACF to 3D diffusion model
diffusion3d.m % used by difffit3d.m

%% Files for STICS %%

tics.m % calculates full space time autocorrelation function (STACF)
immfilter.m % filters immobile population from image series
velocity.m % calculates velocity from STACF
gaussfit.m % used by velocity.m
gauss2d.m % used by gaussfit.m
initialguess.m % used by gaussfit.m

%% Files for simulation program %%

simul8tr.m % main simulation program
simul8trMovement.m % used by simul8tr.m
addBackgroundNoise.m % used by simul8tr.m
addCountingNoise.m % used by simul8tr.m
convolveGaussian.m % used by simul8tr.m
createImage.m % used by simul8tr.m
convolveAiry.m % used by simul8tr.m
airy2.m % used by convolveAiry.m
formatSeriesLikeMicroscope.m % used by simul8tr.m
QDBlink.m % used by simul8tr.m


Version History
---------------

v1.0
February 26, 2006

* Spatial ICS
* Temporal ICS
* Spatio-temporal ICS