select 
  s.dogId,
	s.userId ,
	s.survey5YearsId [5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
  --13.3 "Toby" tends to get brushed...
  s.brushingFrequencyId [Brushing Frequency ID],
  bf.brushingFrequencyName [Brushing Frequency Desc],
  s.otherBrushingFrequency [Other (Please Specify)...],
  --13.4 During the last 12 months, "Toby"'s coat has been...
  pvtct.[1] [Clipped (part of his/her body)],
  pvtct.[2] [Clipped (all of his/her body)],
  pvtct.[3] [Stripped (hairs plucked out by hand or by using a stripping knife)],
  pvtct.[4] [Trimmed (for example around the head)],
  pvtct.[5] [None of the above have been carried out],
  pvtct.[6] [Other (please specify) ID],
  s.otherCoatType [Other (please specify) Desc],
  --13.5 During the last 12 months, "Toby" ears have been plucked (hairs pulled out of his/her ears)…
  s.earPluckingId [Ears Plucked Frequency ID],
  ep.earPluckingName [Ears Plucked Frequency Desc],
  --13.6 "Toby"'s ears have been plucked (hairs pulled out of his/her ears) by…
  pvtepb.[1] [A member of my household, friend or relative (who is not a vet, vet nurse or dog groomer)],
  pvtepb.[2] [A member of my household, friend or relative (who is a vet, vet nurse or dog groomer)],
  pvtepb.[3] [A vet (whilst my dog was under anaesthetic)],
  pvtepb.[4] [A vet (whilst my dog was conscious)],
  pvtepb.[5] [A vet nurse],
  pvtepb.[6] [A dog groomer],
  pvtepb.[7] [Other (please specify) ID],
  s.otherEarPluckingBy [Other (please specify) Desc],
  --13.8 During the last three months, "Toby" has...
  pvtlm.[1] [Been groomed by a professional dog groomer],
  pvtlm.[2] [Been walked by a professional dog walker],
  pvtlm.[3] [Been walked by a friend or relative (excluding members of the household)],
  pvtlm.[4] [Been to 'doggy day care'/a dog day-boarder],
  pvtlm.[5] [Stayed with a friend or relative (excluding members of the household) during the day],
  pvtlm.[6] [None of the above],
  --13.9 On an average week, "Toby" is walked by a professional dog walker on…
  s.frequencyDogWalkerId [Weekly Walk Frequency (Professional Walker) ID],
  s.otherFrequencyDogWalker [Weekly Walk Frequency (Professional Walker) Desc],
  --13.9.5 On an average week, "Toby" is walked by a friend or relative (excluding member of the household) on…
  s.frequencyWalkedFriendId [Weekly Walk Frequency (Friend or Relative) ID],
  s.otherFrequencyWalkedFriend [Weekly Walk Frequency (Friend or Relative) Desc],
  --13.10 On an average week, "Toby" goes to 'doggy day care' on…
  s.frequencyDayCareId [Weekly Doggy Daycare Frequency ID],
  s.otherFrequencyDayCare [Weekly Doggy Daycare Frequency Desc],
  --13.10.5 On an average week, "Toby" stays with a friend or relative (exclduing members of the household) during the day on…
  s.frequencyFriendDayCareId [Weekly Day Care w/Friend Frequency ID],
  s.otherFrequencyFriendDayCare [Weekly Day Care w/Friend Frequency Desc],
  --68 During the last three months, "Toby" has stayed overnight...
  pvtos.[1] [In my home with a familiar person (but not a member of the household)],
  pvtos.[2] [In my home, with an unfamiliar person (for example a dog sitter)],
  pvtos.[3] [In the home of somebody my dog is familiar with (for example family or friend)],
  pvtos.[4] [In a boarding kennel],
  pvtos.[5] [At a dog boarder's home],
  pvtos.[6] [At a veterinary practice],
  pvtos.[7] [Not stayed away],
  pvtos.[8] [Other (please specify) ID],
  s.otherOvernghtStaysType [Other (please specify) Desc],
  --69 In total, the number of nights "Toby" has been was separated from me, and all household members (if applicable) during the last three months is…
  s.nightsSeperatedTypeId [Total nights separated in last 3 months ID],
  ns.nightsSeperatedTypeName [Total nights separated in last 3 months Desc],
  --13.11 During the last 12 months, "Toby" has had his/her nails clipped…
  s.frequencyNailsClippedId [Frequency Nails Clipped in Last 3 months ID],
  nc.frequencyNailsClippedName [Frequency Nails Clipped in Last 3 months Desc],
  --13.12 "Toby"'s nails have been clipped by…
  pvtncb.[1] [A member of my household, friend or relative (who is not a vet, vet nurse or dog groomer)],
  pvtncb.[2] [A member of my household, friend or relative (who is a vet, vet nurse or dog groomer)],
  pvtncb.[3] [A vet],
  pvtncb.[4] [A vet nurse],
  pvtncb.[5] [A dog groomer],
  pvtncb.[6] [Other (please specify) ID],
  s.otherNailsClippedBy [Other (please specify) Desc],
  --13.14 "Toby"'s teeth are brushed….
  s.frequencyTeethBrushedId [Frequency teeth brushed ID],
  tb.frequencyTeethBrushedName [Frequency teeth brushed Desc],
  s.otherFrequencyTeethBrushed [Frequency teeth brushed: Other (please specify)],
  --13.16 On an average week, to help reduce dental disease "Toby" is given…
  pvtdpi.[1] [Dental chews (to eat)],
  pvtdpi.[2] [Dental toys to chew on],
  pvtdpi.[3] [Water additives/gel],
  pvtdpi.[4] [A special 'dental' diet],
  pvtdpi.[5] [Biscuits as part of his/her meal(s)],
  pvtdpi.[6] [None of these],
  pvtdpi.[7] [Other (please specify) ID],
  s.otherDentalPreventionItems [Other (please specify) Desc],
  --13.17 Excluding just having his/her paws/legs/tummy washed off after a muddy walk, during the last month "Toby" has been given a full body bath (with/without shampoo)….
  s.frequencyOfWashingId [Frequency of full body wash in last month ID],
  w.frequencyOfWashingName [Frequency of full body wash in last month Desc],
  s.otherFrequencyOfWashing [Frequency of full body wash in last month: Other (please specify)],
  --13.18 "Toby" is usually washed with…
  pvtwp.[1] [Just water],
  pvtwp.[2] [Shampoo for dogs],
  pvtwp.[3] [Shampoo for people],
  pvtwp.[4] [Specific medicated shampoo],
  pvtwp.[5] [Other product used ID],
  s.otherWashingProducts [Other product used Desc],
  s.detailWashingProducts [Other product used Details]
  

from survey5Years s

--13.3 "Toby" tends to get brushed...
left join referenceBrushingFrequency bf 
  on bf.brushingFrequencyId = s.brushingFrequencyId
--13.4 During the last 12 months, "Toby"'s coat has been...
Left join 
	(Select 
		ct.survey5YearsId ID,
		coatTypeName [Coat Type],
		cast(ct.coatTypeId as varchar) as 'Coat'

	from survey5Years_referenceCoatType ct

	inner join referenceCoatType refct

		on ct.coatTypeId = refct.coatTypeId
	) ct
	PIVOT
	
	(min([Coat Type]) For Coat
		IN ([1], [2], [3], [4], [5], [6])
	) 
	pvtct on pvtct.ID = s.survey5yearsID
--13.5 During the last 12 months, "Toby" ears have been plucked (hairs pulled out of his/her ears)…
left join referenceEarPlucking ep
  on ep.earPluckingId = s.earPluckingId
--13.6 "Toby"'s ears have been plucked (hairs pulled out of his/her ears) by…
Left join 
	(Select 
		epb.survey5YearsId ID,
		earPluckingByName [Plucking Type],
		cast(epb.earPluckingById as varchar) as 'Pluck'

	from survey5Years_referenceEarPluckingBy epb

	inner join referenceEarPluckingBy refepb

		on epb.earPluckingById = refepb.earPluckingById
	) epb
	PIVOT
	
	(min([Plucking Type]) For Pluck
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtepb on pvtepb.ID = s.survey5yearsID
--13.8 During the last three months, "Toby" has...
Left join 
	(Select 
		lm.survey5YearsId ID,
		last3MthGroomingName [Activity Type],
		cast(lm.last3MthGroomingId as varchar) as 'Activity'

	from survey5Years_referenceLast3MthGrooming lm

	inner join referenceLast3MthGrooming reflm

		on lm.last3MthGroomingId = reflm.last3MthGroomingId
	) lm
	PIVOT
	
	(min([Activity Type]) For Activity
		IN ([1], [2], [3], [4], [5], [6])
	) 
	pvtlm on pvtlm.ID = s.survey5yearsID
--68 During the last three months, "Toby" has stayed overnight...
Left join 
	(Select 
		os.survey5YearsId ID,
		overnightStaysTypeName [Stay Type],
		cast(os.overnightStaysTypeId as varchar) as 'Stay'

	from survey5Years_referenceOvernightStaysType os

	inner join referenceOvernightStaysType refos

		on os.overnightStaysTypeId = refos.overnightStaysTypeId
	) os
	PIVOT
	
	(min([Stay Type]) For Stay
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtos on pvtos.ID = s.survey5yearsID
--69 In total, the number of nights "Toby" has been was separated from me, and all household members (if applicable) during the last three months is…
left join referenceNightsSeperatedType ns
  on ns.nightsSeperatedTypeId = s.nightsSeperatedTypeId
--13.11 During the last 12 months, "Toby" has had his/her nails clipped…
left join referenceFrequencyNailsClipped nc
  on nc.frequencyNailsClippedId = s.frequencyNailsClippedId
--13.12 "Toby"'s nails have been clipped by…
Left join 
	(Select 
		ncb.survey5YearsId ID,
		nailsClippedByName [Clipper Type],
		cast(ncb.nailsClippedById as varchar) as 'Clipper'

	from survey5Years_referenceNailsClippedBy ncb

	inner join referenceNailsClippedBy refncb

		on ncb.nailsClippedById = refncb.nailsClippedById
	) ncb
	PIVOT
	
	(min([Clipper Type]) For Clipper
		IN ([1], [2], [3], [4], [5], [6])
	) 
	pvtncb on pvtncb.ID = s.survey5yearsID
--13.14 "Toby"'s teeth are brushed….
left join referenceFrequencyTeethBrushed tb
  on tb.frequencyTeethBrushedId = s.frequencyTeethBrushedId
--13.16 On an average week, to help reduce dental disease "Toby" is given…
Left join 
	(Select 
		dpi.survey5YearsId ID,
		dentalPreventionItemsName [Clipper Type],
		cast(dpi.dentalPreventionItemsId as varchar) as 'Clipper'

	from survey5Years_referenceDentalPreventionItems dpi

	inner join referenceDentalPreventionItems refdpi

		on dpi.dentalPreventionItemsId = refdpi.dentalPreventionItemsId
	) dpi
	PIVOT
	
	(min([Clipper Type]) For Clipper
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtdpi on pvtdpi.ID = s.survey5yearsID
--13.17 Excluding just having his/her paws/legs/tummy washed off after a muddy walk, during the last month "Toby" has been given a full body bath (with/without shampoo)….
left join referenceFrequencyOfWashing w
  on w.frequencyOfWashingId = s.frequencyOfWashingId
--13.18 "Toby" is usually washed with…
Left join 
	(Select 
		wp.survey5YearsId ID,
		washingProductsName [Product Type],
		cast(wp.washingProductsId as varchar) as 'Product'

	from survey5Years_referenceWashingProducts wp

	inner join referenceWashingProducts refwp

		on wp.washingProductsId = refwp.washingProductsId
	) wp
	PIVOT
	
	(min([Product Type]) For Product
		IN ([1], [2], [3], [4], [5])
	) 
	pvtwp on pvtwp.ID = s.survey5yearsID
  

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
