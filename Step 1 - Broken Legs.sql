select 
  s.survey5YearsId,
  s.dogId,
  -- Q18 Which of these leg(s) were broken...
  lbl.Limb,
  lbl.[Limb Type],
  -- Q19 "Toby's" leg break(s) occurred because he/she...
  pvtlbr.[1] [Q19: Was involved in a road traffic accident],
  pvtlbr.[2] [Q19: Was accidentally dropped],
  pvtlbr.[3] [Q19: Got his/her leg trapped in a house or car door],
  pvtlbr.[4] [Q19: Fell down steps/stairs],
  pvtlbr.[5] [Q19: Fell off something (for example furniture)],
  pvtlbr.[6] [Q19: Fell (for example slipping on a smooth surface)],
  pvtlbr.[7] [Q19: Fell while getting in or out of the car],
  pvtlbr.[8] [Q19: Was accidentally trodden on by a horse or other large animal],
  pvtlbr.[9] [Q19: Was accidentally trodden on by a person],
  pvtlbr.[10] [Q19: Was playing with another dog],
  pvtlbr.[11] [Q19: Was playing with me],
  pvtlbr.[12] [Q19: Had something accidentally dropped on him/her],
  pvtlbr.[13] [Q19: Was chased or attacked by another dog],
  pvtlbr.[14] [Q19: Other (please specify) ID], 
  olbr.otherLegBrokenReason [Q19: Other (please specify) Desc]
from survey5years s

--Q18 Which of these leg(s) were broken...
Left join 
	(Select 
		lbl.survey5YearsId ID,
		legBrokenLimbTypeName [Limb Type],
		cast(lbl.legBrokenLimbTypeId as varchar) as 'Limb'

	   from survey5Years_referenceLegBrokenLimbType lbl

	inner join  referenceLegBrokenLimbType reflbl

		on lbl.legBrokenLimbTypeId = reflbl.legBrokenLimbTypeId
	) lbl
	
  
  on lbl.ID = s.survey5YearsId
  
-- Q19 "Toby's" leg break(s) occurred because he/she...
 /*--Options--*/
Left join 
	(Select 
		lbr.survey5YearsId ID,
    lbr.legBrokenLimbTypeId LID,
		legBrokenReasonTypeName [Reason Type],
		cast(lbr.legBrokenReasonTypeId as varchar) as 'Reason'

	   from survey5Years_referenceLegBrokenReasonType2 lbr

	inner join  referenceLegBrokenReasonType2 reflbr

		on lbr.legBrokenReasonTypeId = reflbr.legBrokenReasonTypeId
	) lbr
	PIVOT
	
	(min([Reason Type]) For Reason
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14])
	) 
	pvtlbr
  
  on pvtlbr.ID = s.survey5YearsId and pvtlbr.LID =  lbl.Limb
  
/*--Free Text--*/
Left join 
	(Select 
		olbr.survey5YearsId ID,
    olbr.legBrokenLimbTypeId LID,
		olbr.otherLegBrokenReason 

	   from survey5Years_referenceOtherLegBrokenReason olbr

	) olbr
  on  olbr.LID = lbl.Limb and olbr.ID = s.survey5YearsId
  
where lbl.Limb is not null