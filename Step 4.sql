select 
  s.dogId,
	s.userId ,
	s.survey5YearsId [5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
  --Q36.1 When "Toby" was being neutered another surgical procedure was carried out at the same time…
  pvtasdn.[1] [Q36.1: Umbilical hernia repair],
  pvtasdn.[2] [Q36.1: Gastropexy (to reduce the risk of bloat)],
  pvtasdn.[3] [Q36.1: Nose/nostril surgery (nostril widening to help breathing)],
  pvtasdn.[4] [Q36.1: Soft palate surgery (shortening of the soft palate to help breathing)],
  pvtasdn.[5] [Q36.1: Removal of one or more lumps],
  pvtasdn.[6] [Q36.1: Removal of one or more dew claws],
  pvtasdn.[7] [Q36.1: No additional surgical procedures],
  pvtasdn.[8] [Q36.1: Other (please specify) ID],
  s.otherAdditionalSurgeryDuringNeutering [Q36.1: Other (please specify) Desc],
  --Q36.12 What type of 'lump' was it/were they?
  pvttoldn.[1] [Q36.12: A mammary gland mass],
  pvttoldn.[2] [Q36.12: A fatty lump],
  pvttoldn.[3] [Q36.12: Another type of lump],
  pvttoldn.[4] [Q36.12: I don't know/can't remember],
  --Q36.13 Please provide further details of the 'lump' here, for example whether tests were carried out to confirm if it was cancerous or not, results of the tests, follow-up treatment.  Thank you.
  s.detailTypeOfLump_duringNeutering [Q36.13: Lump detail (During Neutering)],
  --Q36.154 During the last six months, "Toby" has had the following surgical procedures (separate from any neutering operation and not previously mentioned)…
  pvtasg.[1] [Q36.154: Removal of one or more lumps],
  pvtasg.[2] [Q36.154: Removal of one or more dew claws],
  pvtasg.[3] [Q36.154: Removal of a foreign object from his/her digestive system (stomach or intestine)],
  pvtasg.[4] [Q36.154: Fracture repair],
  pvtasg.[5] [Q36.154: Leg amputation],
  pvtasg.[6] [Q36.154: Dental work],
  pvtasg.[7] [Q36.154: GDV surgery (to treat bloat/twisting of the stomach)],
  pvtasg.[8] [Q36.154: Gastropexy (to reduce the risk of bloat)],
  pvtasg.[9] [Q36.154: Nose/nostril surgery (nostril widening to help breathing)],
  pvtasg.[10] [Q36.154: Soft palate surgery (shortening of the soft palate to help breathing)],
  pvtasg.[11] [Q36.154: Caesarean section],
  pvtasg.[12] [Q36.154: No surgical procedures],
  pvtasg.[13] [Q36.154: Other (please specify) ID],
  s.otherAdditionalSurgery [Q36.154: Other (please specify) Desc],
  --Q36.155 What type of 'lump' was it/were they?
  pvttolas.[1] [Q36.155: A mammary gland mass],
  pvttolas.[2] [Q36.155: A fatty lump],
  pvttolas.[3] [Q36.155: Another type of lump],
  pvttolas.[4] [Q36.155: I don't know/can't remember],
  --Q36.156 Please provide further details of the 'lump(s)' here, for example whether tests were carried out to confirm if it was/they were cancerous or not, results of the tests, follow-up treatment.  Thank you.
  s.detailTypeOfLump_additionalSurgery [Q36.156: Lump detail (Additional Surgery)],
  --Q36.16 The foreign object that "Toby" had removed was…
  pvtfot.[1] [Q36.16: A lumpy/round object (for example a bone, toy, stone)],
  pvtfot.[2] [Q36.16: A long/thin object (for example string, t-towel)],
  pvtfot.[3] [Q36.16: I don't know the shape of the object],
  pvtfot.[4] [Q36.16: Identified as (please detail below) ID],
  s.otherForeignObjectType [Q36.16: Identified as (please detail below) Desc],
  --Q36.2 The surgery that "Toby" had most recently was…
  s.lastSurgeryTypeId [Q36.2: Most Recent Surgery ID], 
  lst.lastSurgeryTypeName [Q36.2: Most Recent Surgery Desc],
  s.otherLastSurgeryType [Q36.2: Other (Please Specify)],
  --QN3.25 "Toby"'s operation was…
  s.lastSurgeryDateId [QN3.25: Most Recent Surgery Date ID],
  lsd.lastSurgeryDateName [QN3.25: Most Recent Surgery Date Desc],
  --Q36.25 When "Toby" came home after his/her operation, my vet practice gave me…
  pvtlspmt.[1] [Q36.25: Tablets to give him/her],
  pvtlspmt.[2] [Q36.25: Liquid for his/her food],
  pvtlspmt.[3] [Q36.25: No medication for him/her],
  pvtlspmt.[4] [Q36.25: Other (please specify) ID],
  s.otherLastSurgeryPostMedicationType [Q36.25: Other (please specify) Desc],
  --Q36.26 The tablets were…
  pvtpmdt.[1] [Q36.26: Antibiotics],
  pvtpmdt.[2] [Q36.26: Painkillers],
  pvtpmdt.[3] [Q36.26: I don't know what they were],
  pvtpmdt.[4] [Q36.26: Other (please specify) ID],
  s.otherLastSurgeryPostMedicationDetail_tablets [Q36.26: Other (please specify) Desc],
  --Q36.27 The liquid was…
  pvtpmdl.[1] [Q36.27: Antibiotics],
  pvtpmdl.[2] [Q36.27: Painkillers],
  pvtpmdl.[3] [Q36.27: I don't know what it was],
  pvtpmdl.[4] [Q36.27: Other (please specify) ID],
  s.otherLastSurgeryPostMedicationDetail_liquids [Q36.27: Other (please specify) Desc],
  --Q36.28 If known, please write the name of the medication(s) here…
  s.detailMedicationType [Q36.28: Medication Detail],
  --Q36.29 "Toby" has had…
  s.lastSurgeryPostMedicationStatusId [Q36.29: Post Surgery Medication ID],
  lspms.lastSurgeryPostMedicationStatusName [Q36.29: Post Surgery Medication Desc],
  --Q36.4 Toby went back to the vet practice for a post-operative check up…
  pvtlspc.[1] [Q36.4: No check-up yet, but will be going],
  pvtlspc.[2] [Q36.4: No check-up needed],
  pvtlspc.[3] [Q36.4: Once, 2-4 days after the operation],
  pvtlspc.[4] [Q36.4: Once, 5-7 days after the operation],
  pvtlspc.[5] [Q36.4: Once, 8-9 days after the operation],
  pvtlspc.[6] [Q36.4: Once, 10-14 days after the operation],
  pvtlspc.[7] [Q36.4: Twice, (2-4 days and 10-14 days) after the operation],
  pvtlspc.[8] [Q36.4: Yes - different timescale/frequency (please specify) ID],
  s.otherLastSurgeryPostCheckup [Q36.4: Yes - different timescale/frequency (please specify) Desc],
  --Q36.5 The surgical wound…
  pvtlspw.[1] [Q36.5: Healed without any problems],
  pvtlspw.[2] [Q36.5: Needed to have its stitches/staples left in for longer than originally planned],
  pvtlspw.[3] [Q36.5: Had its stitches/staples removed by this dog, or another dog],
  pvtlspw.[4] [Q36.5: Was painful],
  pvtlspw.[5] [Q36.5: Turned red],
  pvtlspw.[6] [Q36.5: Became smelly],
  pvtlspw.[7] [Q36.5: Oozed liquid],
  pvtlspw.[8] [Q36.5: Became infected],
  pvtlspw.[9] [Q36.5: Opened up/the stitches failed],
  pvtlspw.[10] [Q36.5: Became swollen],
  pvtlspw.[11] [Q36.5: Was licked/bitten by this dog],
  pvtlspw.[12] [Q36.5: Was licked/bitten by another dog],
  pvtlspw.[13] [Q36.5: Not applicable - no surgical wound],
  pvtlspw.[14] [Q36.5: Other problems developed (please specify) ID],
  s.otherLastSurgeryWound [Q36.5: Other problems developed (please specify) Desc],
  --Q36.6 Following these problems, to help "Toby"'s wound to heal, a vet/vet nurse…
  pvtlspwa.[1] [Q36.6: Checked the wound and did not give antibiotics],
  pvtlspwa.[2] [Q36.6: Gave him/her antibiotics at the practice],
  pvtlspwa.[3] [Q36.6: Gave him/her medication at the practice - not sure if it was antibiotics],
  pvtlspwa.[4] [Q36.6: Gave him/her antibiotics to be given at home],
  pvtlspwa.[5] [Q36.6: Gave him/her medication to be given at home - not sure if it was antibiotics],
  pvtlspwa.[6] [Q36.6: Did not check the wound],
  pvtlspwa.[7] [Q36.6: Other (please specify) ID],
  s.otherLastSurgeryWoundAction [Q36.6: Other (please specify) Desc],
  --QN2 Toby was surgically neutered when aged approximately…
  s.neuterAge5YearsDetails [QN2: Neuter Aage],
  --QN3 After "Toby" was neutered (spayed or castrated) he/she wore a/an…
  s.neuterAfterClothingTypeId [QN3: After Neuter Clothing ID],
  nact.neuterAfterClothingTypeName [QN3: After Neuter Clothing Desc],
  s.otherNeuterAfterClothingType [QN3: After Neuter Clothing: Other (Please Specify)],
  --QN5 "Toby"'s surgical wound was closed with…
  s.neuterWoundClosureTypeId [QN5: Neuter Wound Closure ID], 
  nwct.neuterWoundClosureTypeName [QN5: Neuter Wound Closure Desc],
  --QN5.1 "Toby"'s spay involved removal of her…
  s.neuterSpayTypeId [QN5.1: Neuter Spray Type ID],
  nst.neuterSpayTypeName [QN5.1: Neuter Spray Type Desc],
  --QN5.2 "Toby"'s spay was carried out by…
  s.neuterSpaySurgeryTypeId [QN5.2: Spray Surgery Type ID],
  nsst.neuterSpaySurgeryTypeName [QN5.2: Spray Surgery Type Desc]
  

from survey5years s

--Q36.1 When "Toby" was being neutered another surgical procedure was carried out at the same time…
Left join 
	(Select 
		asdn.survey5YearsId ID,
		additionalSurgeryDuringNeuteringName [Surgery Type],
		cast(asdn.additionalSurgeryDuringNeuteringId as varchar) as 'Surgery'

	   from survey5Years_referenceAdditionalSurgeryDuringNeutering asdn

	inner join  referenceAdditionalSurgeryDuringNeutering refasdn

		on asdn.additionalSurgeryDuringNeuteringId = refasdn.additionalSurgeryDuringNeuteringId
	) asdn
	PIVOT
	
	(min([Surgery Type]) For Surgery
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
  )
  pvtasdn on pvtasdn.ID = s.survey5YearsID 
  
--Q36.12 What type of 'lump' was it/were they?
Left join 
	(Select 
		toldn.survey5YearsId ID,
		typeOfLumpName [Lump Type],
		cast(toldn.typeOfLumpId as varchar) as 'Lump'

	   from survey5Years_referenceTypeOfLump_duringNeutering toldn

	inner join  referenceTypeOfLump reftoldn

		on toldn.typeOfLumpId = reftoldn.typeOfLumpId
	) toldn
	PIVOT
	
	(min([Lump Type]) For Lump
		IN ([1], [2], [3], [4])
  )
  pvttoldn on pvttoldn.ID = s.survey5YearsID 
  
--Q36.154 During the last six months, "Toby" has had the following surgical procedures (separate from any neutering operation and not previously mentioned)…
Left join 
	(Select 
		asg.survey5YearsId ID,
		additionalSurgeryName [Surgery Type],
		cast(asg.additionalSurgeryId as varchar) as 'Surgery'

	   from survey5Years_referenceAdditionalSurgery asg

	inner join  referenceAdditionalSurgery refasg

		on asg.additionalSurgeryId = refasg.additionalSurgeryId
	) asg
	PIVOT
	
	(min([Surgery Type]) For Surgery
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13])
  )
  pvtasg on pvtasg.ID = s.survey5YearsID 
  
--Q36.155 What type of 'lump' was it/were they?
Left join 
	(Select 
		tolas.survey5YearsId ID,
		typeOfLumpName [Lump Type],
		cast(tolas.typeOfLumpId as varchar) as 'Lump'

	   from survey5Years_referenceTypeOfLump_additionalSurgery tolas

	inner join  referenceTypeOfLump reftolas

		on tolas.typeOfLumpId = reftolas.typeOfLumpId
	) tolas
	PIVOT
	
	(min([Lump Type]) For Lump
		IN ([1], [2], [3], [4])
  )
  pvttolas on pvttolas.ID = s.survey5YearsID 
  
--Q36.16 The foreign object that "Toby" had removed was…
Left join 
	(Select 
		fot.survey5YearsId ID,
		foreignObjectTypeName [Object Type],
		cast(fot.foreignObjectTypeId as varchar) as 'Object'

	   from survey5Years_referenceForeignObjectType fot

	inner join  referenceForeignObjectType reffot

		on fot.foreignObjectTypeId = reffot.foreignObjectTypeId
	) fot
	PIVOT
	
	(min([Object Type]) For Object
		IN ([1], [2], [3], [4])
  )
  pvtfot on pvtfot.ID = s.survey5YearsID 
  
--Q36.2 The surgery that "Toby" had most recently was…
left join referenceLastSurgeryType lst
  on lst.lastSurgeryTypeId = s.lastSurgeryTypeId
  
--QN3.25 "Toby"'s operation was…
left join referenceLastSurgeryDate lsd
  on lsd.lastSurgeryDateId = s.lastSurgeryDateId
  
--Q36.25 When "Toby" came home after his/her operation, my vet practice gave me…
Left join 
	(Select 
		lspmt.survey5YearsId ID,
		lastSurgeryPostMedicationTypeName [Medication Type],
		cast(lspmt.lastSurgeryPostMedicationTypeId as varchar) as 'Medication'

	   from survey5Years_referenceLastSurgeryPostMedicationType lspmt

	inner join  referenceLastSurgeryPostMedicationType reflspmt

		on lspmt.lastSurgeryPostMedicationTypeId = reflspmt.lastSurgeryPostMedicationTypeId
	) lspmt
	PIVOT
	
	(min([Medication Type]) For Medication
		IN ([1], [2], [3], [4])
  )
  pvtlspmt on pvtlspmt.ID = s.survey5YearsID 
  
--Q36.26 The tablets were…
Left join 
	(Select 
		pmdt.survey5YearsId ID,
		lastSurgeryPostMedicationDetailName [Medication Type],
		cast(pmdt.lastSurgeryPostMedicationDetailId as varchar) as 'Medication'

	   from survey5Years_referenceLastSurgeryPostMedicationDetail_tablets pmdt

	inner join  referenceLastSurgeryPostMedicationDetail reflpmdt

		on pmdt.lastSurgeryPostMedicationDetailId = reflpmdt.lastSurgeryPostMedicationDetailId
	) pmdt
	PIVOT
	
	(min([Medication Type]) For Medication
		IN ([1], [2], [3], [4])
  )
  pvtpmdt on pvtpmdt.ID = s.survey5YearsID 
  
--Q36.27 The liquid was…
Left join 
	(Select 
		pmdl.survey5YearsId ID,
		lastSurgeryPostMedicationDetailName [Medication Type],
		cast(pmdl.lastSurgeryPostMedicationDetailId as varchar) as 'Medication'

	   from survey5Years_referenceLastSurgeryPostMedicationDetail_liquids pmdl

	inner join  referenceLastSurgeryPostMedicationDetail reflpmdl

		on pmdl.lastSurgeryPostMedicationDetailId = reflpmdl.lastSurgeryPostMedicationDetailId
	) pmdl
	PIVOT
	
	(min([Medication Type]) For Medication
		IN ([1], [2], [3], [4])
  )
  pvtpmdl on pvtpmdl.ID = s.survey5YearsID   
  
--Q36.29 "Toby" has had…
left join referenceLastSurgeryPostMedicationStatus lspms
  on lspms.lastSurgeryPostMedicationStatusId = s.lastSurgeryPostMedicationStatusId
  
--Q36.4 Toby went back to the vet practice for a post-operative check up…
Left join 
	(Select 
		lspc.survey5YearsId ID,
		lastSurgeryPostCheckupName [Checkup Type],
		cast(lspc.lastSurgeryPostCheckupId as varchar) as 'Checkup'

	   from survey5Years_referenceLastSurgeryPostCheckup lspc

	inner join  referenceLastSurgeryPostCheckup reflspc

		on lspc.lastSurgeryPostCheckupId = reflspc.lastSurgeryPostCheckupId
	) lspc
	PIVOT
	
	(min([Checkup Type]) For Checkup
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
  )
  pvtlspc on pvtlspc.ID = s.survey5YearsID 
  
--Q36.5 The surgical wound…
Left join 
	(Select 
		lspw.survey5YearsId ID,
		lastSurgeryPostWoundName [Reaction Type],
		cast(lspw.lastSurgeryPostWoundId as varchar) as 'Reaction'

	   from survey5Years_referenceLastSurgeryPostWound lspw

	inner join  referenceLastSurgeryPostWound reflspw

		on lspw.lastSurgeryPostWoundId = reflspw.lastSurgeryPostWoundId
	) lspw
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14])
  )
  pvtlspw on pvtlspw.ID = s.survey5YearsID 

--Q36.6 Following these problems, to help "Toby"'s wound to heal, a vet/vet nurse…
Left join 
	(Select 
		lspwa.survey5YearsId ID,
		lastSurgeryPostWoundActionName [Action Type],
		cast(lspwa.lastSurgeryPostWoundActionId as varchar) as 'Action'

	   from survey5Years_referenceLastSurgeryPostWoundAction lspwa

	inner join  referenceLastSurgeryPostWoundAction reflspwa

		on lspwa.lastSurgeryPostWoundActionId = reflspwa.lastSurgeryPostWoundActionId
	) lspwa
	PIVOT
	
	(min([Action Type]) For Action
		IN ([1], [2], [3], [4], [5], [6], [7])
  )
  pvtlspwa on pvtlspwa.ID = s.survey5YearsID 
  
--QN3 After "Toby" was neutered (spayed or castrated) he/she wore a/an…
left join referenceNeuterAfterClothingType nact
  on nact.neuterAfterClothingTypeId = s.neuterAfterClothingTypeId
  
--QN5 "Toby"'s surgical wound was closed with…
left join referenceNeuterWoundClosureType nwct
  on nwct.neuterWoundClosureTypeId = s.neuterWoundClosureTypeId
  
--QN5.1 "Toby"'s spay involved removal of her…
left join referenceNeuterSpayType nst
  on nst.neuterSpayTypeId = s.neuterSpayTypeId
  
--QN5.2 "Toby"'s spay was carried out by…
left join referenceNeuterSpaySurgeryType nsst 
  on nsst.neuterSpaySurgeryTypeId = s.neuterSpaySurgeryTypeId
 
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
