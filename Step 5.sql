select 
  s.dogId,
	s.userId ,
	s.survey5YearsId [5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
  --Q39: "Toby" had her lastest season…
  s.seasonHasHadLatest4YearsId [Q39: Had Latest Season ID],
  shl.seasonHasHadLatest4YearsName [Q39: Had Latest Season Desc],
  --Q41: "Toby"'s last season lasted for approximately...
  s.lastSeasonLengthOfId [Q41: Last Season Length ID],
  lslo.lastSeasonLengthOfName [Q41: Last Season Length Desc],
  --Q42: Thinking about "Toby"'s last season, I...
  s.lastSeasonResponseToId [Q42: Last Season Response To ID],
  lsrt.lastSeasonResponseToName [Q42: Last Season Response To Desc] ,
  --Q43: Toby has shown/is showing signs of a phantom/false pregnancy...
  s.showingSignsOfFalsePregnancyId [Q43: Showing Signs of Fasle/Phantom Pregnancy ID],
  fp.showingSignsOfFalsePregnancyName [Q43: Showing Signs of Fasle/Phantom Pregnancy ID],
  --Q44: When "Toby" was/is showing signs of a phantom/false pregnancy she...
  pvtrfp.[1] [Q44: Nested or made a bedding area], 
  pvtrfp.[2] [Q44: Paid particular attention to one or more of her toys], 
  pvtrfp.[3] [Q44: Had swollen mammary glands], 
  pvtrfp.[4] [Q44: Was producing milk], 
  pvtrfp.[5] [Q44: Was quiet and withdrawn], 
  pvtrfp.[6] [Q44: Showed signs of aggression to people], 
  pvtrfp.[7] [Q44: Showed signs of aggression to other dogs], 
  pvtrfp.[8] [Q44: Other (please specify) ID], 
  s.otherReactionToFalsePregnancy [Q44: Other (please specify) Desc], 
  --Q45: During her last season, "Toby" was mated...
  s.lastSeasonWasMatedId [Q45: Last Season Was Mated ID],
  lswm.lastSeasonWasMatedName [Q45: Last Season Was Mated Desc],
  --Q46: During her last season, "Toby" became pregnant…
  s.lastSeasonBecamePregnantId [Q46: Last Season Became Pregnant ID],
  lsbp.lastSeasonBecamePregnantName [Q46: Last Season Became Pregnant Desc],
  --Q47: "Toby"has had…
  pvthhl.[1] [Q47: One litter of puppies during the last 12 months],
  pvthhl.[2] [Q47: Two litters of puppies during the last 12 months],
  pvthhl.[3] [Q47: One or more litters of puppies, 13 or more months ago],
  pvthhl.[4] [Q47: No, she has never had a litter of puppies],
  --Q49: Thinking about the litter that was born within the last twelve months, "Toby" gave birth…
  s.birthHelpNeededId [Q49: Birth Help Needed ID],
  bhn.birthHelpNeededName [Q49: Birth Help Needed Desc],
  --Q50: The delivery of "Toby"'s puppy/puppies…
  pvtbhd.[1] [Q50: Took longer than expected], 
  pvtbhd.[2] [Q50: Involved a planned caesarean section], 
  pvtbhd.[3] [Q50: Involved an emergency caesarean section for some/all of her pups], 
  pvtbhd.[4] [Q50: Involved medication (other than that required for a caesarean) from a vet/vet nurse for some/all of her pups], 
  pvtbhd.[5] [Q50: Was manually helped by a vet/vet nurse], 
  pvtbhd.[6] [Q50: Was manually helped by someone other than a vet/vet nurse], 
  pvtbhd.[7] [Q50: I don't know/can't remember], 
  pvtbhd.[8] [Q50: Involved other difficulties/complications/help (please specify) ID], 
  s.otherBirthHelpDetail [Q50: Involved other difficulties/complications/help (please specify) Desc],
  --Q51: Thinking about the litter that was born within the last twelve months, "Toby" gave birth to this number of…
  /*---Stillborn puppies---*/
  s.numGivenBirthToId_stillborn [Q51: Number of puppies born in last 12 weeks: Stillborn ID],
  gb_sb.numGivenBirthToName [Q51: Number of puppies born in last 12 weeks: Stillborn Desc],
  /*---Puppies that died within the first 24 hours---*/
  s.numGivenBirthToId_died24hr [Q51: Number of puppies born in last 12 weeks: Died within 24hrs ID],
  gb_24h.numGivenBirthToName [Q51: Number of puppies born in last 12 weeks: Died within 24hrs Desc],
  /*---Puppies that died after 1-2 days---*/
  s.numGivenBirthToId_died1d [Q51: Number of puppies born in last 12 weeks: Died after 1-2 days ID],
  gb_1d.numGivenBirthToName [Q51: Number of puppies born in last 12 weeks: Died after 1-2 days Desc],
  /*---Puppies that died after 3-14 days---*/
  s.numGivenBirthToId_died3d [Q51: Number of puppies born in last 12 weeks: Died after 3-14 days ID],
  gb_3d.numGivenBirthToName [Q51: Number of puppies born in last 12 weeks: Died after 3-14 days Desc],
  /*---Puppies that died after 2 weeks but before 8 weeks of age---*/
  s.numGivenBirthToId_died2w [Q51: Number of puppies born in last 12 weeks: Died after 2 weeks but before 8 months ID],
  gb_2w.numGivenBirthToName [Q51: Number of puppies born in last 12 weeks: Died after 2 weeks but before 8 months Desc],
  /*---Puppies that survived beyond 8 weeks of age---*/
  s.numGivenBirthToId_survived [Q51: Number of puppies born in last 12 weeks: Survived ID],
  gb_surv.numGivenBirthToName [Q51: Number of puppies born in last 12 weeks: Survived Desc],
  --Q48: In total, during her lifetime, "Toby" has had…
  s.numLittersHadId [Q48: Number Litters Had In Lifetime ID],
  nlh.numLittersHadName [Q48: Number Litters Had In Lifetime Desc],
  --Q52: During the last twelve months, "Toby" has/has had…
  pvtbmi.[1] [Q52: Prostate cancer],
  pvtbmi.[2] [Q52: Enlarged/cystic/infected prostate],
  pvtbmi.[3] [Q52: A swollen/sore/twisted scrotum (testicular torsion)],
  pvtbmi.[4] [Q52: Testicular cancer],
  pvtbmi.[5] [Q52: Problems with his penis (for example with extension/retraction)],
  pvtbmi.[6] [Q52: Urethral prolapse],
  pvtbmi.[7] [Q52: Infection of the uterus/womb (pyometra)],
  pvtbmi.[8] [Q52: Vaginal (fold) prolapse (usually occurring during a season)],
  pvtbmi.[9] [Q52: Mammary cancer],
  pvtbmi.[10] [Q52: Sore/inflamed vagina (juvenile vaginitis)],
  pvtbmi.[11] [Q52: Difficulty getting pregnant],
  pvtbmi.[12] [Q52: Difficulty maintaining a pregnancy],
  pvtbmi.[13] [Q52: Physical difficulty with mating],
  pvtbmi.[14] [Q52: A lack of interest in mating],
  pvtbmi.[15] [Q52: Further information (Please specify)… ID],
  s.otherBreedingMedicalIssue [Q52: Further information (Please specify)… Desc],
  pvtbmi.[16] [Q52: None of these],
 
  --Q53.1: During the last twelve months, "Toby" has had his semen collected for artificial insemination…
  s.semenMatingTimes4YearsId_semenCollection [Q53.1: Semen collected for artifical insemination ID],
  scai.semenMatingTimes4YearsName [Q53.1: Semen collected for artifical insemination Desc],

  --Q53.2: During the last twelve months, "Toby" has been used as a stud dog for a planned mating…
  s.semenMatingTimes4YearsId_studPlanned [Q53.2: Used As Stud Dog in Last 12 Months (Planned) ID],
  scsd.semenMatingTimes4YearsName [Q53.2: Used As Stud Dog in Last 12 Months (Planned) Desc],

  --Q53.3: During the last twelve months, "Toby" has mated one or more female dogs as an unplanned mating…
  s.semenMatingTimes4YearsId_studUnPlanned [Q53.3: Used As Stud Dog in Last 12 Months (Unplanned) ID],
  scsu.semenMatingTimes4YearsName [Q53.3: Used As Stud Dog in Last 12 Months (Unplanned) Desc],

  --Q54: During the last twelve months, the number of times that "Toby" has mated a female dog is…
  s.maleMatingTimesId [Q54: Number Of Times Mated With Female Dog ID],
  mmt.maleMatingTimesName [Q54: Number Of Times Mated With Female Dog Desc]

from survey5years s

--Q39: "Toby" had her lastest season…
left join referenceSeasonHasHadLatest4Years shl
  on shl.seasonHasHadLatest4YearsId = s.seasonHasHadLatest4YearsId
  
--Q41: "Toby"'s last season lasted for approximately...
left join referenceLastSeasonLengthOf lslo  
  on lslo.lastSeasonLengthOfId = s.lastSeasonLengthOfId
  
--Q42: Thinking about "Toby"'s last season, I...
left join referenceLastSeasonResponseTo lsrt
  on lsrt.lastSeasonResponseToId = s.lastSeasonResponseToId
  
--Q43: Toby has shown/is showing signs of a phantom/false pregnancy...
left join referenceShowingSignsOfFalsePregnancy fp
  on fp.showingSignsOfFalsePregnancyId = s.showingSignsOfFalsePregnancyId
  
--Q44: When "Toby" was/is showing signs of a phantom/false pregnancy she...
Left join 
	(Select 
		rfp.survey5YearsId ID,
		reactionToFalsePregnancyName [Reaction Type],
		cast(rfp.reactionToFalsePregnancyId as varchar) as 'Reaction'

	   from survey5Years_referenceReactionToFalsePregnancy rfp

	inner join  referenceReactionToFalsePregnancy refvrfp

		on rfp.reactionToFalsePregnancyId = refvrfp.reactionToFalsePregnancyId
	) rfp 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtrfp on pvtrfp.ID = s.survey5YearsId
  
--Q45: During her last season, "Toby" was mated...
left join referenceLastSeasonWasMated lswm
  on lswm.lastSeasonWasMatedId = s.lastSeasonWasMatedId
  
--Q46: During her last season, "Toby" became pregnant…
left join referenceLastSeasonBecamePregnant lsbp
  on lsbp.lastSeasonBecamePregnantId = s.lastSeasonBecamePregnantId
  
--Q47: "Toby"has had…
Left join 
	(Select 
		hhl.survey5YearsId ID,
		hasHadLitter4YearsName [Reaction Type],
		cast(hhl.hasHadLitter4YearsId as varchar) as 'Reaction'

	   from survey5Years_referenceHasHadLitter4Years hhl

	inner join  referenceHasHadLitter4Years refhhl

		on hhl.hasHadLitter4YearsId = refhhl.hasHadLitter4YearsId
	) hhl 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4])
	) 
	pvthhl on pvthhl.ID = s.survey5YearsId
  
--Q49: Thinking about the litter that was born within the last twelve months, "Toby" gave birth…
left join referenceBirthHelpNeeded bhn 
  on bhn.birthHelpNeededId = s.birthHelpNeededId

--Q50: The delivery of "Toby"'s puppy/puppies…
Left join 
	(Select 
		bhd.survey5YearsId ID,
		birthHelpDetailName [Help Type],
		cast(bhd.birthHelpDetailId as varchar) as 'Help'

	   from survey5Years_referenceBirthHelpDetail bhd

	inner join  referenceBirthHelpDetail refbhd

		on bhd.birthHelpDetailId = refbhd.birthHelpDetailId
	) bhd 
	PIVOT
	
	(min([Help Type]) For Help
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtbhd on pvtbhd.ID = s.survey5YearsId
  
--Q51: Thinking about the litter that was born within the last twelve months, "Toby" gave birth to this number of…
/*---Stillborn puppies---*/
left join referenceNumGivenBirthTo gb_sb
  on gb_sb.numGivenBirthToId = s.numGivenBirthToId_stillborn
/*---Puppies that died within the first 24  hours---*/
left join referenceNumGivenBirthTo gb_24h
  on gb_24h.numGivenBirthToId = s.numGivenBirthToId_died24hr
/*---Puppies that died after 1-2 days---*/
left join referenceNumGivenBirthTo gb_1d
  on gb_1d.numGivenBirthToId = s.numGivenBirthToId_died1d
/*---Puppies that died after 3-14 days---*/
left join referenceNumGivenBirthTo gb_3d
  on gb_3d.numGivenBirthToId = s.numGivenBirthToId_died3d
/*---Puppies that died after 2 weeks but before 8 weeks of age---*/
left join referenceNumGivenBirthTo gb_2w
  on gb_2w.numGivenBirthToId = s.numGivenBirthToId_died2w
/*---Puppies that survived beyond 8 weeks of age---*/
left join referenceNumGivenBirthTo gb_surv
  on gb_surv.numGivenBirthToId = s.numGivenBirthToId_survived

--Q48: In total, during her lifetime, "Toby" has had…
left join referenceNumLittersHad  nlh
  on nlh.numLittersHadId = s.numLittersHadId
  
--Q52: During the last twelve months, "Toby" has/has had…
Left join 
	(Select 
		bmi.survey5YearsId ID,
		breedingMedicalIssueName [Issue Type],
		cast(bmi.breedingMedicalIssueId as varchar) as 'Issue'

	   from survey5Years_referenceBreedingMedicalIssue bmi

	inner join  referenceBreedingMedicalIssue refbmi

		on bmi.breedingMedicalIssueId = refbmi.breedingMedicalIssueId
	) bmi 
	PIVOT
	
	(min([Issue Type]) For Issue
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16])
	) 
	pvtbmi on pvtbmi.ID = s.survey5YearsId
  
--Q53.1: During the last twelve months, "Toby" has had his semen collected for artificial insemination…
left join referenceSemenMatingTimes4Years scai
  on scai.semenMatingTimes4YearsId = s.semenMatingTimes4YearsId_semenCollection

--Q53.2: During the last twelve months, "Toby" has been used as a stud dog for a planned mating…
left join referenceSemenMatingTimes4Years scsd
  on scsd.semenMatingTimes4YearsId = s.semenMatingTimes4YearsId_studPlanned

--Q53.3: During the last twelve months, "Toby" has mated one or more female dogs as an unplanned mating…
left join referenceSemenMatingTimes4Years scsu
  on scsu.semenMatingTimes4YearsId = s.semenMatingTimes4YearsId_studUnPlanned

--Q54: During the last twelve months, the number of times that "Toby" has mated a female dog is…
left join referenceMaleMatingTimes mmt  
  on mmt.maleMatingTimesId = s.maleMatingTimesId

 
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