
option errorabend;
*option merror mlogic mprint symbolgen;
option nonotes nosource nosource2;
*option notes source source2;

/********************************************************************************
	Author: 	Ed deHaan		staff.washington.edu/edehaan
				Xue Li checked for updates on 3/24/2021				

	Macro: 		ind_ff12
	
	Purpose: 	to assign Fama 12 French industry codes

	Versions:	1.0 - 	2/5/11
				1.1 - 	2/17/11 - fixed a few typos in description, etc.
						3/24/21	- rechecked assignments based on current classifications.  No changes made.
	
	Notes:		12 Industry classification codes obtained from French's website in Nov. 2010
				http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/data_library.html


--------------------------------------------

Generates Fama-French industry codes based on four-digit SIC codes.  


Outputs the original dataset with appended industry code information:

	'&ind_code' 	= count variable of industry codes from 1 through 12
	'FF_IND'		= text variable with name of the fama-french industry
	'&bin_var.#'	= 12 individual binary variables, one for each industry
	'_&global'		= global macro variable to include call 12 industry dummies

--------------------------------------------


	Required INPUT parameters:
		dset			-	input dataset name
		sic				-	four-digit sic code variable name
		outp			-	output dataset
		bin_var			-	prefix for industry binary variables
		ind_code		-	name of count variable for industry codes 1 through 12
		global			-	name of global macro variable to call all 12 industry dummies
	
	Optional INPUT parameters
;

	


********************************************************************************/


%let _industry_fe= 	i1 i2 i3 i4 i5 i6 i7 i8 i9 i10 i11 i12 ;

%macro ind_ff12 (dset, outp, sic, bin_var, ind_code );

********** FF Ind Codes Macro **********;



data &outp;
        set &dset;

        indus2=int(&sic/100);
        indus3=int(&sic/10);

*1 NoDur  Consumer NonDurables -- Food, Tobacco, Textiles, Apparel, Leather, Toys;
         if &sic ge   0100 and &sic le  0999 	then &ind_code=1;
         if &sic ge   2000 and &sic le 	2399 	then &ind_code=1;
         if &sic ge   2700 and &sic le 	2749 	then &ind_code=1;
         if &sic ge   2770 and &sic le 	2799 	then &ind_code=1;
         if &sic ge   3100 and &sic le 	3199 	then &ind_code=1;
         if &sic ge   3940 and &sic le 	3989 	then &ind_code=1;

 *2 Durbl  Consumer Durables -- Cars, TVs, Furniture, Household Appliances;
        if &sic ge   2500 and &sic le   2519 	then &ind_code=2;
        if &sic ge   2590 and &sic le 	2599 	then &ind_code=2;
        if &sic ge   3630 and &sic le 	3659 	then &ind_code=2;
        if &sic ge   3710 and &sic le 	3711 	then &ind_code=2;
        if &sic ge   3714 and &sic le 	3714 	then &ind_code=2;
        if &sic ge   3716 and &sic le 	3716 	then &ind_code=2;
        if &sic ge   3750 and &sic le 	3751 	then &ind_code=2;
        if &sic ge   3792 and &sic le 	3792 	then &ind_code=2;
        if &sic ge   3900 and &sic le 	3939 	then &ind_code=2;
        if &sic ge   3990 and &sic le 	3999 	then &ind_code=2;

* 3 Manuf  Manufacturing -- Machinery, Trucks, Planes, Off Furn, Paper, Com Printing;
        if &sic ge    2520 and &sic le  2589 	then &ind_code=3;
        if &sic ge    2600 and &sic le 	2699 	then &ind_code=3;
        if &sic ge    2750 and &sic le 	2769 	then &ind_code=3;
        if &sic ge    3000 and &sic le 	3099 	then &ind_code=3;
        if &sic ge    3200 and &sic le 	3569 	then &ind_code=3;
        if &sic ge    3580 and &sic le 	3629 	then &ind_code=3;
        if &sic ge    3700 and &sic le 	3709 	then &ind_code=3;
        if &sic ge    3712 and &sic le 	3713 	then &ind_code=3;
        if &sic ge    3715 and &sic le 	3715 	then &ind_code=3;
        if &sic ge    3717 and &sic le 	3749 	then &ind_code=3;
        if &sic ge    3752 and &sic le 	3791 	then &ind_code=3;
        if &sic ge    3793 and &sic le 	3799 	then &ind_code=3;
        if &sic ge    3830 and &sic le 	3839 	then &ind_code=3;
        if &sic ge    3860 and &sic le 	3899 	then &ind_code=3;

* 4 Enrgy  Oil, Gas, and Coal Extraction and Products;
        if &sic ge     1200 and &sic le 	1399 	then &ind_code=4;
        if &sic ge     2900 and &sic le 	2999 	then &ind_code=4;

* 5 Chems  Chemicals and Allied Products;
        if &sic ge     2800 and &sic le 	2829 	then &ind_code=5;
        if &sic ge     2840 and &sic le 	2899 	then &ind_code=5;

* 6 BusEq  Business Equipment -- Computers, Software, and Electronic Equipment;
        if &sic ge    3570 and &sic le 	3579 	then &ind_code=6;
        if &sic ge    3660 and &sic le 	3692 	then &ind_code=6;
        if &sic ge    3694 and &sic le 	3699 	then &ind_code=6;
        if &sic ge    3810 and &sic le 	3829 	then &ind_code=6;
        if &sic ge    7370 and &sic le 	7379 	then &ind_code=6;

* 7 Telcm  Telephone and Television Transmission;
         if &sic ge    4800 and &sic le 	4899 	then &ind_code=7;

* 8 Utils  Utilities;
         if &sic ge    4900 and &sic le 	4949 	then &ind_code=8;

* 9 Shops  Wholesale, Retail, and Some Services (Laundries, Repair Shops);
        if &sic ge    5000 and &sic le 	5999 	then &ind_code=9;
        if &sic ge    7200 and &sic le 	7299 	then &ind_code=9;
        if &sic ge    7600 and &sic le 	7699 	then &ind_code=9;

*10 Hlth   Healthcare, Medical Equipment, and Drugs;
         if &sic ge   2830 and &sic le 	2839 	then &ind_code=10;
         if &sic ge   3693 and &sic le 	3693 	then &ind_code=10;
         if &sic ge   3840 and &sic le 	3859 	then &ind_code=10;
         if &sic ge   8000 and &sic le 	8099 	then &ind_code=10;

*11 Money  Finance;
         if &sic ge   6000 and &sic le 	6999 	then &ind_code=11;

*12 Other  Other -- Mines, Constr, BldMt, Trans, Hotels, Bus Serv, Entertainment;
		 if &sic > .		and &ind_code = .	then &ind_code=12;


	if(&ind_code=1) then &bin_var.1=1;			else &bin_var.1=0;
	if(&ind_code=2) then &bin_var.2=1;			else &bin_var.2=0;
	if(&ind_code=3) then &bin_var.3=1;			else &bin_var.3=0;
	if(&ind_code=4) then &bin_var.4=1;			else &bin_var.4=0;
	if(&ind_code=5) then &bin_var.5=1;			else &bin_var.5=0;
	if(&ind_code=6) then &bin_var.6=1;			else &bin_var.6=0;
	if(&ind_code=7) then &bin_var.7=1;			else &bin_var.7=0;
	if(&ind_code=8) then &bin_var.8=1;			else &bin_var.8=0;
	if(&ind_code=9) then &bin_var.9=1;			else &bin_var.9=0;
	if(&ind_code=10) then &bin_var.10=1;		else &bin_var.10=0;
	if(&ind_code=11) then &bin_var.11=1;		else &bin_var.11=0;
	if(&ind_code=12) then &bin_var.12=1;		else &bin_var.12=0;

	
run;	


%mend ind_ff12;

option notes source source2;
