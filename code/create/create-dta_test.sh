# create a dataset
datalad create -c hirni DTA_test
cd DTA_test

# installing the necessary code into the dataset
datalad install -d . -s git@github.com:TobiasKadelka/build_dta.git code/build_dta

# modify the rules for the spec, so the dta-rules will be used
git config -f .datalad/config --add datalad.hirni.dicom2spec.rules code/build_dta/code/create/dta_dicom2spec_rules.py

# configuring the .datalad/config, so it knows where to find the procedure for renaming the fieldmaps
git config -f .datalad/config --add datalad.locations.dataset-procedures code/build_dta/code/procedures

# THIS IS NOT NECESSARY, WHEN FILES ARE ALREADY IN TARS ON CLUSTER
# get the source_data for DTA1
# ./code/tmp/tar-DTA1_output.sh
# source_data for DTA2
# ./code/tmp/tar-DTA2_output.sh

# hirni-import-dcm (but with reduced number of input tars)
./code/build_dta/code/routines/hirni-import-dcm_test.sh /data/BnB_TEMP/Kadelka/sourcedata_DTA_reduced/*

# TODO : everything from here

# dicom2spec will be called by hirni-import-dcm anyways.
# ./code/build_dta/code/scripts/run_dicom2spec.sh

# add procedures for correcting names to the studyspec.json
for d in ./T* ; do
	code/build_dta/code/procedures/add-mods-to-specs.py $d/studyspec.json
done

######### don't spec2bids here, but use this as the source for another dataset. (siehe demo von ben)

# hirni-spec2bids
# chmod 775 code/build_dta/code/scripts/run_spec2bids.sh
# ./code/build_dta/code/scripts/run_spec2bids.sh

# drei demo-befehle testen

