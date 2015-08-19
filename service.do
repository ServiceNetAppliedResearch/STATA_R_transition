*Monthly Knowledge Network Report*
*last updated 8/17/2015

cd "C:\Users\jgeertsma\Documents\servicenet\knowledge network\"

set mem 500m

*KN sessions
*run https://servicenet.ehana.com/Report/Chart/2147558/ for outpatient only
*save sheet0 as "C:\Users\jgeertsma\Documents\servicenet\data drop\frequency\pnotes 7_2015.csv" (or appropriate month/year)
*save sheet2 as "C:\Users\jgeertsma\Documents\servicenet\data drop\frequency\mnotes 7_2015.csv" (or appropriate month/year)
*run https://servicenet.ehana.com/Report/Chart/2149633/ 
*save table0 as "C:\Users\jgeertsma\Documents\servicenet\knowledge network\intake7_2015.csv" (or appropriate month/year)
*format dates as custom-->m/d/yyyy h:mm
*edit dates below to reflect current month of data

insheet using "C:\Users\jgeertsma\Documents\servicenet\data drop\frequency\pnotes 7_2015.csv", clear
sort clientid
gen service=1
save pnotes, replace
insheet using "C:\Users\jgeertsma\Documents\servicenet\data drop\frequency\mnotes 7_2015.csv", clear
sort clientid
gen service=2
save mnotes, replace
insheet using "C:\Users\jgeertsma\Documents\servicenet\knowledge network\intake7_2015.csv", clear
sort clientid
keep  clientid employee intakeassessmentdate primaryprogram
rename employee clinician
rename intakeassessmentdate sessionstart
rename primaryprogram programcode
sort clientid
gen service=3
*edit this next line to reflect starting number for intakes; use 3855 for 7/2015
gen calendareventid=_n+3661
save intakes, replace

use pnotes, clear
append using mnotes
append using intakes
keep clientid clinician sessionstart sessionend calendareventid noteid programcode servicecode service


gen Org_ID=19
rename  calendareventid Service_ID
rename clientid Client_ID
drop if Client_ID==3385

gen double Begin_Time = clock( sessionstart, "MDY hm")
format Begin_Time %tc
gen double End_Time = clock(sessionend, "MDY hm")
format End_Time %tc
gen double Service_Date=dofc(Begin_Time)
format Service_Date %td
*edit date to reflect current month if necessary
*keep if  Service_Date>19935 & Service_Date<19967

gen LOC_ID = .
replace LOC_ID=1 if programcode=="5901 Amherst Outpatient Clinic" | programcode=="5949 Amherst Medication Clinic" | programcode=="5901 Amherst Outpatient Clinic"
replace LOC_ID=2 if programcode=="4149 Greenfield Outpatient Clinic" | programcode=="4155 Greenfield Medication Clinic" | programcode=="4149 Greenfield Outpatient Clinic"
replace LOC_ID=3 if programcode=="5193 Holyoke Outpatient Clinic" | programcode=="5196 Holyoke Medication Clinic" | programcode=="5193 Holyoke Outpatient Clinic" | programcode=="5193 Non-DMR Holyoke" | programcode=="5149 Holyoke Outpatient - DMR" | programcode=="5149 DMR Holyoke"
replace LOC_ID=4 if programcode=="4109 Northampton Outpatient Clinic" | programcode=="5139 Northampton Medication Clinic" | programcode=="4105 DBT Program" | programcode=="4109 Northampton Outpatient Clinic" | programcode=="5129 Hampshire/Franklin DMR"
replace LOC_ID=5 if programcode=="5700 Pittsfield Outpatient Clinic" | programcode=="5700 Pittsfield Outpatient Clinic" | programcode=="5700 Pittsfield Outpatient Clinic" | programcode=="5749 Pittsfield Med Clinic"
drop if programcode=="4410 Pathways - Greenfield" | programcode=="4219 Pathways - Northampton" | programcode=="4610 Athol Outpatient" | programcode=="5640 Childrens Study Home" | programcode=="8801 Sheltering Stabilization" | programcode=="8821 Sheltering: HPP" | programcode=="4410 Pathways - Greenfield" | programcode=="4510 In Home Therapy/Therapeutic Mentor" | programcode=="8821 Sheltering: HPP" | programcode=="4510 In Home Therapy/Therapeutic Mentoring" | programcode=="5810 FCHOC" | programcode=="8826 Sheltering: REACH" | programcode=="6315 HCHOC" | programcode=="5143 DDTF" | programcode=="5610 NCYF" | programcode=="8109 Athol/Orange Family Inn Outreach" | programcode=="7104 Autism Over 3"
drop programcode

gen Enlighten_Activity_Class=.
replace Enlighten_Activity_Class=1 if servicecode=="89 - Translation"
replace Enlighten_Activity_Class=2 if servicecode=="30 - C - Case Consultation Child Enhanced Masshealth only.Face to Face or phone with another prov."
replace Enlighten_Activity_Class=2 if servicecode=="30 - Case Consultation. Masshealth only.Face to Face or phone with another prov."
replace Enlighten_Activity_Class=2 if servicecode=="30 - DDS - Case Consultation. Masshealth only.Face to Face or phone with another prov."
replace Enlighten_Activity_Class=2 if servicecode=="60 - C - Family Consultation (Mass Health only Face to Face or phone with family member) Child Enhanced"
replace Enlighten_Activity_Class=2 if servicecode=="60 - DDS - Family Consultation (MassHealth only) Face to Face or phone with family member"
replace Enlighten_Activity_Class=2 if servicecode=="60 - Family Consultation (MassHealth only) Face to Face or phone with family member"
replace Enlighten_Activity_Class=2 if servicecode=="62 - Collateral Contact (MassHealth Only - 20 years and younger) Phone cnvrstn with another provider."
replace Enlighten_Activity_Class=2 if servicecode=="84 - DMR Collateral"
replace Enlighten_Activity_Class=2 if servicecode=="800 - Amherst School-Case Management"
replace Enlighten_Activity_Class=2 if servicecode=="801 - Amherst School-Case Consultation"
replace Enlighten_Activity_Class=2 if servicecode=="804 - Amherst School - Case Consultation-Family Therapy"
replace Enlighten_Activity_Class=2 if servicecode=="805 - Amherst School - Case Consultation-Individual Therapy"
replace Enlighten_Activity_Class=2 if servicecode=="807 - Amherst School - Case Consultation-Monthly School Mtg"
replace Enlighten_Activity_Class=4 if servicecode=="23 - Intelligence/Personality Testing"
replace Enlighten_Activity_Class=4 if servicecode=="50 - C - Diagnostic Child Enhanced"
replace Enlighten_Activity_Class=4 if servicecode=="50 - Diagnostic"
replace Enlighten_Activity_Class=4 if servicecode=="50 - DDS - Diagnostic"
replace Enlighten_Activity_Class=4 if servicecode=="51 - Doctor Diagnostic"
replace Enlighten_Activity_Class=4 if servicecode=="55 - MassHealth Diagnostic Under 21"
replace Enlighten_Activity_Class=4 if servicecode=="55 - C - MassHealth Diagnostic Under 21"
replace Enlighten_Activity_Class=4 if servicecode=="24 - Intelligence Testing"
replace Enlighten_Activity_Class=4 if servicecode=="25 - Personality Testing"
replace Enlighten_Activity_Class=4 if servicecode=="28 - Neuro/Psych Testing"
replace Enlighten_Activity_Class=5 if servicecode=="19 - C - Family Therapy - Client not present (Masshealth,BCBS,Cigna,Tufts,UBH)No Comm Beacon or HNE" 
replace Enlighten_Activity_Class=5 if servicecode=="19 - Family Therapy - Client not present (Masshealth,BCBS,Cigna,Tufts,UBH)No Comm Beacon or HNE"
replace Enlighten_Activity_Class=5 if servicecode=="20 - C - Family Therapy Child Enhanced"
replace Enlighten_Activity_Class=5 if servicecode=="20 - Family Therapy"
replace Enlighten_Activity_Class=5 if servicecode=="20 - DDS - Family Therapy"
replace Enlighten_Activity_Class=5 if servicecode=="803 - Amherst School-Family Therapy"
replace Enlighten_Activity_Class=6 if servicecode=="42 - Group Therapy"
replace Enlighten_Activity_Class=6 if servicecode=="42 - DDS - Group Therapy"
replace Enlighten_Activity_Class=6 if servicecode=="200 - DBT Group"
replace Enlighten_Activity_Class=6 if servicecode=="300 - DBT Group with MBHP or HNE special PA only"
replace Enlighten_Activity_Class=7 if servicecode=="10 - C - Individual Therapy Child Enhanced - 1 hour"
replace Enlighten_Activity_Class=7 if servicecode=="10 - Individual Therapy - 1 hr"
replace Enlighten_Activity_Class=7 if servicecode=="12 - Special Individual Therapy - 1 hr"
replace Enlighten_Activity_Class=7 if servicecode=="10 - DDS - Individual Therapy - 1 hr"
replace Enlighten_Activity_Class=7 if servicecode=="11 - C - Individual Therapy - 1/2 hr"
replace Enlighten_Activity_Class=7 if servicecode=="11 - Individual Therapy - 1/2 hr"
replace Enlighten_Activity_Class=7 if servicecode=="11 - DDS - Individual Therapy - 1/2 hr"
replace Enlighten_Activity_Class=7 if servicecode=="201 - DBT Individual"
replace Enlighten_Activity_Class=7 if servicecode=="301 - DBT Individual with MBHP or HNE special PA only"
replace Enlighten_Activity_Class=7 if servicecode=="802 - Amherst School-Individual Therapy"
replace Enlighten_Activity_Class=8 if service==3
replace Enlighten_Activity_Class=11 if servicecode=="64 - Medication Visit Standard"
replace Enlighten_Activity_Class=11 if servicecode=="641 - Medication Visit Complex - Adult"
replace Enlighten_Activity_Class=11 if servicecode=="643 - Medication Visit Complex - Child"


gen CPT_Code=""
gen Status=1
gen Net_Revenue=.
gen Staff_ID=999
gen Billed_Flag=1
replace Billed_Flag=0 if servicecode=="01 - Non-Billable (TM)" | servicecode=="901 - Non Billable Client Contact" | servicecode=="905 - FCHOC Non-Billable" | servicecode=="901 - Non Billable Client Contact"
gen Gross_Revenue=.
gen Enlighten_Activity_Class_Other=servicecode if Enlighten_Activity_Class==.
drop servicecode
gen Deleted_Flag=.
gen Activity_ID=.
gen Source_Activity_Class=""
gen Client_Program_ID=.
gen MGMT_Structure_ID=.
gen PROG_ID=.
gen Service_Place=""
gen Service_Status=""
gen Service_Type=""
gen PayorCode_ID=""
gen Unused_Column=.
gen Activity_Type=""
gen Activity_Addon_Flag=.
sort Client_ID
compress
save service_temp, replace

merge Client_ID using "C:\Users\jgeertsma\Documents\servicenet\knowledge network\client7_2015", nokeep keep(Primary_Payor)
drop clinician sessionstart sessionend noteid service _merge
order Org_ID Service_ID Client_ID Service_Date LOC_ID Enlighten_Activity_Class CPT_Code Begin_Time End_Time Status Primary_Payor Net_Revenue Staff_ID Billed_Flag Gross_Revenue Enlighten_Activity_Class_Other Deleted_Flag Activity_ID Source_Activity_Class Client_Program_ID MGMT_Structure_ID PROG_ID Service_Place Service_Status Service_Type PayorCode_ID Unused_Column Activity_Type Activity_Addon_Flag
save service7_2015, replace

tostring  Service_ID Client_ID, replace
outsheet using "C:\Users\jgeertsma\Documents\servicenet\knowledge network\service_Jul2015.csv", comma replace


