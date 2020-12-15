select 
  s.survey5YearsId,
  s.dogId,
  -- Q13: In the last six months, "Toby" has had...
  hp.Problem,
  hp.[Problem Type],
  -- Q13.a Sorry to hear "Toby" has been unwell/injured. Could you please tell us how long he/she was/has been poorly/affected by this problem for?
  pvtsd.[1] [Q13.a: Less than 1 day],
  pvtsd.[2] [Q13.a: 1 to 2 days],
  pvtsd.[3] [Q13.a: 3 or more days],
  --Q13.a.i Is he/she better now?
  pvtpbn.[1] [Q13.a.i: Yes],
  pvtpbn.[2] [Q13.a.i: No],
  --Q13.a.ii Did "Toby" see a vet for this?
  pvtssvt.[1] [Q13.a.ii Yes],
  pvtssvt.[2] [Q13.a.ii No],
  pvtssvt.[3] [Q13.a.ii No, but I spoke to a vet who gave me advice],
  pvtssvt.[4] [Q13.a.ii No, but I have booked an appointment],
  --Q13.a.iii What was the cause of the cut/wound?
  ccw.[Casue of Cut/Wound] [Q13.a.iii: Cause of Cut/Wound],
  --Q13.a.iv How was the wound treated?
  pvtwtt.[1] [Q13.a.iv: Cleaned with water],
  pvtwtt.[2] [Q13.a.iv: Cleaned with salt water],
  pvtwtt.[3] [Q13.a.iv: Vet closed wound with staples/stitches/glue],
  pvtwtt.[4] [Q13.a.iv: Vet didn't close wound, but covered/bandaged it],
  pvtwtt.[5] [Q13.a.iv: Vet gave him/her antibiotics],
  pvtwtt.[6] [Q13.a.iv: Vet checked, but no antibiotics needed],
  pvtwtt.[7] [Q13.a.iv: Vet treated, but not sure what was given],
  pvtwtt.[8] [Q13.a.iv: No cleaning/treatment was given],
  pvtwtt.[9] [Q13.a.iv: Other (please specify) ID],
  owtt.otherWoundTreatedType [Q13.a.iv: Other (please specify) Desc],
  --Q13.a.v The wound…
  pvtwat.[1] [Q13.a.v: healed without any problems],
  pvtwat.[2] [Q13.a.v: needed to have its stitches/staples left in for longer than originally planned],
  pvtwat.[3] [Q13.a.v: had its stitches/staples removed by this dog, or another dog],
  pvtwat.[4] [Q13.a.v: was painful],
  pvtwat.[5] [Q13.a.v: turned red],
  pvtwat.[6] [Q13.a.v: became smelly],
  pvtwat.[7] [Q13.a.v: oozed liquid],
  pvtwat.[8] [Q13.a.v: became infected],
  pvtwat.[9] [Q13.a.v: opened up/the stitches failed],
  pvtwat.[10] [Q13.a.v: became swollen],
  pvtwat.[11] [Q13.a.v: was licked/bitten by my dog],
  pvtwat.[12] [Q13.a.v: was licked/bitten by another dog],
  pvtwat.[13] [Q13.a.v: other problems developed (please specify) ID],
  owat.otherWoundActionType [Q13.a.v: other problems developed (please specify) Desc],
  --Q13.a.vi Following these problems, to help "Toby"'s wound to heal, a vet/vet nurse…
  pvtwvat.[1] [Q13.a.vi: checked the wound and did not give antibiotics],
  pvtwvat.[2] [Q13.a.vi: gave him/her antibiotics at the practice],
  pvtwvat.[3] [Q13.a.vi: gave him/her medication at the practice - not sure if it was antibiotics],
  pvtwvat.[4] [Q13.a.vi: gave him/her antibiotics to be given at home],
  pvtwvat.[5] [Q13.a.vi: gave him/her medication to be given at home - not sure if it was antibiotics],
  pvtwvat.[6] [Q13.a.vi: not applicable - a vet/vet nurse did not check the wound],
  pvtwvat.[7] [Q13.a.vi: Other (please specify) ID],
  owvat.otherWoundVetActionType [Q13.a.vi: Other (please specify) Desc],
  --Q14 During the last three months, approximately how many times has this happened?
  pvthpft.[1] [Q14: Once],
  pvthpft.[2] [Q14: Twice],
  pvthpft.[3] [Q14: 3-5 times],
  pvthpft.[4] [Q14: 6-10 times],
  pvthpft.[5] [Q14: 11 or more times],
  pvthpft.[6] [Q14: I don't know/can't remember]
  --Q15 Did "Toby" see a vet for this?
  --Q15.1 During the last three months, approximately how many times has this happened?
  --Q15.2 Did "Toby" see a vet for this?
  --Q16 During the last three months, approximately how many times has this happened?
  --Q17 Did "Toby" see a vet for this?
  --Q17.1 During the last three months, approximately how many times has this happened?
  --Q17.2 Did "Toby" see a vet for this?

from survey5years s

-- Q13: In the last six months, "Toby" has had...
Left join 
	(Select 
		hp.survey5YearsId ID,
		healthProblemTypeName [Problem Type],
		cast(hp.healthProblemTypeId as varchar) as 'Problem'

	   from survey5Years_referenceHealthProblems hp

	inner join  referenceHealthProblems refhp

		on hp.healthProblemTypeId = refhp.healthProblemTypeId
	) hp
 on hp.ID = s.survey5YearsID
  
-- Q13.a Sorry to hear "Toby" has been unwell/injured. Could you please tell us how long he/she was/has been poorly/affected by this problem for?
Left join 
	(Select 
		sd.survey5YearsId ID,
    sd.healthProblemTypeId HID,
		sickDurationTypeName [Duration Type],
		cast(sd.sickDurationTypeId as varchar) as 'Duration'

	   from survey5Years_referenceSickDurationType sd

	inner join  referenceSickDurationType refsd

		on sd.sickDurationTypeId = refsd.sickDurationTypeId
	) sd
	PIVOT
	
	(min([Duration Type]) For Duration
		IN ([1], [2], [3])
	) 
	pvtsd 
  
  on  pvtsd.HID = hp.Problem and pvtsd.ID = s.survey5YearsId

--Q13.a.i Is he/she better now?
Left join 
	(Select 
		pbn.survey5YearsId ID,
    pbn.healthProblemTypeId HID,
		CASE
      WHEN pbn.puppyBetterNow = 1 THEN 'Yes'
      WHEN pbn.puppyBetterNow = 2 THEN 'No'
    END [Better Type],
		cast(pbn.puppyBetterNow as varchar) as 'Better'

	   from survey5Years_referencePuppyBetterNow pbn

	) pbn
	PIVOT
	
	(min([Better Type]) For Better
		IN ([1], [2])
	) 
	pvtpbn 
  
  on  pvtpbn.HID = hp.Problem and pvtpbn.ID = s.survey5YearsId


--Q13.a.ii Did "Toby" see a vet for this?
Left join 
	(Select 
		ssvt.survey5YearsId ID,
    ssvt.healthProblemTypeId HID,
		sickSeenVetTypeName [Response Type],
		cast(ssvt.sickSeenVetTypeId as varchar) as 'Response'

	   from survey5Years_referenceSickSeenVetType2 ssvt

	inner join  referenceSickSeenVetType2 refssvt

		on ssvt.sickSeenVetTypeId = refssvt.sickSeenVetTypeId
	) ssvt
	PIVOT
	
	(min([Response Type]) For Response
		IN ([1], [2], [3], [4])
	) 
	pvtssvt
  
  on  pvtssvt.HID = hp.Problem and pvtssvt.ID = s.survey5YearsId
  
--Q13.a.iii What was the cause of the cut/wound?
--survey5Years_referenceCauseOfCutWound
Left join 
	(Select 
		ccw.survey5YearsId ID,
    ccw.healthProblemTypeId HID,
		ccw.causeOfCutWound [Casue of Cut/Wound]

	   from survey5Years_referenceCauseOfCutWound ccw	
	) ccw

  
  on  ccw.HID = hp.Problem and ccw.ID = s.survey5YearsId

  
--Q13.a.iv How was the wound treated?
/*--Options--*/
Left join 
	(Select 
		wtt.survey5YearsId ID,
    wtt.healthProblemTypeId HID,
		woundTreatedTypeName [Treatment Type],
		cast(wtt.woundTreatedTypeId as varchar) as 'Treatment'

	   from survey5Years_referenceWoundTreatedType wtt

	inner join  referenceWoundTreatedType refwtt

		on wtt.woundTreatedTypeId = refwtt.woundTreatedTypeId
	) wtt
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2], [3], [4], [5], [6], [7], [9], [8])
	) 
	pvtwtt
  
  on  pvtwtt.HID = hp.Problem and pvtwtt.ID = s.survey5YearsId
/*--Free Text--*/
Left join 
	(Select 
		owtt.survey5YearsId ID,
    owtt.healthProblemTypeId HID,
		owtt.otherWoundTreatedType 

	   from survey5Years_referenceOtherWoundTreatedType owtt

	) owtt
  on  owtt.HID = hp.Problem and owtt.ID = s.survey5YearsId
  
--Q13.a.v The wound…
/*--Options--*/
Left join 
	(Select 
		wat.survey5YearsId ID,
    wat.healthProblemTypeId HID,
		woundActionTypeName [Action Type],
		cast(wat.woundActionTypeId as varchar) as 'Action'

	   from survey5Years_referenceWoundActionType wat

	inner join  referenceWoundActionType refwat

		on wat.woundActionTypeId = refwat.woundActionTypeId
	) wat
	PIVOT
	
	(min([Action Type]) For Action
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13])
	) 
	pvtwat
  
  on  pvtwat.HID = hp.Problem and pvtwat.ID = s.survey5YearsId
  
/*--Free Text--*/
Left join 
	(Select 
		owat.survey5YearsId ID,
    owat.healthProblemTypeId HID,
		owat.otherWoundActionType 

	   from survey5Years_referenceOtherWoundActionType owat

	) owat
  on  owat.HID = hp.Problem and owat.ID = s.survey5YearsId
  
 --Q13.a.vi Following these problems, to help "Toby"'s wound to heal, a vet/vet nurse…
 /*--Options--*/
Left join 
	(Select 
		wvat.survey5YearsId ID,
    wvat.healthProblemTypeId HID,
		woundVetActionTypeName [Action Type],
		cast(wvat.woundVetActionTypeId as varchar) as 'Action'

	   from survey5Years_referenceWoundVetActionType wvat

	inner join  referenceWoundVetActionType refwvat

		on wvat.woundVetActionTypeId = refwvat.woundVetActionTypeId
	) wvat
	PIVOT
	
	(min([Action Type]) For Action
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtwvat
  
  on  pvtwvat.HID = hp.Problem and pvtwvat.ID = s.survey5YearsId
  
/*--Free Text--*/
Left join 
	(Select 
		owvat.survey5YearsId ID,
    owvat.healthProblemTypeId HID,
		owvat.otherWoundVetActionType 

	   from survey5Years_referenceOtherWoundVetActionType owvat

	) owvat
  on  owvat.HID = hp.Problem and owvat.ID = s.survey5YearsId
     

--Q14 During the last three months, approximately how many times has this happened?
 /*--Options--*/
Left join 
	(Select 
		hpft.survey5YearsId ID,
    hpft.healthProblemTypeId HID,
		healthProblemFrequencyTypeName [Freq Type],
		cast(hpft.healthProblemFrequencyTypeId as varchar) as 'Freq'

	   from survey5Years_referenceHealthProblemFrequencyType hpft

	inner join  referenceHealthProblemFrequencyType refhpft

		on hpft.healthProblemFrequencyTypeId = refhpft.healthProblemFrequencyTypeId
	) hpft
	PIVOT
	
	(min([Freq Type]) For Freq
		IN ([1], [2], [3], [4], [5], [6])
	) 
	pvthpft
  
  on  pvthpft.HID = hp.Problem and pvthpft.ID = s.survey5YearsId
  
  
where hp.Problem is not null