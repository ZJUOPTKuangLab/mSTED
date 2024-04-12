These matlab codes correspond to manuscript " Multiplexed stimulated emission depletion nanoscopy (mSTED) 
for 5-color live-cell long-term imaging of organelle interactome". Briefly, it is used to convert intensity images 
into color-mapped images based on fluorescence lifetime information, where different colors represent different 
subcellular structures. The code requires at least five inputs, including:
1.	fluorescence decay of each pixel, which should be a four-dimensional array. 
	Obtained by time-correlated single-photon counting (TCSPC).
2.	Intensity image, which should be a stack made up of square images
3.	Instrument response function, which is mainly determined by the pulse width 
	of the laser and is influenced by the detector and TCSPC.
4.	time resolution of fluorescence decay, unit: ns. From TCSPC.
5.	pulse frequency of excitation, unit: Hz. From excitation laser.
If any bugs appear, please contact me at huangyr@zju.edu.cn.
