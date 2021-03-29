option errorabend;
*option merror mlogic mprint symbolgen;
option nonotes nosource nosource2;
*option notes source source2;
*option logic print symbolgen;


/********************************************************************************
	Author: 	Ed deHaan, with Jess Blocker Smith, Xue Li, and unknown other authors
				3/24/21	- Xue Li rechecked assignments based on current classifications.  No changes made.

	Macro: 		ind_ff38
	
	Purpose: 	to assign Fama French industry codes

	Versions:	1.0 - 	date?	  - original version	
				1.1 -   03/24/21  - added classifications for SIC codes 900 (Fishing, Hunting and Trapping), 3990 (Miscellaneous Manufacturing Industries), and 6797 (Miscellaneous Investing)

	
	Notes:		38 Industry classification codes obtained from French's website in May. 2012
				http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/data_library.html


--------------------------------------------

Generates Fama-French industry codes based on four-digit SIC codes.  


Outputs the original dataset with appended industry code information:

	'&ind_code' 	= count variable of industry codes from 1 through 38
	'FF_IND'		= text variable with name of the fama-french industry
	'&bin_var.#'	= 38 individual binary variables, one for each industry
	'_&global'		= global macro variable to include call 38 industry dummies

--------------------------------------------


	Required INPUT parameters:
		dset			-	input dataset name
		sic				-	four-digit sic code variable name
		outp			-	output dataset
		bin_var			-	prefix for industry binary variables
		ind_code		-	name of count variable for industry codes 1 through 38
		global			-	name of global macro variable to call all 38 industry dummies
	
	Optional INPUT parameters


	


********************************************************************************/


%let _industry_fe= 	i1 i2 i3 i4 i5 i6 i7 i8 i9
					i10 i11 i12 i13 i14 i15 i16 i17 i18 i19
					i20 i21 i22 i23 i24 i25 i26 i27 i28 i29
					i30 i31 i32 i33 i34 i35 i36 i37 i38;

%macro ind_ff38 (dset, outp, sic, bin_var, ind_code );

********** FF Ind Codes Macro **********;



data &outp;
        set &dset;

        indus2=int(&sic/100);
        indus3=int(&sic/10);


*Agric  1:    Agriculture, forestry, and fishing;
          if &sic ge 0100 and &sic le 0999  then do FF_IND='Agric'; &ind_code= 1; end;
*Mines  2:    Mining;
          if &sic ge 1000 and &sic le 1299  then do FF_IND='Mines'; &ind_code= 2; end;
*Oil    3:    Oil and Gas Extraction;
          if &sic ge 1300 and &sic le 1399  then do FF_IND='Oil'; &ind_code= 3; end;
*Stone  4:    Nonmetalic Minerals Except Fuels;
          if &sic ge 1400 and &sic le 1499  then do FF_IND='Stone'; &ind_code= 4; end;
*Cnstr  5:    Construction;
          if &sic ge 1500 and &sic le 1799  then do FF_IND='Cnstr'; &ind_code= 5; end;
*Food   6:    Food and Kindred Products;
          if &sic ge 2000 and &sic le 2099  then do FF_IND='Food'; &ind_code= 6; end;
*Smoke  7:    Tobacco Products;
          if &sic ge 2100 and &sic le 2199  then do FF_IND='Smoke'; &ind_code= 7; end;
*Txtls  8:    Textile Mill Products;
          if &sic ge 2200 and &sic le 2299  then do FF_IND='Txtls'; &ind_code= 8; end;
*Apprl  9:    Apparel and other Textile Products;
          if &sic ge 2300 and &sic le 2399  then do FF_IND='Apprl'; &ind_code= 9; end;
*Wood  10:    Lumber and Wood Products;
          if &sic ge 2400 and &sic le 2499  then do FF_IND='Wood'; &ind_code=10; end;
*Chair 11:    Furniture and Fixtures;
          if &sic ge 2500 and &sic le 2599  then do FF_IND='Chair'; &ind_code=11; end;
*Paper 12:    Paper and Allied Products;
          if &sic ge 2600 and &sic le 2661  then do FF_IND='Paper'; &ind_code=12; end;
*Print 13:    Printing and Publishing;
          if &sic ge 2700 and &sic le 2799  then do FF_IND='Print'; &ind_code=13; end;
*Chems 14:    Chemicals and Allied Products;
          if &sic ge 2800 and &sic le 2899  then do FF_IND='Chems'; &ind_code=14; end;
*Ptrlm 15:    Petroleum and Coal Products;
          if &sic ge 2900 and &sic le 2999  then do FF_IND='Ptrlm'; &ind_code=15; end;
*Rubbr 16:    Rubber and Miscellaneous Plastics Products;
          if &sic ge 3000 and &sic le 3099  then do FF_IND='Rubbr'; &ind_code=16; end;
*Lethr 17:    Leather and Leather Products;
          if &sic ge 3100 and &sic le 3199  then do FF_IND='Lethr'; &ind_code=17; end;
*Glass 18:    Stone, Clay and Glass Products;
          if &sic ge 3200 and &sic le 3299  then do FF_IND='Glass'; &ind_code=18; end;
*Metal 19:    Primary Metal Industries;
          if &sic ge 3300 and &sic le 3399  then do FF_IND='Metal'; &ind_code=19; end;
*MtlPr 20:    Fabricated Metal Products;
          if &sic ge 3400 and &sic le 3499  then do FF_IND='MtlPr'; &ind_code=20; end;
*Machn 21:    Machinery, Except Electrical;
          if &sic ge 3500 and &sic le 3599  then do FF_IND='Machn'; &ind_code=21; end;
*Elctr 22:    Electrical and Electronic Equipment;
          if &sic ge 3600 and &sic le 3699  then do FF_IND='Elctr'; &ind_code=22; end;
*Cars  23:    Transportation Equipment;
          if &sic ge 3700 and &sic le 3799  then do FF_IND='Cars'; &ind_code=23; end;
*Instr 24:    Instruments and Related Products;
          if &sic ge 3800 and &sic le 3879  then do FF_IND='Instr'; &ind_code=24; end;
*Manuf 25:    Miscellaneous Manufacturing Industries;
          if &sic ge 3900 and &sic le 3999  then do FF_IND='Manuf'; &ind_code=25; end;
*Trans 26:    Transportation;
          if &sic ge 4000 and &sic le 4799  then do FF_IND='Trans'; &ind_code=26; end;
*Phone 27:    Telephone and Telegraph Communication;
          if &sic ge 4800 and &sic le 4829  then do FF_IND='Phone'; &ind_code=27; end;
*TV    28:    Radio and Television Broadcasting;
          if &sic ge 4830 and &sic le 4899  then do FF_IND='TV'; &ind_code=28; end;
*Utils 29:    Electric, Gas, and Water Supply;
          if &sic ge 4900 and &sic le 4949  then do FF_IND='Utils'; &ind_code=29; end;
*Garbg 30:    Sanitary Services;
          if &sic ge 4950 and &sic le 4959  then do FF_IND='Garbg'; &ind_code=30; end;
*Steam 31:    Steam Supply;
          if &sic ge 4960 and &sic le 4969  then do FF_IND='Steam'; &ind_code=31; end;
*Water 32:    Irrigation Systems;
          if &sic ge 4970 and &sic le 4979  then do FF_IND='Water'; &ind_code=32; end;
*Whlsl 33:    Wholesale;
          if &sic ge 5000 and &sic le 5199  then do FF_IND='Whlsl'; &ind_code=33; end;
*Rtail 34:    Retail Stores;
          if &sic ge 5200 and &sic le 5999  then do FF_IND='Rtail'; &ind_code=34; end;
*Money 35:    Finance, Insurance, and Real Estate;
          if &sic ge 6000 and &sic le 6999  then do FF_IND='Money'; &ind_code=35; end;
*Srvc  36:    Services;
          if &sic ge 7000 and &sic le 8999  then do FF_IND='Srvc'; &ind_code=36; end;
*Govt  37:    Public Administration;
          if &sic ge 9000 and &sic le 9999  then do FF_IND='Govt'; &ind_code=37; end;

*Other 38:    Almost Nothing;
          if not missing(&sic) and missing(&ind_code) then do FF_IND='Other'; &ind_code= 38; end;


        



	if(&ind_code=1) then &bin_var.1=1;		else &bin_var.1=0;
	if(&ind_code=2) then &bin_var.2=1;		else &bin_var.2=0;
	if(&ind_code=3) then &bin_var.3=1;		else &bin_var.3=0;
	if(&ind_code=4) then &bin_var.4=1;		else &bin_var.4=0;
	if(&ind_code=5) then &bin_var.5=1;		else &bin_var.5=0;
	if(&ind_code=6) then &bin_var.6=1;		else &bin_var.6=0;
	if(&ind_code=7) then &bin_var.7=1;		else &bin_var.7=0;
	if(&ind_code=8) then &bin_var.8=1;		else &bin_var.8=0;
	if(&ind_code=9) then &bin_var.9=1;		else &bin_var.9=0;
	if(&ind_code=10) then &bin_var.10=1;		else &bin_var.10=0;
	if(&ind_code=11) then &bin_var.11=1;		else &bin_var.11=0;
	if(&ind_code=12) then &bin_var.12=1;		else &bin_var.12=0;
	if(&ind_code=13) then &bin_var.13=1;		else &bin_var.13=0;
	if(&ind_code=14) then &bin_var.14=1;		else &bin_var.14=0;
	if(&ind_code=15) then &bin_var.15=1;		else &bin_var.15=0;
	if(&ind_code=16) then &bin_var.16=1;		else &bin_var.16=0;
	if(&ind_code=17) then &bin_var.17=1;		else &bin_var.17=0;
	if(&ind_code=18) then &bin_var.18=1;		else &bin_var.18=0;
	if(&ind_code=19) then &bin_var.19=1;		else &bin_var.19=0;
	if(&ind_code=20) then &bin_var.20=1;		else &bin_var.20=0;
	if(&ind_code=21) then &bin_var.21=1;		else &bin_var.21=0;
	if(&ind_code=22) then &bin_var.22=1;		else &bin_var.22=0;
	if(&ind_code=23) then &bin_var.23=1;		else &bin_var.23=0;
	if(&ind_code=24) then &bin_var.24=1;		else &bin_var.24=0;
	if(&ind_code=25) then &bin_var.25=1;		else &bin_var.25=0;
	if(&ind_code=26) then &bin_var.26=1;		else &bin_var.26=0;
	if(&ind_code=27) then &bin_var.27=1;		else &bin_var.27=0;
	if(&ind_code=28) then &bin_var.28=1;		else &bin_var.28=0;
	if(&ind_code=29) then &bin_var.29=1;		else &bin_var.29=0;
	if(&ind_code=30) then &bin_var.30=1;		else &bin_var.30=0;
	if(&ind_code=31) then &bin_var.31=1;		else &bin_var.31=0;
	if(&ind_code=32) then &bin_var.32=1;		else &bin_var.32=0;
	if(&ind_code=33) then &bin_var.33=1;		else &bin_var.33=0;
	if(&ind_code=34) then &bin_var.34=1;		else &bin_var.34=0;
	if(&ind_code=35) then &bin_var.35=1;		else &bin_var.35=0;
	if(&ind_code=36) then &bin_var.36=1;		else &bin_var.36=0;
	if(&ind_code=37) then &bin_var.37=1;		else &bin_var.37=0;
	if(&ind_code=38) then &bin_var.38=1;		else &bin_var.38=0;
	
run;	


%mend;

