dir = "/home/lpe/Desktop/files_to_transfer/Abel_Tim/single_frame_dir/";

////setBatchMode(true);
//// Just for testing:
aniso = 1;
thr = 0.01;
suppReg = 3;
sig = 1.2;
inRat = 0.1;
maxErr = 0.6008;
intensThr = 100;
//////// Define grid search parameters: //////////
// start, end, step (inclusive)
///////////////////////////////////////////////////

// Location of file with all the run times that will be saved:



// Find all files in subdirs:
function walkFiles(dir) {
	list = getFileList(dir);
 
	for (i=0; i<list.length; i++) {

		if (endsWith(list[i], "/"))
		    walkFiles(""+dir+list[i]);


		// If image file
		else  if (endsWith(list[i], ".tif"))
		   gridProcessImage(dir, list[i]);
		   print(list[i]);
		   selectWindow(results);
           close();
	}
}


function gridProcessImage(dirPath, imName) {
	




	open("" + dirPath + imName);
	
	//// Just for testing:

	
	//for (sig=sig_range[0]; sig<=sig_range[1]; sig=sig+sig_range[2]) {
		//for (thr=thr_range_xstep[0]; thr<=thr_range_xstep[1]; thr=thr*thr_range_xstep[2]) {
			//for (suppReg=suppReg_range[0]; suppReg<=suppReg_range[1]; suppReg=suppReg+suppReg_range[2]) {


	results_csv_path = dirPath + "RadialSymmetry_results_" + imName + "_aniso" + aniso + 
	"sig" + sig +
	"thr" + thr + 
	"suppReg" + suppReg + 
	"inRat" + inRat +
	"maxErr" + maxErr + 
	"intensThr" + intensThr + 
	".txt";
	
	RSparams = "image=" + imName + 
	" mode=Advanced" +
	" anisotropy=" + aniso + 
	" use_anisotropy" +
	" robust_fitting=RANSAC" +
	" sigma=" + sig + 
	" threshold=" + thr + 
	" support=" + suppReg + 
	" min_inlier_ratio=" + inRat +  
	" max_error=" + maxErr +
	" spot_intensity_threshold=" + intensThr +
	" background=[No background subtraction]" +
	" results_file=[" + results_csv_path + "]";
	print(results_csv_path);
	run("Radial Symmetry", RSparams);
	// Close all windows:
	run("Close All");	
	while (nImages>0) { 
		selectImage(nImages); 
		close(); 
    }
 
} 
walkFiles(dir);
