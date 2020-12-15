select 
  s.dogId,
	s.userId ,
	s.survey5YearsId [5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
  --Q36 "Toby" has been surgically neutered (spayed or castrated)…
  s.neuterStatus5YearsId [Q36: Neuter Status ID],
  ns5y.neuterStatus5YearsName [Q36: Neuter Status Desc],
  --Q36.a Have you previously given us information about 'Toby's' surgical neutering (spay or castration)?
  s.previousInformationNeuteringSurgicalId [Q36.a: Previous Information On Surgical Neutering ID],
  pin_surg.previousInformationNeuteringName [Q36.a: Previous Information On Surgical Neutering Desc],
  --Q36.b Have you previously given us information about 'Toby's' chemical castration?
  s.previousInformationNeuteringChemicalId [Q36.b: Previous Information On Chemical Neutering ID],
  pin_chem.previousInformationNeuteringName [Q36.b: Previous Information On Chemical Neutering Desc],
  --Q36.001 "Toby" was neutered (spayed or castrated)…
  pvtnr.[1] [Q36.001: Because I didn't want him/her to have puppies],
  pvtnr.[2] [Q36.001: To prevent sexual behaviour in the future],
  pvtnr.[3] [Q36.001: Because he/she had started to show sexual behaviour (mounting/humping)],
  pvtnr.[4] [Q36.001: To prevent unwanted aggressive behaviour in the future],
  pvtnr.[5] [Q36.001: Because he/she had started to show aggressive behaviour],
  pvtnr.[6] [Q36.001: To reduce the risk of future health problems],
  pvtnr.[7] [Q36.001: Because the vet recommended it],
  pvtnr.[8] [Q36.001: Because the breeder insisted],
  pvtnr.[9] [Q36.001: Because the rehoming centre insisted],
  pvtnr.[10] [Q36.001: Other (please specify)],
  s.otherNeuterReason5Years [Q36.001: Other (please specify)],
  --Q36.01 "Toby" was chemically castrated before he was surgically castrated...
  s.chemicalCastrationBeforeSurgicalId [Q36.01: Chemically Castrated Before Surgically Castrated ID],
  ccbs.chemicalCastrationBeforeSurgicalName [Q36.01: Chemically Castrated Before Surgically Castrated Desc],
  --Q36.05 Have "Toby"'s testicles descended?
  s.testiclesDecendedId [Q36.05: Testicles Descended ID],
  td.testiclesDecendedName [Q36.05: Testicles Descended Desc],
  --Q36.06 Have "Toby"'s retained testicles been the main reason, or a contributory reason to him not being neutered yet?
  s.retainedTesticlesForNonNeuterId [Q36.06 Retained Testicles Reason For Not Neutered ID],
  rtnn.retainedTesticlesForNonNeuterName [Q36.06 Retained Testicles Reason For Not Neutered Desc],
  --Q36.07 One or both of "Toby"'s testicles had not descended at the time of his chemical castration…
  s.testiclesNotDecendedAtChemicalCastrationId [Q36.07: One or Both Testicles Not Descended When Chemically Castrated ID],
  tndcc.testiclesNotDecendedAtCastrationName [Q36.07: One or Both Testicles Not Descended When Chemically Castrated Desc],
  --Q1.15 One or both of "Toby"'s testicles had not descended at the time of his surgical castration…
  s.testiclesNotDecendedAtSurgicalCastrationId [Q1.15: One or Both Testicles Not Descended When Surgically Castrated ID],
  tndsc.testiclesNotDecendedAtCastrationName [Q1.15: One or Both Testicles Not Descended When Surgically Castrated Desc],
  --Q1.2 Was/were the undescended testicle(s) removed at the time of surgical castration?
  s.undescendedTesticlesRemovedAtCastrationId [Q1.2 Undescended Testicles Removed at Surgical Castration ID],
  utrac.undescendedTesticlesRemovedAtCastrationName [Q1.2 Undescended Testicles Removed at Surgical Castration Desc],
  --Q1.3 If you have used any non-surgical forms of contraception for "Toby" in the last six months, please provide details here…
  s.nonSurgicalContraceptionDetails [Q1.3: Non-Surgical Contraception Details (Last 6 Months)]
  
from survey5Years s
--Q36 "Toby" has been surgically neutered (spayed or castrated)…
left join referenceneuterstatus5years ns5y
  on ns5y.neuterStatus5YearsId = s.neuterStatus5YearsId
--Q36.a Have you previously given us information about 'Toby's' surgical neutering (spay or castration)?
left join referencePreviousInformationNeutering pin_surg
  on pin_surg.previousInformationNeuteringId = s.previousInformationNeuteringSurgicalId
--Q36.b Have you previously given us information about 'Toby's' chemical castration?
left join referencePreviousInformationNeutering pin_chem
  on pin_chem.previousInformationNeuteringId = s.previousInformationNeuteringChemicalId
--Q36.001 "Toby" was neutered (spayed or castrated)…
Left join 
	(Select 
		nr.survey5YearsId ID,
		neuterReason5YearsName [Reason Type],
		cast(nr.neuterReason5YearsId as varchar) as 'Reason'

	   from survey5Years_referenceNeuterReason5Years nr

	inner join  referenceNeuterReason5Years refnr

		on nr.neuterReason5YearsId = refnr.neuterReason5YearsId
	) nr
	PIVOT
	
	(min([Reason Type]) For Reason
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10])
  )
  pvtnr on pvtnr.ID = s.survey5YearsID 
--Q36.01 "Toby" was chemically castrated before he was surgically castrated...
left join referenceChemicalCastrationBeforeSurgical ccbs
  on ccbs.chemicalCastrationBeforeSurgicalId = s.chemicalCastrationBeforeSurgicalId
--Q36.05 Have "Toby"'s testicles descended?
left join referenceTesticlesDecended td
  on td.testiclesDecendedId = s.testiclesDecendedId
--Q36.06 Have "Toby"'s retained testicles been the main reason, or a contributory reason to him not being neutered yet?
left join referenceRetainedTesticlesForNonNeuter rtnn
  on rtnn.retainedTesticlesForNonNeuterId = s.retainedTesticlesForNonNeuterId
--Q36.07 One or both of "Toby"'s testicles had not descended at the time of his chemical castration…
left join referenceTesticlesNotDecendedAtCastration tndcc
  on tndcc.testiclesNotDecendedAtCastrationId = s.testiclesNotDecendedAtChemicalCastrationId
--Q1.15 One or both of "Toby"'s testicles had not descended at the time of his surgical castration…
left join referenceTesticlesNotDecendedAtCastration tndsc
  on tndsc.testiclesNotDecendedAtCastrationId = s.testiclesNotDecendedAtSurgicalCastrationId 
--Q1.2 Was/were the undescended testicle(s) removed at the time of surgical castration?
left join referenceUndescendedTesticlesRemovedAtCastration utrac
  on utrac.undescendedTesticlesRemovedAtCastrationId = s.undescendedTesticlesRemovedAtCastrationId

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