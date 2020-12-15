select
  s.dogId,
	s.userId,
	s.survey5YearsId [5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
  --Q0.5 In your '4 year old' survey, you told us that "Toby" was a…
  /*---Police/military working dog---*/
  pvtwdcs1.[1] [Q0.5 (Police/military working dog): Still working],
  pvtwdcs1.[2] [Q0.5 (Police/military working dog): Temporarily not working (for example, due to injury)],
  pvtwdcs1.[3] [Q0.5 (Police/military working dog): Retired as work was no longer available for him/her],
  pvtwdcs1.[4] [Q0.5 (Police/military working dog): Retired (reached normal retirement age)],
  pvtwdcs1.[5] [Q0.5 (Police/military working dog): Retired (due to health reasons)],
  pvtwdcs1.[6] [Q0.5 (Police/military working dog): Retired (due to behaviour reasons)],
  pvtwdcs1.[7] [Q0.5 (Police/military working dog): Retired (due to a change in owner's circumstances],
  pvtwdcs1.[8] [Q0.5 (Police/military working dog): Retired (other reasons) ID],
  wdcs1_ft.whyDogIsNotWorkingDetail [Q0.5 (Police/military working dog): Retired (other reasons) Desc],
  /*---Gun dog---*/
  pvtwdcs2.[1] [Q0.5 (Gun dog): Still working],
  pvtwdcs2.[2] [Q0.5 (Gun dog): Temporarily not working (for example, due to injury)],
  pvtwdcs2.[3] [Q0.5 (Gun dog): Retired as work was no longer available for him/her],
  pvtwdcs2.[4] [Q0.5 (Gun dog): Retired (reached normal retirement age)],
  pvtwdcs2.[5] [Q0.5 (Gun dog): Retired (due to health reasons)],
  pvtwdcs2.[6] [Q0.5 (Gun dog): Retired (due to behaviour reasons)],
  pvtwdcs2.[7] [Q0.5 (Gun dog): Retired (due to a change in owner's circumstances],
  pvtwdcs2.[8] [Q0.5 (Gun dog): Retired (other reasons) ID],
  wdcs2_ft.whyDogIsNotWorkingDetail [Q0.5 (Gun dog): Retired (other reasons) Desc],
  /*---Cattle dog---*/
  pvtwdcs3.[1] [Q0.5 (Cattle dog): Still working],
  pvtwdcs3.[2] [Q0.5 (Cattle dog): Temporarily not working (for example, due to injury)],
  pvtwdcs3.[3] [Q0.5 (Cattle dog): Retired as work was no longer available for him/her],
  pvtwdcs3.[4] [Q0.5 (Cattle dog): Retired (reached normal retirement age)],
  pvtwdcs3.[5] [Q0.5 (Cattle dog): Retired (due to health reasons)],
  pvtwdcs3.[6] [Q0.5 (Cattle dog): Retired (due to behaviour reasons)],
  pvtwdcs3.[7] [Q0.5 (Cattle dog): Retired (due to a change in owner's circumstances],
  pvtwdcs3.[8] [Q0.5 (Cattle dog): Retired (other reasons) ID],
  wdcs3_ft.whyDogIsNotWorkingDetail [Q0.5 (Cattle dog): Retired (other reasons) Desc],
  /*---Sheep dog---*/
  pvtwdcs4.[1] [Q0.5 (Sheep dog): Still working],
  pvtwdcs4.[2] [Q0.5 (Sheep dog): Temporarily not working (for example, due to injury)],
  pvtwdcs4.[3] [Q0.5 (Sheep dog): Retired as work was no longer available for him/her],
  pvtwdcs4.[4] [Q0.5 (Sheep dog): Retired (reached normal retirement age)],
  pvtwdcs4.[5] [Q0.5 (Sheep dog): Retired (due to health reasons)],
  pvtwdcs4.[6] [Q0.5 (Sheep dog): Retired (due to behaviour reasons)],
  pvtwdcs4.[7] [Q0.5 (Sheep dog): Retired (due to a change in owner's circumstances],
  pvtwdcs4.[8] [Q0.5 (Sheep dog): Retired (other reasons) ID],
  wdcs4_ft.whyDogIsNotWorkingDetail [Q0.5 (Sheep dog): Retired (other reasons) Desc],
  /*---Guide dog (with the 'Guide Dogs for the Blind' Association)---*/
  pvtwdcs5.[1] [Q0.5 (Guide dog (with the 'Guide Dogs for the Blind' Association)): Still working],
  pvtwdcs5.[2] [Q0.5 (Guide dog (with the 'Guide Dogs for the Blind' Association)): Temporarily not working (for example, due to injury)],
  pvtwdcs5.[3] [Q0.5 (Guide dog (with the 'Guide Dogs for the Blind' Association)): Retired as work was no longer available for him/her],
  pvtwdcs5.[4] [Q0.5 (Guide dog (with the 'Guide Dogs for the Blind' Association)): Retired (reached normal retirement age)],
  pvtwdcs5.[5] [Q0.5 (Guide dog (with the 'Guide Dogs for the Blind' Association)): Retired (due to health reasons)],
  pvtwdcs5.[6] [Q0.5 (Guide dog (with the 'Guide Dogs for the Blind' Association)): Retired (due to behaviour reasons)],
  pvtwdcs5.[7] [Q0.5 (Guide dog (with the 'Guide Dogs for the Blind' Association)): Retired (due to a change in owner's circumstances],
  pvtwdcs5.[8] [Q0.5 (Guide dog (with the 'Guide Dogs for the Blind' Association)): Retired (other reasons) ID],
  wdcs5_ft.whyDogIsNotWorkingDetail [Q0.5 (Guide dog (with the 'Guide Dogs for the Blind' Association)): Retired (other reasons) Desc],
  /*---Hearing dog (with the 'Hearing Dogs for Deaf People' Association)---*/
  pvtwdcs6.[1] [Q0.5 (Hearing dog (with the 'Hearing Dogs for Deaf People' Association)): Still working],
  pvtwdcs6.[2] [Q0.5 (Hearing dog (with the 'Hearing Dogs for Deaf People' Association)): Temporarily not working (for example, due to injury)],
  pvtwdcs6.[3] [Q0.5 (Hearing dog (with the 'Hearing Dogs for Deaf People' Association)): Retired as work was no longer available for him/her],
  pvtwdcs6.[4] [Q0.5 (Hearing dog (with the 'Hearing Dogs for Deaf People' Association)): Retired (reached normal retirement age)],
  pvtwdcs6.[5] [Q0.5 (Hearing dog (with the 'Hearing Dogs for Deaf People' Association)): Retired (due to health reasons)],
  pvtwdcs6.[6] [Q0.5 (Hearing dog (with the 'Hearing Dogs for Deaf People' Association)): Retired (due to behaviour reasons)],
  pvtwdcs6.[7] [Q0.5 (Hearing dog (with the 'Hearing Dogs for Deaf People' Association)): Retired (due to a change in owner's circumstances],
  pvtwdcs6.[8] [Q0.5 (Hearing dog (with the 'Hearing Dogs for Deaf People' Association)): Retired (other reasons) ID],
  wdcs6_ft.whyDogIsNotWorkingDetail [Q0.5 (Hearing dog (with the 'Hearing Dogs for Deaf People' Association)): Retired (other reasons) Desc],
  /*---Medical detection/alert dog---*/
  pvtwdcs7.[1] [Q0.5 (Medical detection/alert dog): Still working],
  pvtwdcs7.[2] [Q0.5 (Medical detection/alert dog): Temporarily not working (for example, due to injury)],
  pvtwdcs7.[3] [Q0.5 (Medical detection/alert dog): Retired as work was no longer available for him/her],
  pvtwdcs7.[4] [Q0.5 (Medical detection/alert dog): Retired (reached normal retirement age)],
  pvtwdcs7.[5] [Q0.5 (Medical detection/alert dog): Retired (due to health reasons)],
  pvtwdcs7.[6] [Q0.5 (Medical detection/alert dog): Retired (due to behaviour reasons)],
  pvtwdcs7.[7] [Q0.5 (Medical detection/alert dog): Retired (due to a change in owner's circumstances],
  pvtwdcs7.[8] [Q0.5 (Medical detection/alert dog): Retired (other reasons) ID],
  wdcs7_ft.whyDogIsNotWorkingDetail [Q0.5 (Medical detection/alert dog): Retired (other reasons) Desc],
  /*---Assistance dog (with the 'Canine Partners' Association)---*/
  pvtwdcs8.[1] [Q0.5 (Assistance dog (with the 'Canine Partners' Association)): Still working],
  pvtwdcs8.[2] [Q0.5 (Assistance dog (with the 'Canine Partners' Association)): Temporarily not working (for example, due to injury)],
  pvtwdcs8.[3] [Q0.5 (Assistance dog (with the 'Canine Partners' Association)): Retired as work was no longer available for him/her],
  pvtwdcs8.[4] [Q0.5 (Assistance dog (with the 'Canine Partners' Association)): Retired (reached normal retirement age)],
  pvtwdcs8.[5] [Q0.5 (Assistance dog (with the 'Canine Partners' Association)): Retired (due to health reasons)],
  pvtwdcs8.[6] [Q0.5 (Assistance dog (with the 'Canine Partners' Association)): Retired (due to behaviour reasons)],
  pvtwdcs8.[7] [Q0.5 (Assistance dog (with the 'Canine Partners' Association)): Retired (due to a change in owner's circumstances],
  pvtwdcs8.[8] [Q0.5 (Assistance dog (with the 'Canine Partners' Association)): Retired (other reasons) ID],
  wdcs8_ft.whyDogIsNotWorkingDetail [Q0.5 (Assistance dog (with the 'Canine Partners' Association)): Retired (other reasons) Desc],
  /*---Search and rescue dog (with 'The National Search and Rescue Dog Association')---*/
  pvtwdcs9.[1] [Q0.5 (Search and rescue dog): Still working],
  pvtwdcs9.[2] [Q0.5 (Search and rescue dog): Temporarily not working (for example, due to injury)],
  pvtwdcs9.[3] [Q0.5 (Search and rescue dog): Retired as work was no longer available for him/her],
  pvtwdcs9.[4] [Q0.5 (Search and rescue dog): Retired (reached normal retirement age)],
  pvtwdcs9.[5] [Q0.5 (Search and rescue dog): Retired (due to health reasons)],
  pvtwdcs9.[6] [Q0.5 (Search and rescue dog): Retired (due to behaviour reasons)],
  pvtwdcs9.[7] [Q0.5 (Search and rescue dog): Retired (due to a change in owner's circumstances],
  pvtwdcs9.[8] [Q0.5 (Search and rescue dog): Retired (other reasons) ID],
  wdcs9_ft.whyDogIsNotWorkingDetail [Q0.5 (Search and rescue dog): Retired (other reasons) Desc],
  /*---Pets as Therapy (PAT) dog (with the 'Pets As Therapy' Association)---*/
  pvtwdcs10.[1] [Q0.5 (Pets as Therapy (PAT) dog)): Still working],
  pvtwdcs10.[2] [Q0.5 (Pets as Therapy (PAT) dog)): Temporarily not working (for example, due to injury)],
  pvtwdcs10.[3] [Q0.5 (Pets as Therapy (PAT) dog)): Retired as work was no longer available for him/her],
  pvtwdcs10.[4] [Q0.5 (Pets as Therapy (PAT) dog)): Retired (reached normal retirement age)],
  pvtwdcs10.[5] [Q0.5 (Pets as Therapy (PAT) dog)): Retired (due to health reasons)],
  pvtwdcs10.[6] [Q0.5 (Pets as Therapy (PAT) dog)): Retired (due to behaviour reasons)],
  pvtwdcs10.[7] [Q0.5 (Pets as Therapy (PAT) dog)): Retired (due to a change in owner's circumstances],
  pvtwdcs10.[8] [Q0.5 (Pets as Therapy (PAT) dog)): Retired (other reasons) ID],
  wdcs10_ft.whyDogIsNotWorkingDetail [Q0.5 (Pets as Therapy (PAT) dog)): Retired (other reasons) Desc],
  /*---Emotional support dog---*/
  pvtwdcs11.[1] [Q0.5 (Emotional support dog): Still working],
  pvtwdcs11.[2] [Q0.5 (Emotional support dog): Temporarily not working (for example, due to injury)],
  pvtwdcs11.[3] [Q0.5 (Emotional support dog): Retired as work was no longer available for him/her],
  pvtwdcs11.[4] [Q0.5 (Emotional support dog): Retired (reached normal retirement age)],
  pvtwdcs11.[5] [Q0.5 (Emotional support dog): Retired (due to health reasons)],
  pvtwdcs11.[6] [Q0.5 (Emotional support dog): Retired (due to behaviour reasons)],
  pvtwdcs11.[7] [Q0.5 (Emotional support dog): Retired (due to a change in owner's circumstances],
  pvtwdcs11.[8] [Q0.5 (Emotional support dog): Retired (other reasons) ID],
  wdcs11_ft.whyDogIsNotWorkingDetail [Q0.5 (Emotional support dog): Retired (other reasons) Desc],
  /*---Post-traumatic stress disorder (PTSD) support dog---*/
  pvtwdcs12.[1] [Q0.5 (Post-traumatic stress disorder (PTSD) support dog): Still working],
  pvtwdcs12.[2] [Q0.5 (Post-traumatic stress disorder (PTSD) support dog): Temporarily not working (for example, due to injury)],
  pvtwdcs12.[3] [Q0.5 (Post-traumatic stress disorder (PTSD) support dog): Retired as work was no longer available for him/her],
  pvtwdcs12.[4] [Q0.5 (Post-traumatic stress disorder (PTSD) support dog): Retired (reached normal retirement age)],
  pvtwdcs12.[5] [Q0.5 (Post-traumatic stress disorder (PTSD) support dog): Retired (due to health reasons)],
  pvtwdcs12.[6] [Q0.5 (Post-traumatic stress disorder (PTSD) support dog): Retired (due to behaviour reasons)],
  pvtwdcs12.[7] [Q0.5 (Post-traumatic stress disorder (PTSD) support dog): Retired (due to a change in owner's circumstances],
  pvtwdcs12.[8] [Q0.5 (Post-traumatic stress disorder (PTSD) support dog): Retired (other reasons) ID],
  wdcs12_ft.whyDogIsNotWorkingDetail [Q0.5 (Post-traumatic stress disorder (PTSD) support dog): Retired (other reasons) Desc],
  /*---Other type of working dog and/or qualification from a different organisation (please specify)---*/
  s.otherWorkingDogTrainedAsName,
  pvtwdcs13.[1] [Q0.5 (Other (please specify)): Still working],
  pvtwdcs13.[2] [Q0.5 (Other (please specify)): Temporarily not working (for example, due to injury)],
  pvtwdcs13.[3] [Q0.5 (Other (please specify)): Retired as work was no longer available for him/her],
  pvtwdcs13.[4] [Q0.5 (Other (please specify)): Retired (reached normal retirement age)],
  pvtwdcs13.[5] [Q0.5 (Other (please specify)): Retired (due to health reasons)],
  pvtwdcs13.[6] [Q0.5 (Other (please specify)): Retired (due to behaviour reasons)],
  pvtwdcs13.[7] [Q0.5 (Other (please specify)): Retired (due to a change in owner's circumstances],
  pvtwdcs13.[8] [Q0.5 (Other (please specify)): Retired (other reasons) ID],
  wdcs13_ft.whyDogIsNotWorkingDetail [Q0.5 (Other (please specify)): Retired (other reasons) Desc],
  
  --Q0.6 "Toby" is training to be another type of working dog…
  s.isTrainingToBeAnotherWorkingDog [Q0.6: Training be another type of working dog ID],
  CASE
    when s.isTrainingToBeAnotherWorkingDog = 0 then 'No'
    when s.isTrainingToBeAnotherWorkingDog = 1 then 'Yes'
  END [Q0.6: Training be another type of working dog Desc],
  
  --Q0.7/3 "Toby" is training to be a/an…
  pvtwdttb.[1] [Q0.7/3: Police/military working dog],
  pvtwdttb.[2] [Q0.7/3: Gundog],
  pvtwdttb.[3] [Q0.7/3: Cattle dog],
  pvtwdttb.[4] [Q0.7/3: Sheep dog],
  pvtwdttb.[5] [Q0.7/3: Guide dog (with the 'Guide Dogs for the Blind' Association)],
  pvtwdttb.[6] [Q0.7/3: Hearing dog (with the 'Hearing Dogs for Deaf People' Association)],
  pvtwdttb.[7] [Q0.7/3: Medical detection/alert dog],
  pvtwdttb.[8] [Q0.7/3: Assistance dog (with the 'Canine Partners' Association)],
  pvtwdttb.[9] [Q0.7/3: Search and rescue dog (with 'The National Search and Rescue Dog Association')],
  pvtwdttb.[10] [Q0.7/3: Pets as Therapy (PAT) dog (with the 'Pets As Therapy' Association)],
  pvtwdttb.[11] [Q0.7/3: Emotional support dog],
  pvtwdttb.[12] [Q0.7/3: Post-traumatic stress disorder (PTSD) support dog],
  pvtwdttb.[13] [Q0.7/3: Other type of working dog and/or qualification from a different organisation (please specify) ID],
  s.otherWorkingDogTrainingToBeName [Q0.7/3: Other type of working dog and/or qualification from a different organisation (please specify) Desc],
  
  --Q1 "Toby" is a working dog…
  s.workingDogYetId [Q1: Working Dog Yed ID],
  wdy.workingDogYetName [Q1: Working Dog Yed Desc],
  --Q1.1 Please provide any information you are willing to share about why "Toby" is no longer a working dog…
  s.noLongerWorkingDogDetail [Q1.1: No longer working dog Detail],
  --Q2 "Toby" is trained as a/an…
  pvtwdta.[1] [Q2: Police/military working dog],
  pvtwdta.[2] [Q2: Gun dog],
  pvtwdta.[3] [Q2: Cattle dog],
  pvtwdta.[4] [Q2: Sheep dog],
  pvtwdta.[5] [Q2: Guide dog (with the 'Guide Dogs for the Blind' Association)],
  pvtwdta.[6] [Q2: Hearing dog (with the 'Hearing Dogs for Deaf People' Association)],
  pvtwdta.[7] [Q2: Medical detection/alert dog],
  pvtwdta.[8] [Q2: Assistance dog (with the 'Canine Partners' Association)],
  pvtwdta.[9] [Q2: Search and rescue dog (with 'The National Search and Rescue Dog Association')],
  pvtwdta.[10] [Q2: Pets as Therapy (PAT) dog (with the 'Pets As Therapy' Association)],
  pvtwdta.[11] [Q2: Emotional support dog],
  pvtwdta.[12] [Q2: Post-traumatic stress disorder (PTSD) support dog ],
  pvtwdta.[13] [Q2: Other type of working dog and/or qualification from a different organisation (please specify) ID],
  s.otherWorkingDogTrainedAsName [Q2: Other type of working dog and/or qualification from a different organisation (please specify) Desc],
  --Q3 "Toby" is training to be a/an…
  --Q4 "Toby" is currently licensed as a…
  pvtwdla.[1] [Q4: General Purpose police dog],
  pvtwdla.[2] [Q4: Firearms support dog],
  pvtwdla.[3] [Q4: Drugs, weapons, cash Search dog],
  pvtwdla.[4] [Q4: Passive drug dog],
  pvtwdla.[5] [Q4: Explosive search dog],
  pvtwdla.[6] [Q4: Digital detection dog],
  pvtwdla.[7] [Q4: Victim recovery dog],
  pvtwdla.[8] [Q4: Other (please specify)],
  s.otherWorkingDogLicensedAsName[Q4: Other (please specify)],
  --Q5 During the last 12 months, "Toby" has participated in one or more…
  pvtdpi.[1] [Q5: Kennel Club Good Citizen Dog Training Schemes],
  pvtdpi.[2] [Q5: Agility competitions],
  pvtdpi.[3] [Q5: Flyball competitions],
  pvtdpi.[4] [Q5: Obedience competitions],
  pvtdpi.[5] [Q5: Kennel Club showing competitions],
  pvtdpi.[6] [Q5: Fun/novelty dog shows],
  pvtdpi.[7] [Q5: Working dog trials],
  pvtdpi.[8] [Q5: Heelwork to music classes],
  pvtdpi.[9] [Q5: Rally competition classes],
  pvtdpi.[10] [Q5: Classes not listed above (please specify) ID],
  s.otherDogParticipatedInName [Q5: Classes not listed above (please specify) Desc],
  pvtdpi.[11] [Q5: None of the above],
  --Q6 During the last 12 months, "Toby" has…
  pvtla.[1] [Q6: Won an award at a Kennel Club activity (for example a Good Citizen Dog Scheme, agility, obedience)],
  pvtla.[2] [Q6: Won an award at an activity run by an organisation other than the Kennel Club (for example Schutzhund/IPO training)],
  pvtla.[3] [Q6: Won an award at a dog show (excluding 'novelty' classes such as waggiest tail)],
  pvtla.[4] [Q6: None of the above],
  pvtla.[5] [Q6: Won/achieved another type of award/qualification (please specify) ID],
  s.otherLifetimeAwardsName [Q6: Won/achieved another type of award/qualification (please specify) Desc],
  --Q7 The Kennel Club award(s) "Toby" won (within the last 12 months) was (/were) for a/an…
  pvtkca.[1] [Q7: Good Citizen Dog Scheme ],
  pvtkca.[2] [Q7: Obedience competition class],
  pvtkca.[3] [Q7: Agility competition class],
  pvtkca.[4] [Q7: Flyball competition class],
  pvtkca.[5] [Q7: Working trials competition class],
  pvtkca.[6] [Q7: Heelwork to music competition class],
  pvtkca.[7] [Q7: Rally competition class],
  pvtkca.[8] [Q7: None of the above],
  pvtkca.[9] [Q7: Other (please specify) ID],
  s.otherKennelClubAwardsName [Q7: Other (please specify) Desc],
  --Q8 Within the last 12 months, the Kennel Club Good Citizen Dog Scheme award(s) "Toby" won was (/were)…
  pvtkcgca.[1] [Q8: Puppy foundation],
  pvtkcgca.[2] [Q8: Bronze],
  pvtkcgca.[3] [Q8: Silver],
  pvtkcgca.[4] [Q8: Gold],
  pvtkcgca.[5] [Q8: I don't know/can't remember],
  --Q9 Within the last 12 months, the highest level Kennel Club obedience class that "Toby" has been placed 1st-4th at is…
  s.kennelClubHighestLevelObedienceId [Q9: Kennel Club Highest Level Obedience ID],
  kchlo.kennelClubHighestLevelObedienceName [Q9: Kennel Club Highest Level Obedience Desc],
  --Q10 Withn the last 12 months, the highest level Kennel Club agility class that "Toby" has been placed 1st-4th at is…
  s.kennelClubHighestLevelAgilityId [Q10: Kennel Club Highest Level Agility ID],
  kchla.kennelClubHighestLevelAgilityName [Q10: Kennel Club Highest Level Agility Desc],
  --Q11 Please use the space below to tell us the competition class(es) that "Toby" was awarded in (during the last 12 months)….
  s.competitionClassesDetail [Q11: Competition Classes Awarded Detail],
  --Q12 Please use the space below to tell us more about the award(s) "Toby" won (during the last 12 months) at an activity run by an organisation other than the Kennel Club (for example Schutzhund/IPO training)
  s.nonKennelClubAwardsDetail [Q12: Non-Kennel Club Awards Detail],
  --Q13 Please use the space below to tell us more about the dog show(s) that "Toby" won an award(s) at during the last 12 months (for example the type of dog show(s) and the award(s) won)
  s.dogShowAwardsDetail [Q13: Dog Show Awards Detail],
  --Q14 Please use the space below to tell us more about the other type(s) of award(s)/qualification(s) that "Toby" won/achieved during the last 12 months…
  s.awardsAndQualificationsDetail [Q14: Other Awards/Qualifications Detail],
  --Q15 Please use the space below to tell us about any of "Toby"'s other achievements during the last 12 months that you are proud of…
  s.proudOfAchievementsDetail [Q15: Other Proud Of Achievement Detail],
  --Q16 Please use the space below to add any other information about "Toby" that you would like to share with us.  For example, if you use 'ditch the bowl' approach to feeding you could use this space to tell us about how you feed "Toby".  
  s.dogOtherInfoDetail [Q16: Any Other Info]
  
from survey5years s 

--Q0.5 In your '4 year old' survey, you told us that "Toby" was a…
/*---Police/military working dog---*/
--Options
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		workingDogCurrentStatusName [Status Type],
		cast(wdcs.workingDogCurrentStatusId as varchar) as 'Status'

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs

	inner join  referenceWorkingDogCurrentStatus refwdcs

		on wdcs.workingDogCurrentStatusId = refwdcs.workingDogCurrentStatusId
    
  where wdcs.workingDogTrainedAsId = 1
  
	) wdcs
	PIVOT
	
	(min([Status Type]) For Status
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtwdcs1 on pvtwdcs1.ID = s.survey5YearsID  
  
--Free text
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		wdcs.whyDogIsNotWorkingDetail 

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs
    
  where wdcs.workingDogTrainedAsId = 1
  
	) wdcs1_ft on wdcs1_ft.ID = s.survey5YearsId
	
/*---Gun dog---*/
--Options
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		workingDogCurrentStatusName [Status Type],
		cast(wdcs.workingDogCurrentStatusId as varchar) as 'Status'

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs

	inner join  referenceWorkingDogCurrentStatus refwdcs

		on wdcs.workingDogCurrentStatusId = refwdcs.workingDogCurrentStatusId
    
  where wdcs.workingDogTrainedAsId = 2
  
	) wdcs
	PIVOT
	
	(min([Status Type]) For Status
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtwdcs2 on pvtwdcs2.ID = s.survey5YearsID  
  
--Free text
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		wdcs.whyDogIsNotWorkingDetail 

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs
    
  where wdcs.workingDogTrainedAsId = 2
  
	) wdcs2_ft on wdcs2_ft.ID = s.survey5YearsId
  
/*---Cattle dog---*/
--Options
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		workingDogCurrentStatusName [Status Type],
		cast(wdcs.workingDogCurrentStatusId as varchar) as 'Status'

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs

	inner join  referenceWorkingDogCurrentStatus refwdcs

		on wdcs.workingDogCurrentStatusId = refwdcs.workingDogCurrentStatusId
    
  where wdcs.workingDogTrainedAsId = 3
  
	) wdcs
	PIVOT
	
	(min([Status Type]) For Status
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtwdcs3 on pvtwdcs3.ID = s.survey5YearsID  
  
--Free text
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		wdcs.whyDogIsNotWorkingDetail 

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs
    
  where wdcs.workingDogTrainedAsId = 3
  
	) wdcs3_ft on wdcs3_ft.ID = s.survey5YearsId
  
/*---Sheep dog---*/
--Options
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		workingDogCurrentStatusName [Status Type],
		cast(wdcs.workingDogCurrentStatusId as varchar) as 'Status'

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs

	inner join  referenceWorkingDogCurrentStatus refwdcs

		on wdcs.workingDogCurrentStatusId = refwdcs.workingDogCurrentStatusId
    
  where wdcs.workingDogTrainedAsId = 4
  
	) wdcs
	PIVOT
	
	(min([Status Type]) For Status
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtwdcs4 on pvtwdcs4.ID = s.survey5YearsID  
  
--Free text
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		wdcs.whyDogIsNotWorkingDetail 

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs
    
  where wdcs.workingDogTrainedAsId = 4
  
	) wdcs4_ft on wdcs4_ft.ID = s.survey5YearsId
  
/*---Guide dog (with the 'Guide Dogs for the Blind' Association)---*/
--Options
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		workingDogCurrentStatusName [Status Type],
		cast(wdcs.workingDogCurrentStatusId as varchar) as 'Status'

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs

	inner join  referenceWorkingDogCurrentStatus refwdcs

		on wdcs.workingDogCurrentStatusId = refwdcs.workingDogCurrentStatusId
    
  where wdcs.workingDogTrainedAsId = 5
  
	) wdcs
	PIVOT
	
	(min([Status Type]) For Status
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtwdcs5 on pvtwdcs5.ID = s.survey5YearsID  
  
--Free text
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		wdcs.whyDogIsNotWorkingDetail 

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs
    
  where wdcs.workingDogTrainedAsId = 5
  
	) wdcs5_ft on wdcs5_ft.ID = s.survey5YearsId
  
/*---Hearing dog (with the 'Hearing Dogs for Deaf People' Association)---*/
--Options
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		workingDogCurrentStatusName [Status Type],
		cast(wdcs.workingDogCurrentStatusId as varchar) as 'Status'

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs

	inner join  referenceWorkingDogCurrentStatus refwdcs

		on wdcs.workingDogCurrentStatusId = refwdcs.workingDogCurrentStatusId
    
  where wdcs.workingDogTrainedAsId = 6
  
	) wdcs
	PIVOT
	
	(min([Status Type]) For Status
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtwdcs6 on pvtwdcs6.ID = s.survey5YearsID  
  
--Free text
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		wdcs.whyDogIsNotWorkingDetail 

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs
    
  where wdcs.workingDogTrainedAsId = 6
  
	) wdcs6_ft on wdcs6_ft.ID = s.survey5YearsId
  
/*---Medical detection/alert dog---*/
--Options
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		workingDogCurrentStatusName [Status Type],
		cast(wdcs.workingDogCurrentStatusId as varchar) as 'Status'

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs

	inner join  referenceWorkingDogCurrentStatus refwdcs

		on wdcs.workingDogCurrentStatusId = refwdcs.workingDogCurrentStatusId
    
  where wdcs.workingDogTrainedAsId = 7
  
	) wdcs
	PIVOT
	
	(min([Status Type]) For Status
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtwdcs7 on pvtwdcs7.ID = s.survey5YearsID  
  
--Free text
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		wdcs.whyDogIsNotWorkingDetail 

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs
    
  where wdcs.workingDogTrainedAsId = 7
  
	) wdcs7_ft on wdcs7_ft.ID = s.survey5YearsId
  
/*---Assistance dog (with the 'Canine Partners' Association)---*/
--Options
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		workingDogCurrentStatusName [Status Type],
		cast(wdcs.workingDogCurrentStatusId as varchar) as 'Status'

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs

	inner join  referenceWorkingDogCurrentStatus refwdcs

		on wdcs.workingDogCurrentStatusId = refwdcs.workingDogCurrentStatusId
    
  where wdcs.workingDogTrainedAsId = 8
  
	) wdcs
	PIVOT
	
	(min([Status Type]) For Status
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtwdcs8 on pvtwdcs8.ID = s.survey5YearsID  
  
--Free text
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		wdcs.whyDogIsNotWorkingDetail 

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs
    
  where wdcs.workingDogTrainedAsId = 8
  
	) wdcs8_ft on wdcs8_ft.ID = s.survey5YearsId
  
/*---Search and rescue dog (with 'The National Search and Rescue Dog Association')---*/
--Options
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		workingDogCurrentStatusName [Status Type],
		cast(wdcs.workingDogCurrentStatusId as varchar) as 'Status'

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs

	inner join  referenceWorkingDogCurrentStatus refwdcs

		on wdcs.workingDogCurrentStatusId = refwdcs.workingDogCurrentStatusId
    
  where wdcs.workingDogTrainedAsId = 9
  
	) wdcs
	PIVOT
	
	(min([Status Type]) For Status
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtwdcs9 on pvtwdcs9.ID = s.survey5YearsID  
  
--Free text
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		wdcs.whyDogIsNotWorkingDetail 

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs
    
  where wdcs.workingDogTrainedAsId = 9
  
	) wdcs9_ft on wdcs9_ft.ID = s.survey5YearsId
  
/*---Pets as Therapy (PAT) dog (with the 'Pets As Therapy' Association)---*/
--Options
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		workingDogCurrentStatusName [Status Type],
		cast(wdcs.workingDogCurrentStatusId as varchar) as 'Status'

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs

	inner join  referenceWorkingDogCurrentStatus refwdcs

		on wdcs.workingDogCurrentStatusId = refwdcs.workingDogCurrentStatusId
    
  where wdcs.workingDogTrainedAsId = 10
  
	) wdcs
	PIVOT
	
	(min([Status Type]) For Status
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtwdcs10 on pvtwdcs10.ID = s.survey5YearsID  
  
--Free text
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		wdcs.whyDogIsNotWorkingDetail 

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs
    
  where wdcs.workingDogTrainedAsId = 10
  
	) wdcs10_ft on wdcs10_ft.ID = s.survey5YearsId
  
/*---Emotional support dog---*/
--Options
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		workingDogCurrentStatusName [Status Type],
		cast(wdcs.workingDogCurrentStatusId as varchar) as 'Status'

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs

	inner join  referenceWorkingDogCurrentStatus refwdcs

		on wdcs.workingDogCurrentStatusId = refwdcs.workingDogCurrentStatusId
    
  where wdcs.workingDogTrainedAsId = 11
  
	) wdcs
	PIVOT
	
	(min([Status Type]) For Status
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtwdcs11 on pvtwdcs11.ID = s.survey5YearsID  
  
--Free text
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		wdcs.whyDogIsNotWorkingDetail 

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs
    
  where wdcs.workingDogTrainedAsId = 11
  
	) wdcs11_ft on wdcs11_ft.ID = s.survey5YearsId
  
/*---Post-traumatic stress disorder (PTSD) support dog---*/
--Options
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		workingDogCurrentStatusName [Status Type],
		cast(wdcs.workingDogCurrentStatusId as varchar) as 'Status'

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs

	inner join  referenceWorkingDogCurrentStatus refwdcs

		on wdcs.workingDogCurrentStatusId = refwdcs.workingDogCurrentStatusId
    
  where wdcs.workingDogTrainedAsId = 12
  
	) wdcs
	PIVOT
	
	(min([Status Type]) For Status
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtwdcs12 on pvtwdcs12.ID = s.survey5YearsID  
  
--Free text
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		wdcs.whyDogIsNotWorkingDetail 

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs
    
  where wdcs.workingDogTrainedAsId = 12
  
	) wdcs12_ft on wdcs12_ft.ID = s.survey5YearsId
  
/*---Other type of working dog and/or qualification from a different organisation (please specify)---*/
--Options
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		workingDogCurrentStatusName [Status Type],
		cast(wdcs.workingDogCurrentStatusId as varchar) as 'Status'

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs

	inner join  referenceWorkingDogCurrentStatus refwdcs

		on wdcs.workingDogCurrentStatusId = refwdcs.workingDogCurrentStatusId
    
  where wdcs.workingDogTrainedAsId = 13
  
	) wdcs
	PIVOT
	
	(min([Status Type]) For Status
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtwdcs13 on pvtwdcs13.ID = s.survey5YearsID  
  
--Free text
Left join 
	(Select 
		wdcs.survey5YearsId ID,
		wdcs.whyDogIsNotWorkingDetail 

	   from survey5Years_referenceWorkingDogTrainedAs_referenceWorkingDogCurrentStatus wdcs
    
  where wdcs.workingDogTrainedAsId = 13
  
	) wdcs13_ft on wdcs13_ft.ID = s.survey5YearsId
  
--Q0.7 "Toby" is training to be a/an…
Left join 
	(Select 
		wdttb.survey5YearsId ID,
		workingDogTrainingToBeName [Job Type],
		cast(wdttb.workingDogTrainingToBeId as varchar) as 'Job'

	   from survey5Years_referenceWorkingDogTrainingToBe wdttb

	inner join  referenceWorkingDogTrainingToBe refwdttb

		on wdttb.workingDogTrainingToBeId = refwdttb.workingDogTrainingToBeId
	) wdttb
	PIVOT
	
	(min([Job Type]) For Job
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13])
	) 
	pvtwdttb on pvtwdttb.ID = s.survey5YearsID  
  
--Q1 "Toby" is a working dog…
left join referenceworkingdogyet2 wdy 
  on wdy.workingDogYetId = s.workingDogYetId
  
--Q2 "Toby" is trained as a/an…  
Left join 
	(Select 
		wdta.survey5YearsId ID,
		workingDogTrainedAsName [Job Type],
		cast(wdta.workingDogTrainedAsId as varchar) as 'Job'

	   from survey5Years_referenceWorkingDogTrainedAs wdta

	inner join  referenceWorkingDogTrainedAs refwdta

		on wdta.workingDogTrainedAsId = refwdta.workingDogTrainedAsId
	) wdta
	PIVOT
	
	(min([Job Type]) For Job
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13])
	) 
	pvtwdta on pvtwdta.ID = s.survey5YearsID  
  
  
--Q4 "Toby" is currently licensed as a…
Left join 
	(Select 
		wdla.survey5YearsId ID,
		workingDogLicensedAsName [Job Type],
		cast(wdla.workingDogLicensedAsId as varchar) as 'Job'

	   from survey5Years_referenceWorkingDogLicensedAs wdla

	inner join  referenceWorkingDogLicensedAs refwdla

		on wdla.workingDogLicensedAsId = refwdla.workingDogLicensedAsId
	) wdla
	PIVOT
	
	(min([Job Type]) For Job
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtwdla on pvtwdla.ID = s.survey5YearsID  
  
--Q5 During the last 12 months, "Toby" has participated in one or more…
Left join 
	(Select 
		dpi.survey5YearsId ID,
		dogParticipatedInName [Comp Type],
		cast(dpi.dogParticipatedInId as varchar) as 'Comp'

	   from survey5Years_referenceDogParticipatedIn dpi

	inner join  referenceDogParticipatedIn refdpi

		on dpi.dogParticipatedInId = refdpi.dogParticipatedInId
	) dpi
	PIVOT
	
	(min([Comp Type]) For Comp
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11])
	) 
	pvtdpi on pvtdpi.ID = s.survey5YearsID  
  
--Q6 During the last 12 months, "Toby" has…
Left join 
	(Select 
		la.survey5YearsId ID,
		lifeTimeAwardsName [Award Type],
		cast(la.lifeTimeAwardsId as varchar) as 'Award'

	   from survey5Years_referenceLifetimeAwards la

	inner join  referenceLifetimeAwards refla

		on la.lifeTimeAwardsId = refla.lifetimeAwardsId
	) la
	PIVOT
	
	(min([Award Type]) For Award
		IN ([1], [2], [3], [4], [5])
	) 
	pvtla on pvtla.ID = s.survey5YearsID  
  
--Q7 The Kennel Club award(s) "Toby" won (within the last 12 months) was (/were) for a/an…
Left join 
	(Select 
		kca.survey5YearsId ID,
		kennelClubAwardsName [Award Type],
		cast(kca.kennelClubAwardsId as varchar) as 'Award'

	   from survey5Years_referenceKennelClubAwards kca

	inner join  referenceKennelClubAwards refkca

		on kca.kennelClubAwardsId = refkca.kennelClubAwardsId
	) kca
	PIVOT
	
	(min([Award Type]) For Award
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9])
	) 
	pvtkca on pvtkca.ID = s.survey5YearsID  
  
--Q8 Within the last 12 months, the Kennel Club Good Citizen Dog Scheme award(s) "Toby" won was (/were)…
Left join 
	(Select 
		kcgca.survey5YearsId ID,
		kennelClubGoodCitizenAwardsName [Award Type],
		cast(kcgca.kennelClubGoodCitizenAwardsId as varchar) as 'Award'

	   from survey5Years_referenceKennelClubGoodCitizenAwards kcgca

	inner join  referenceKennelClubGoodCitizenAwards refkcgca

		on kcgca.kennelClubGoodCitizenAwardsId = refkcgca.kennelClubGoodCitizenAwardsId
	) kcgca
	PIVOT
	
	(min([Award Type]) For Award
		IN ([1], [2], [3], [4], [5])
	) 
	pvtkcgca on pvtkcgca.ID = s.survey5YearsID  

  
--Q9 Within the last 12 months, the highest level Kennel Club obedience class that "Toby" has been placed 1st-4th at is…
left join referenceKennelClubHighestLevelObedience kchlo
  on kchlo.kennelClubHighestLevelObedienceId = s.kennelClubHighestLevelObedienceId
  
--Q10 Withn the last 12 months, the highest level Kennel Club agility class that "Toby" has been placed 1st-4th at is…
left join referenceKennelClubHighestLevelAgility kchla
  on kchla.kennelClubHighestLevelAgilityId = s.kennelClubHighestLevelAgilityId
  
/*----- Generic ------*/
left join DTGenPupAdmin.dbo.ExcludedDogs adminGP
	on adminGP.DogID = s.dogId
--left join tblAboutMe tblAbtMe
---	on (tblAbtMe.userid = s.userId AND tblAbtMe.dogid = s.dogId AND tblAbtMe.dogId is not null and tblAbtMe.SixMonthPercComplete is not null)

/*--multi-dogs--*/
left join(
    Select userID from dogcore
    Group by userID   
    Having Count(*)>1
) multidogs on multidogs.userId = s.userId