/****** 5yr Step 8 Training ******/
/**** Last Updated 2020-09-09 by ET *******
*** In progress **** */
select 
	surv.dogId,
	surv.userId,
	surv.survey5YearsId [5yr Survey ID],
	Cast(surv.surveyCreationDate as DATE) [Survey Creation Date],
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
	--tblAbtMe.survey15MonthsPercComplete [% Complete],
	------------------------- Step 8 --------------------------
/*------------ Q50 During the last twelve months I have taken my dog to socialisation/training/obedience classes…  ----------*/
	coalesce(surv.attendedPuppyClassId, '999') [Q50 During the last twelve months I have taken puppy to classes ID],
	refAttendedPuppyClass.attendedPuppyClassName [Q50 During the last twelve months I have taken puppy to classes Desc ],

/*--------Q51 These classes were run by ----------*/
	pvtClsRunBy.[ClassRunBy 1] [Q51- My vet practice],	
	pvtClsRunBy.[ClassRunBy 2] [Q51- Dogs Trust Dog School],	
	pvtClsRunBy.[ClassRunBy 3] [Q51- A dog trainer (excluding Dogs Trust Dog School)],	
	pvtClsRunBy.[ClassRunBy 4] [Q51- A behaviourist (excluding Dogs Trust Dog School)],	
	--pvtClsRunBy.[ClassRunBy 5] [Q51 - Other (please specify)]	
	surv.otherClassRunBy [Q51 Other these classes were run by],

/*--------Q52 When traning my dog, I use the following rewards ----------*/
	pvtTrainRwrd.[TrainingReward 1] [Q52 - Verbal praise ],	
	pvtTrainRwrd.[TrainingReward 2] [Q52 - Physical praise ],	
	pvtTrainRwrd.[TrainingReward 3] [Q52 - A toy],	
	pvtTrainRwrd.[TrainingReward 4] [Q52 - A ball],	
	pvtTrainRwrd.[TrainingReward 5] [Q52 - A clicker],	
	pvtTrainRwrd.[TrainingReward 6] [Q52 - Some of his/her normal dog food],	
	pvtTrainRwrd.[TrainingReward 7] [Q52 - A dog food other than his/her own kibble/biscuit],	
	pvtTrainRwrd.[TrainingReward 8] [Q52 - Dog food treats],	
	pvtTrainRwrd.[TrainingReward 9] [Q52 - Human food ],	
	pvtTrainRwrd.[TrainingReward 10] [Q52 - None/no other rewards are used],	
	pvtTrainRwrd.[TrainingReward 11] [Q52 - Training has not started],	
	pvtTrainRwrd.[TrainingReward 12] [Q52 - He/she is not being trained],	
	--pvtTrainRwrd.[TrainingReward 13] [Q52 - Other (please specify)],	
	surv.otherTrainingRewardType [Q52 Other training reward type],

/*--------Q53 The reward I most often use when training my dog is ----------*/
	surv.mostUsedTrainingReward [Q53 Reward I most often use when training my puppy],

/*--------Q54 When correcting my dog for doing something wrong, I would.. ----------*/
	pvtTrnCorct.[TrainCorrection 1] [Q54 - Tell him/her off],	
	pvtTrnCorct.[TrainCorrection 2] [Q54 - Use a physical reprimand/correction (for example smack or tap him/her on nose or bottom)],	
	pvtTrnCorct.[TrainCorrection 3] [Q54 - Make a distraction (for example rattle can/loud noise/water spray)],	
	pvtTrnCorct.[TrainCorrection 4] [Q54 - Move away or withhold affection],	
	pvtTrnCorct.[TrainCorrection 5] [Q54 - Withhold treats],	
	pvtTrnCorct.[TrainCorrection 6] [Q54 - Ignore him/her],	
	pvtTrnCorct.[TrainCorrection 7] [Q54 - Use physical manipulation (for example putting him/her into a sit or pushing him/her off if he/she jumps up)],	
	pvtTrnCorct.[TrainCorrection 8] [Q54 - Hold him/her still],	
	pvtTrnCorct.[TrainCorrection 9] [Q54 - I don't use anything],	
	surv.otherTrainingCorrectionType [Q54 Other Training Correction Type],

--/*--------Q55 The correction I use most often when my puppy does something wrong is ----------*/
	surv.mostUsedTrainingCorrection [Q55 Correction I most often use when puppy does wrong],

/*--------Q56 My do will now…. ----------*/
	/* ----pvtCurntObdnce.[CurrentObedience 1] [Q56 - Walk on a loose lead without pulling],	
	pvtCurntObdnce.[CurrentObedience 2] [Q56 - Walk to heel or close to my leg without a lead],	
	pvtCurntObdnce.[CurrentObedience 3] [Q56 - Wait before taking food or a treat],	
	pvtCurntObdnce.[CurrentObedience 4] [Q56 - Take a toy gently],	
	pvtCurntObdnce.[CurrentObedience 5] [Q56 - Drop a toy or other item when asked],	
	pvtCurntObdnce.[CurrentObedience 6] [Q56 - Sit when asked],	
	pvtCurntObdnce.[CurrentObedience 7] [Q56 - Wait when asked],	
	pvtCurntObdnce.[CurrentObedience 8] [Q56 - Lie down when asked],	
	pvtCurntObdnce.[CurrentObedience 9] [Q56 - Come back when called],	
	pvtCurntObdnce.[CurrentObedience 10] [Q56 - Leave an item when asked],	
	pvtCurntObdnce.[CurrentObedience 11] [Q56 - Travel quietly in a vehicle],	
	pvtCurntObdnce.[CurrentObedience 12] [Q56 - Be calm when picked up],	
	pvtCurntObdnce.[CurrentObedience 13] [Q56 - Be calm when having his/her paws cleaned/dried],	
	pvtCurntObdnce.[CurrentObedience 14] [Q56 - Be calm when having his/her nails clipped],	
	pvtCurntObdnce.[CurrentObedience 15] [Q56 - Be calm when being brushed/groomed],	
	pvtCurntObdnce.[CurrentObedience 16] [Q56 - Be calm when having his/her collar on],	
	pvtCurntObdnce.[CurrentObedience 17] [Q56 - Be calm when having his/her lead attached],	
	pvtCurntObdnce.[CurrentObedience 18] [Q56 - Not go on the furniture],	
	pvtCurntObdnce.[CurrentObedience 19] [Q56 - Get off the furniture when asked if he/she is allowed on furniture],	
	pvtCurntObdnce.[CurrentObedience 20] [Q56 - Go to his/her bed when asked],
	--surv.other [Q56 - Other current obedience type],-----*/

/*-------- question 57 -------*/
obLooseLead.freqID [Q56 - Loose lead freq ID],
obLooseLead.freqType [Q56 - Loose lead freq Desc],
obHeel.freqID [Q56 - Heel walk freq ID],
obHeel.freqType [Q56 - Heel walk freq Desc],
obWaitBefore.freqID [Q56 - Wait before Treat freq ID],
obWaitBefore.freqType [Q56 - Wait before Treat freq Desc],
obTakeToy.freqID [Q56 - Take Toy Gently freq ID],
obTakeToy.freqType [Q56 - Take Toy Gently freq Desc],
obDropToy.freqID [Q56 - Drop Toy When Asked freq ID],
obDropToy.freqType [Q56 - Drop Toy When Asked freq Desc],
obSit.freqID [Q56 - Sit When Asked freq ID],
obSit.freqType [Q56 - Sit When Asked freq Desc],
obWaitAT.freqID [Q56 - Wait At(door/pavement) When Asked freq ID],
obWaitAt.freqType [Q56 - Wait At(door/pavement) When Asked freq Desc],
obLieDown.freqID [Q56 - Lie Down When Asked freq ID],
obLieDown.freqType [Q56 - Lie Down When Asked freq Desc],
obComeBack.freqID [Q56 - Come Back When Called freq ID],
obComeBack.freqType [Q56 - Come Back When Called freq Desc],
obLeaveItem.freqID [Q56 - Leave Item When Asked freq ID],
obLeaveItem.freqType [Q56 - Leave Item When Asked freq Desc],
obTravelQuiet.freqID [Q56 - Travel Quietly in Vehicle freq ID],
obTravelQuiet.freqType [Q56 - Travel Quietly in Vehicle freq Desc],
obCalmPickedUp.freqID [Q56 - Be Calm When Picked Up freq ID],
obCalmPickedUp.freqType [Q56 - Be Calm When Picked Up freq Desc],
obCalmPawClean.freqID [Q56 - Be Calm When Having Paw Clean freq ID],
obCalmPawClean.freqType [Q56 - Be Calm When Having Paw Clean freq Desc],
obNailClip.freqID [Q56 - Be Calm When Having Nails Clipped freq ID],
obNailClip.freqType [Q56 - Be Calm When Having Nails Clipped freq Desc],
obBrushed.freqID [Q56 - Be Calm When being brushed freq ID],
obBrushed.freqType [Q56 - Be Calm When being brushed freq Desc],
obCollarOn.freqID [Q56 - Be Calm When Having Collar On freq ID],
obCollarOn.freqType [Q56 - Be Calm When Having Collar On freq Desc],
obLeadAttach.freqID [Q56 - Be Calm When Having Lead Attached freq ID],
obLeadAttach.freqType [Q56 - Be Calm When Having Lead Attached freq Desc],

/*--------Q58 When training my dog to sit when asked I usually----------*/
pvtTrnToSit.[TrainingToSit 1] [Q58 - Guide my puppy's bottom to the ground using pressure from my hand  ],	
pvtTrnToSit.[TrainingToSit 2] [Q58 - Raise a treat over his/her head  ],	
pvtTrnToSit.[TrainingToSit 3] [Q58 - Put pressure on his/her collar/lead  ],	
pvtTrnToSit.[TrainingToSit 4] [Q58 - Use a hand signal without a treat in my hand],	
pvtTrnToSit.[TrainingToSit 5] [Q58 - Use a hand signal with a treat in my hand],	
pvtTrnToSit.[TrainingToSit 6] [Q58 - Encourage my puppy to move backwards until he/she sits],	
--pvtTrnToSit.[TrainingToSit 7] [Q58 - (TrainingToSit) - Other (please specify)],	
surv.otherWhenTrainingToSitDetail [Q58 Other train my dog to sit when asked ],

/*-------- Q59 When training my dog not to pull on the lead when walking, the following techniques are used...----------*/
pvtTrnNopull.[TrainNotToPullLead 1] [Q59 - Rewarding my dog with verbal praise when he/she is walking next to my heel  ],	
pvtTrnNopull.[TrainNotToPullLead 2] [Q59 - Rewarding my dog with food when he/she is walking next to my heel  ],	
pvtTrnNopull.[TrainNotToPullLead 3] [Q59 - Rewarding my dog with a toy when he/she is walking next to my heel  ],	
pvtTrnNopull.[TrainNotToPullLead 4] [Q59 - Pulling my dog back when he/she is pulling  ],	
pvtTrnNopull.[TrainNotToPullLead 5] [Q59 - Stopping walking when my dog is pulling  ],	
pvtTrnNopull.[TrainNotToPullLead 6] [Q59 - A short, sharp tug on the lead when my dog is pulling  ],	
pvtTrnNopull.[TrainNotToPullLead 7] [Q59 - Telling my dog off when he/she is pulling  ],	
pvtTrnNopull.[TrainNotToPullLead 8] [Q59 - Using a sound distractor/noise maker when he/she is pulling  ],	
pvtTrnNopull.[TrainNotToPullLead 9] [Q59 - Rewarding my dog with verbal praise when the lead is slack/loose  ],	
pvtTrnNopull.[TrainNotToPullLead 10] [Q59 - Rewarding my dog with food when the lead is slack/loose  ],	
pvtTrnNopull.[TrainNotToPullLead 11] [Q59 - Rewarding my dog with a toy when the lead is slack/loose  ],	
--pvtTrnNopull.[TrainNotToPullLead 12] [Q59 - (TrainNotToPulLead) - Other (please specify)],
surv.otherWhenTrainingNotToPullOnLeadDetail [Q59 Other train not to pull on lead when walking], --double check this 

/*-------- Q60 When training my dog not to pull on the lead when walking, the following items are used...*/
pvtTraiNotToPulItm.[TrainNotToPullLeadItem 1] [Q60 - Flat/regular collar],	
pvtTraiNotToPulItm.[TrainNotToPullLeadItem 2] [Q60 - Half-check collar or chain],	
pvtTraiNotToPulItm.[TrainNotToPullLeadItem 3] [Q60 - Choke chain],	
pvtTraiNotToPulItm.[TrainNotToPullLeadItem 4] [Q60 - Head collar],	
pvtTraiNotToPulItm.[TrainNotToPullLeadItem 5] [Q60 - Back fitting harness],	
pvtTraiNotToPulItm.[TrainNotToPullLeadItem 6] [Q60 - Front fitting harness],	
pvtTraiNotToPulItm.[TrainNotToPullLeadItem 7] [Q60 - Flexi/extendable lead],	
pvtTraiNotToPulItm.[TrainNotToPullLeadItem 8] [Q60 - Long training line],	
--pvtTraiNotToPulItm.[TrainNotToPullLeadItem 9] [Q60 - (TrainNotToPullLeadItem) - Other (please specify)]
surv.otherWhenTrainingNotToPullOnLeadItemsDetail [Q60 Other when training not to pull],

/*-------- Q61 To attract my dog's attention when training him/her to come back when called, I...*/
pvtTraToComBck.[TrainToComeBack 1] [Q61 - Blow a whistle  ],	
pvtTraToComBck.[TrainToComeBack 2] [Q61 - Call his/her name],	
pvtTraToComBck.[TrainToComeBack 3] [Q61 - Wave one or both arms at him/her],	
pvtTraToComBck.[TrainToComeBack 4] [Q61 - Use a vibrating collar],	
pvtTraToComBck.[TrainToComeBack 5] [Q61 - Use a sound collar],	
pvtTraToComBck.[TrainToComeBack 6] [Q61 - Use an electronic collar],	
pvtTraToComBck.[TrainToComeBack 7] [Q61 - Use a command (for example 'come')],	
pvtTraToComBck.[TrainToComeBack 8] [Q61 - Use his/her toy(s)],	
pvtTraToComBck.[TrainToComeBack 9] [Q61 - Use a long lead/long line/retractable lead],	
--pvtTraToComBck.[TrainToComeBack 10] [Q61 - (TrainToComeBackWhenCalled) - Other (please specify)],
surv.trainingToComeBackWhenCalledDetail [Q61 Other attract attention when training to come back],

/*-------- Q62 If my dog comes back when asked, I usually... */
pvtRewrWhenComBck.[RewardWhenComesBack 1] [Q62 - Reward him/her with verbal praise  ],	
pvtRewrWhenComBck.[RewardWhenComesBack 2] [Q62 - Reward him/her with a food treat  ],	
pvtRewrWhenComBck.[RewardWhenComesBack 3] [Q62 - Reward him/her with their toy  ],	
pvtRewrWhenComBck.[RewardWhenComesBack 4] [Q62 - Reward him/her with a pat/rub/stroke  ],	
--pvtRewrWhenComBck.[RewardWhenComesBack 5] [Q62 - Other (please specify)],
surv.otherRewardWhenComesBackDetail [Q62 Other reward when comes back detail],

/*-------- Q63 If my dog does not come back when asked, I… */
pvtAttWhenComBck.[AttentionWhenComesBack 1] [Q63 - Tell him/her off verbally  ],	
pvtAttWhenComBck.[AttentionWhenComesBack 2] [Q63 - Tell him/her off with a physical reprimand when caught (eg smack on the nose or bottom)  ],	
pvtAttWhenComBck.[AttentionWhenComesBack 3] [Q63 - Go and fetch him/her  ],	
pvtAttWhenComBck.[AttentionWhenComesBack 4] [Q63 - Move in the opposite direction to gain his/her attention  ],	
pvtAttWhenComBck.[AttentionWhenComesBack 5] [Q63 - Hide or move out of sight  ],	
pvtAttWhenComBck.[AttentionWhenComesBack 6] [Q63 - Ignore him/her  ],	
pvtAttWhenComBck.[AttentionWhenComesBack 7] [Q63 - Reward him/her when he/she does come back  ],	
pvtAttWhenComBck.[AttentionWhenComesBack 8] [Q63 - Reward him/her when he/she does come back but with a lesser reward  ],	
pvtAttWhenComBck.[AttentionWhenComesBack 9] [Q63 - Use a long lead/long line/retractable lead  ],	
--pvtAttWhenComBck.[AttentionWhenComesBack 10] [Q63 - Other (please specify)  ],
surv.otherAttractAttentionWhenComesBackDetail [Q63 Other attract attention when comes back],

/*-------- Q64(a) My dog's response to training while at home can be described as… */
pvtResToTrnAtHmn.[ResponseToTrainAtHome 1] [Q64(a) - He/she appears to be interested in training  ],	
pvtResToTrnAtHmn.[ResponseToTrainAtHome 2] [Q64(a) - He/she is difficult to get interested in training  ],	
pvtResToTrnAtHmn.[ResponseToTrainAtHome 3] [Q64(a) - He/she finds it difficult to learn new things  ],	
pvtResToTrnAtHmn.[ResponseToTrainAtHome 4] [Q64(a) - He/she is easily distracted by other things  ],	
pvtResToTrnAtHmn.[ResponseToTrainAtHome 5] [Q64(a) - He/she picks up new training quickly  ],	
pvtResToTrnAtHmn.[ResponseToTrainAtHome 6] [Q64(a) - He/she seems over-excited],	
pvtResToTrnAtHmn.[ResponseToTrainAtHome 7] [Q64(a) - He/she seems to shy away, cower, avoid eye-contact],	
--pvtResToTrnAtHmn.[ResponseToTrainAtHome 8] [Q64(a) - Other (please specify)],	
surv.otherResponseToTrainingAtHomeDetail [Q64(a) Other response to training at home],

/*-------- Q64(b) My dog's response to training while NOT at home can be described as… */
pvtResToTrnNotAtHmn.[ResponseToTrainNotAtHome 1] [Q64(b) - He/she appears to be interested in training  ],	
pvtResToTrnNotAtHmn.[ResponseToTrainNotAtHome 2] [Q64(b) - He/she is difficult to get interested in training  ],	
pvtResToTrnNotAtHmn.[ResponseToTrainNotAtHome 3] [Q64(b) - He/she finds it difficult to learn new things  ],	
pvtResToTrnNotAtHmn.[ResponseToTrainNotAtHome 4] [Q64(b) - He/she is easily distracted by other things  ],	
pvtResToTrnNotAtHmn.[ResponseToTrainNotAtHome 5] [Q64(b) - He/she picks up new training quickly  ],	
pvtResToTrnNotAtHmn.[ResponseToTrainNotAtHome 6] [Q64(b) - He/she seems over-excited],	
pvtResToTrnNotAtHmn.[ResponseToTrainNotAtHome 7] [Q64(b) - He/she seems to shy away, cower, avoid eye-contact],	
--pvtResToTrnNotAtHmn.[ResponseToTrainNotAtHome 8] [Q64(b) - Other (please specify)],
surv.otherResponseToTrainingNotAtHomeDetail [Q64(b) Other response to training while not at home],

/*-------- Q65 My dog's toilet-training is… */
refToiletTrainingStatus.toiletTrainingStatusId [Q65 - Toilet Training Status ID],
reftoiletTrainingStatus.toiletTrainingStatusName [Q65 - Toilet Training Status Desc],

/*-------- Q66 During the last three months, I have noticed that my dog leaks urine, or appears to urinate without being aware of it…… */
pvtLeaksUrn.[LeaksUrine 1] [Q66a- Never],	
pvtLeaksUrn.[LeaksUrine 2] [Q66a- When he/she is excited ],	
pvtLeaksUrn.[LeaksUrine 3] [Q66a- When he/she appears to be worried],	
pvtLeaksUrn.[LeaksUrine 4] [Q66a- When he/she is lying down],	
--pvtLeaksUrn.[LeaksUrine 5] [Q66 (LeaksUrine) - Other (please specify)],	
surv.otherIncontinenceType [Q66a Other response to leaks urine],

/*-------- Q67 My dog's urinary incontinence (involuntary loss of urine) started… */
pvtUrnLeakStrt.[UrineLeaksStarted 1] [Q67a - When he/she was a puppy],	
pvtUrnLeakStrt.[UrineLeaksStarted 2] [Q67a - After he/she was neutered],	
pvtUrnLeakStrt.[UrineLeaksStarted 3] [Q67a - For no obvious reason],	
--pvtUrnLeakStrt.[UrineLeaksStarted 4] [Q67 (UrineLeakStarted) - Other (please specify)],	
surv.otherIncontinenceSinceType [Q67a Other noticed incontinence ],

/*--- Q67 My dog's faecal incontinence (involuntary loss of poo/faeces) started… ----*/
pvtFcalInconStrt.[FeaclInconStarted 1] [Q67b - When he/she was a puppy],	
pvtFcalInconStrt.[FeaclInconStarted 2] [Q67b - After he/she was neutered],	
pvtFcalInconStrt.[FeaclInconStarted 3] [Q67b - For no obvious reason],	
--pvtFcalInconStrt.[FeaclInconStarted 4] [Q67ii - Other (please specify)],	
surv.otherFaecalIncontinenceStartedName [Q67b Other feacal incontinence ]


from survey5Years surv
	------------------------- Step 8 --------------------------
/*------------ Q50 During the last twelve months I have taken "Toby" to socialisation/training/obedience classes…  ----------*/

left join referenceAttendedPuppyClass refAttendedPuppyClass
	on refAttendedPuppyClass.attendedPuppyClassId = surv.attendedPuppyClassId

/*--------Q51 These classes were run by ----------*/
Left join 
	(Select 
		ClsRunBy.survey5YearsId ID,
		classRunByName [ClassRunBy Type],
		'ClassRunBy ' + cast(ClsRunBy.classRunById as varchar) as 'ClassRunBy'

	from survey5Years_referenceClassRunBy  ClsRunBy

	inner join referenceClassRunBy refClsRunBy

		on refClsRunBy.classRunById = ClsRunBy.classRunById
	) ClsRunBy
	PIVOT
	(min([ClassRunBy Type]) For ClassRunBy
		IN ([ClassRunBy 1], [ClassRunBy 2], [ClassRunBy 3], [ClassRunBy 4], [ClassRunBy 5])
	) 
	pvtClsRunBy  on pvtClsRunBy.ID = surv.survey5YearsId 

/*--------Q52 When traning my puppy, I use the following rewards ----------*/
Left join 
	(Select 
		TrainRwrd.survey5YearsId ID,
		trainingRewardTypeName [TrainingReward Type],
		'TrainingReward ' + cast(TrainRwrd.trainingRewardTypeId as varchar) as 'TrainingReward'

	from survey5Years_referenceTrainingRewardType  TrainRwrd

	inner join referenceTrainingRewardType2 refTrainRwrd

		on refTrainRwrd.trainingRewardTypeId = TrainRwrd.trainingRewardTypeId
	) TrainRwrd
	PIVOT
	(min([TrainingReward Type]) For TrainingReward
		IN ([TrainingReward 1], [TrainingReward 2], [TrainingReward 3], [TrainingReward 4], [TrainingReward 5], [TrainingReward 6], [TrainingReward 7], [TrainingReward 8],
			[TrainingReward 9], [TrainingReward 10], [TrainingReward 11], [TrainingReward 12], [TrainingReward 13])
	) 
	pvtTrainRwrd  on pvtTrainRwrd.ID = surv.survey5YearsId

/*--------Q54 When correcting my puppy for doing something wrong, I would.. ----------*/
Left join 
	(Select 
		TrnCorct.survey5YearsId ID,
		trainingCorrectionTypeName [TrainCorrection Type],
		'TrainCorrection ' + cast(TrnCorct.trainingCorrectionTypeId as varchar) as 'TrainCorrection'

	from survey5Years_referenceTrainingCorrectionType  TrnCorct

	inner join referenceTrainingCorrectionType refTrnCorct

		on refTrnCorct.trainingCorrectionTypeId = TrnCorct.trainingCorrectionTypeId
	) TrnCorct
	PIVOT
	(min([TrainCorrection Type]) For TrainCorrection
		IN ([TrainCorrection 1], [TrainCorrection 2], [TrainCorrection 3], [TrainCorrection 4], [TrainCorrection 5], [TrainCorrection 6], [TrainCorrection 7], [TrainCorrection 8],
			[TrainCorrection 9])
	) 
	pvtTrnCorct  on pvtTrnCorct.ID = surv.survey5YearsId 

/*--------Q56 My dog will now…. ----------*/
/*---Left join 
	(Select 
		CurntObdnce.survey5YearsId ID,
		currentObedienceTypeName [CurrentObedience Type],
		'CurrentObedience ' + cast(CurntObdnce.currentObedienceTypeId as varchar) as 'CurrentObedience'

	from survey5Years_referenceCurrentObedienceType  CurntObdnce

	inner join referenceCurrentObedienceType refCurntObdnce

		on refCurntObdnce.currentObedienceTypeId = CurntObdnce.currentObedienceTypeId	
	) CurntObdnce
	PIVOT
	(min([CurrentObedience Type]) For CurrentObedience
		IN ([CurrentObedience 1], [CurrentObedience 2], [CurrentObedience 3], [CurrentObedience 4], [CurrentObedience 5], [CurrentObedience 6], [CurrentObedience 7],
			[CurrentObedience 8], [CurrentObedience 9], [CurrentObedience 10], [CurrentObedience 11], [CurrentObedience 12], [CurrentObedience 13], [CurrentObedience 14],
			[CurrentObedience 15], [CurrentObedience 16], [CurrentObedience 17], [CurrentObedience 18], [CurrentObedience 19], [CurrentObedience 20])
	) 
	pvtCurntObdnce  on pvtCurntObdnce.ID = surv.survey5YearsId---*/

/*-------- question 57(a) ----------*/
left join
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 1

	inner join referenceFrequencyOfObedienceType freqOb

	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obLooseLead on obLooseLead.ID = surv.survey5YearsId

/*-------- question 57(b) ----------*/
left join 
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 2
	inner join referenceFrequencyOfObedienceType freqOb
	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obHeel on obHeel.ID = surv.survey5YearsId

 /*-------- question 57(c) ----------*/
left join
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 3

	inner join referenceFrequencyOfObedienceType freqOb

	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obWaitBefore on obWaitBefore.ID = surv.survey5YearsId

 /*-------- question 57(d) ----------*/
left join
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 4
	inner join referenceFrequencyOfObedienceType freqOb
	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obTakeToy on obTakeToy.ID = surv.survey5YearsId

 /*-------- question 57(e) ----------*/
left join
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 5
	inner join referenceFrequencyOfObedienceType freqOb
	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obDropToy on obDropToy.ID = surv.survey5YearsId

 /*-------- question 57(f) ----------*/
left join 
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 6
	inner join referenceFrequencyOfObedienceType freqOb
	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obSit on obSit.ID = surv.survey5YearsId

 /*-------- question 57(g) ----------*/
left join
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 7
	inner join referenceFrequencyOfObedienceType freqOb
	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obWaitAt on obWaitAt.ID = surv.survey5YearsId

 /*-------- question 57(h) ----------*/
left join
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 8
	inner join referenceFrequencyOfObedienceType freqOb
	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obLieDown on obLieDown.ID = surv.survey5YearsId

 /*-------- question 57(i) ----------*/
left join
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 9
	inner join referenceFrequencyOfObedienceType freqOb
	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obComeBack on obComeBack.ID = surv.survey5YearsId

 /*-------- question 57(j) ----------*/
left join
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 10
	inner join referenceFrequencyOfObedienceType freqOb
	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obLeaveItem on obLeaveItem.ID = surv.survey5YearsId

 /*-------- question 57(k) ----------*/
left join 
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 11
	inner join referenceFrequencyOfObedienceType freqOb
	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obTravelQuiet on obTravelQuiet.ID = surv.survey5YearsId

 /*-------- question 57(l) ----------*/
left join
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 12
	inner join referenceFrequencyOfObedienceType freqOb
	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obCalmPickedUp on obCalmPickedUp.ID = surv.survey5YearsId

 /*-------- question 57(m) ----------*/
left join
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 13
	inner join referenceFrequencyOfObedienceType freqOb
	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obCalmPawClean on obCalmPawClean.ID = surv.survey5YearsId

 /*-------- question 57(n) ----------*/
left join
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 14
	inner join referenceFrequencyOfObedienceType freqOb
	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obNailClip on obNailClip.ID = surv.survey5YearsId

 /*-------- question 57(o) ----------*/
left join
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 15
	inner join referenceFrequencyOfObedienceType freqOb
	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obBrushed on obBrushed.ID = surv.survey5YearsId

 /*-------- question 57(p) ----------*/
left join
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 16
	inner join referenceFrequencyOfObedienceType freqOb
	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obCollarOn on obCollarOn.ID = surv.survey5YearsId

 /*-------- question 57(q) ----------*/
left join 
(Select
	refTbl.survey12MonthsId ID,
	obType.currentObedienceTypeName ObType,
	freqOb.frequencyOfObedienceTypeId freqID,
	freqOb.frequencyOfObedienceTypeName freqType

	from  survey12Months_referenceCurrentObedienceType refTbl

	inner join referenceCurrentObedienceType obType

	on refTbl.currentObedienceTypeId = obType.currentObedienceTypeId and obType.currentObedienceTypeId = 17
	inner join referenceFrequencyOfObedienceType freqOb
	on freqOb.frequencyOfObedienceTypeId = refTbl.frequencyOfObedienceTypeId
) obLeadAttach on obLeadAttach.ID = surv.survey5YearsId

/*-------- Q58 When training my dog to sit when asked I usually----------*/
Left join 
	(Select 
		TrnToSit.survey5YearsId ID,
		whenTrainingToSitTypeName [TrainingToSit Type],
		'TrainingToSit ' + cast(TrnToSit.whenTrainingToSitTypeId as varchar) as 'TrainingToSit'

	from survey5Years_referenceWhenTrainingToSitType TrnToSit

	inner join referenceWhenTrainingToSitType  refTrnToSit 

		on refTrnToSit.whenTrainingToSitTypeId = TrnToSit.whenTrainingToSitTypeId
	) TrnToSit  
	PIVOT
	(min([TrainingToSit Type]) For TrainingToSit
		IN ([TrainingToSit 1], [TrainingToSit 2], [TrainingToSit 3], [TrainingToSit 4], [TrainingToSit 5], [TrainingToSit 6], [TrainingToSit 7])
	) 
	pvtTrnToSit on pvtTrnToSit.ID = surv.survey5YearsId

/*-------- Q59 When training "Toby" not to pull on the lead when walking, the following techniques are used...----------*/
Left join 
	(Select 
		TrnNopull.survey5YearsId ID,
		trainingNotToPullOnLeadName [TrainNotToPullLead Type],
		'TrainNotToPullLead ' + cast(TrnNopull.trainingNotToPullOnLeadId as varchar) as 'TrainNotToPullLead'

	from survey5Years_referenceTrainingNotToPullOnLead TrnNopull

	inner join referenceTrainingNotToPullOnLead  refTrnNopull 

		on refTrnNopull.trainingNotToPullOnLeadId = TrnNopull.trainingNotToPullOnLeadId
	) TrnNopull  
	PIVOT
	(min([TrainNotToPullLead Type]) For TrainNotToPullLead
		IN ([TrainNotToPullLead 1], [TrainNotToPullLead 2], [TrainNotToPullLead 3], [TrainNotToPullLead 4], [TrainNotToPullLead 5], [TrainNotToPullLead 6], [TrainNotToPullLead 7], [TrainNotToPullLead 8], [TrainNotToPullLead 9],
			[TrainNotToPullLead 10], [TrainNotToPullLead 11], [TrainNotToPullLead 12])
	)
	pvtTrnNopull on pvtTrnNopull.ID = surv.survey5YearsId

/*-------- Q60 When training "Toby" not to pull on the lead when walking, the following items are used...*/
Left join 
	(Select 
		TraiNotToPulItm.survey5YearsId ID,
		whenTrainingNotToPullOnLeadItemName [TrainNotToPullLeadItem Type],
		'TrainNotToPullLeadItem ' + cast(TraiNotToPulItm.whenTrainingNotToPullOnLeadItemsId as varchar) as 'TrainNotToPullLeadItem'

	from survey5Years_referenceWhenTrainingNotToPullOnLeadItems TraiNotToPulItm

	inner join referenceWhenTrainingNotToPullOnLeadItem refTraiNotToPulItm

		on refTraiNotToPulItm.whenTrainingNotToPullOnLeadItemId = TraiNotToPulItm.whenTrainingNotToPullOnLeadItemsId
	) TraiNotToPulItm
	PIVOT
	(min([TrainNotToPullLeadItem Type]) For TrainNotToPullLeadItem
		IN ([TrainNotToPullLeadItem 1], [TrainNotToPullLeadItem 2], [TrainNotToPullLeadItem 3], [TrainNotToPullLeadItem 4], [TrainNotToPullLeadItem 5], [TrainNotToPullLeadItem 6], [TrainNotToPullLeadItem 7],
			[TrainNotToPullLeadItem 8], [TrainNotToPullLeadItem 9])
	) 
	pvtTraiNotToPulItm on pvtTraiNotToPulItm.ID = surv.survey5YearsId


/*-------- Q61 To attract my dog's attention when training him/her to come back when called, I...*/
Left join 
	(Select 
		TraToComBck.survey5YearsId ID,
		toComeBackWhenCalledName [TrainToComeBack Type],
		'TrainToComeBack ' + cast(TraToCombck.toComeBackWhenCalledId as varchar) as 'TrainToComeBack'

	from survey5Years_referenceToComeBackWhenCalled TraToComBck 

	inner join referenceToComeBackWhenCalled  refTraToComBck

		on refTraToComBck.toComeBackWhenCalledId = TraToCombck.toComeBackWhenCalledId
	) TraToComBck
	PIVOT
	(min([TrainToComeBack Type]) For TrainToComeBack
		IN ([TrainToComeBack 1], [TrainToComeBack 2], [TrainToComeBack 3], [TrainToComeBack 4], [TrainToComeBack 5], [TrainToComeBack 6], [TrainToComeBack 7], [TrainToComeBack 8], [TrainToComeBack 9], 
			[TrainToComeBack 10])
	) 
	pvtTraToComBck on pvtTraToComBck.ID = surv.survey5YearsId

/*-------- Q62 If my dog comes back when asked, I usually... */
Left join 
	(Select 
		RewrWhenComBck.survey5YearsId ID,
		rewardWhenComesBackName [RewardWhenComesBack Type],
		'RewardWhenComesBack ' + cast(RewrWhenComBck.rewardWhenComesBackId as varchar) as 'RewardWhenComesBack'

	from survey5Years_referenceRewardWhenComesBack RewrWhenComBck 

	inner join referenceRewardWhenComesBack  refRewrWhenComBck

		on refRewrWhenComBck.rewardWhenComesBackId = RewrWhenComBck.rewardWhenComesBackId
	) RewrWhenComBck
	PIVOT
	(min([RewardWhenComesBack Type]) For RewardWhenComesBack
		IN ([RewardWhenComesBack 1], [RewardWhenComesBack 2], [RewardWhenComesBack 3], [RewardWhenComesBack 4], [RewardWhenComesBack 5])
	) 
	pvtRewrWhenComBck on pvtRewrWhenComBck.ID = surv.survey5YearsId

/*-------- Q63 If my dog does not come back when asked, I… */
Left join 
	(Select 
		AttWhenComBck.survey5YearsId ID,
		attractAttentionWhenComesBackName [AttentionWhenComesBack Type],
		'AttentionWhenComesBack ' + cast(AttWhenComBck.attractAttentionWhenComesBackId as varchar) as 'AttentionWhenComesBack'

	from survey5Years_referenceAttractAttentionWhenComesBack AttWhenComBck 

	inner join referenceAttractAttentionWhenComesBack  refAttWhenComBck

		on refAttWhenComBck.attractAttentionWhenComesBackId = AttWhenComBck.attractAttentionWhenComesBackId
	) AttWhenComBck
	PIVOT
	(min([AttentionWhenComesBack Type]) For AttentionWhenComesBack
		IN ([AttentionWhenComesBack 1], [AttentionWhenComesBack 2], [AttentionWhenComesBack 3], [AttentionWhenComesBack 4], [AttentionWhenComesBack 5], [AttentionWhenComesBack 6], [AttentionWhenComesBack 7],
			[AttentionWhenComesBack 8], [AttentionWhenComesBack 9], [AttentionWhenComesBack 10])
	) 
	pvtAttWhenComBck on pvtAttWhenComBck.ID = surv.survey5YearsId

/*-------- Q64(a) My dog's response to training while at home can be described as… */
Left join 
	(Select 
		ResToTrnAtHmn.survey12MonthsId ID,
		responseToTrainingName [ResponseToTrainAtHome Type],
		'ResponseToTrainAtHome ' + cast(ResToTrnAtHmn.responseToTrainingAtHomeId as varchar) as 'ResponseToTrainAtHome'

	from survey12Months_referenceResponseToTrainingAtHome ResToTrnAtHmn 

	inner join referenceResponseToTraining  refResToTrnAtHmn

		on refResToTrnAtHmn.responseToTrainingId = ResToTrnAtHmn.responseToTrainingAtHomeId
	) ResToTrnAtHmn 
	PIVOT
	(min([ResponseToTrainAtHome Type]) For ResponseToTrainAtHome
		IN ([ResponseToTrainAtHome 1], [ResponseToTrainAtHome 2], [ResponseToTrainAtHome 3], [ResponseToTrainAtHome 4], [ResponseToTrainAtHome 5], [ResponseToTrainAtHome 6], [ResponseToTrainAtHome 7],
			[ResponseToTrainAtHome 8])
	) 
	pvtResToTrnAtHmn  on pvtResToTrnAtHmn.ID = surv.survey5YearsId

/*-------- Q64(b) My dog's response to training while NOT at home can be described as… */
Left join 
	(Select 
		ResToTrnNotAtHmn.survey5YearsId ID,
		responseToTrainingName [ResponseToTrainNotAtHome Type],
		'ResponseToTrainNotAtHome ' + cast(ResToTrnNotAtHmn.responseToTrainingNotAtHomeId as varchar) as 'ResponseToTrainNotAtHome'

	from survey5Years_referenceResponseToTrainingNotAtHome ResToTrnNotAtHmn 

	inner join referenceResponseToTraining  refResToTrnNotAtHmn

		on refResToTrnNotAtHmn.responseToTrainingId = ResToTrnNotAtHmn.responseToTrainingNotAtHomeId
	) ResToTrnNotAtHmn 
	PIVOT
	(min([ResponseToTrainNotAtHome Type]) For ResponseToTrainNotAtHome
		IN ([ResponseToTrainNotAtHome 1], [ResponseToTrainNotAtHome 2], [ResponseToTrainNotAtHome 3], [ResponseToTrainNotAtHome 4], [ResponseToTrainNotAtHome 5], [ResponseToTrainNotAtHome 6], 
		    [ResponseToTrainNotAtHome 7], [ResponseToTrainNotAtHome 8])
	) 
	pvtResToTrnNotAtHmn  on pvtResToTrnNotAtHmn.ID = surv.survey5YearsId

/*-------- Q65 My dog's toilet-training is… */
left join 
referenceToiletTrainingStatus refToiletTrainingStatus
ON
refToiletTrainingStatus.toiletTrainingStatusId = surv.toiletTrainingStatusId

/*-------- Q66 During the last three months, I have noticed that my dog leaks urine, or appears to urinate without being aware of it…… */
Left join 
	(Select 
		LeaksUrn.survey5YearsId ID,
		incontinenceTypeName [LeaksUrine Type],
		'LeaksUrine ' + cast(LeaksUrn.incontinenceTypeId as varchar) as 'LeaksUrine'

	from survey5Years_referenceIncontinenceType LeaksUrn 

	inner join referenceIncontinenceType  refLeaksUrn 

		on refLeaksUrn.incontinenceTypeId = LeaksUrn.incontinenceTypeId
	) LeaksUrn 
	PIVOT
	(min([LeaksUrine Type]) For LeaksUrine
		IN ([LeaksUrine 1], [LeaksUrine 2], [LeaksUrine 3], [LeaksUrine 4], [LeaksUrine 5])
	) 
	pvtLeaksUrn  on pvtLeaksUrn.ID = surv.survey5YearsId

/*-------- Q67 My dog's urinary incontinence (involuntary loss of urine) started… */
Left join 
	(Select 
		UrnLeakStrt.survey5YearsId ID,
		incontinenceSinceName [UrineLeaksStarted Type],
		'UrineLeaksStarted ' + cast(UrnLeakStrt.incontinenceSinceId as varchar) as 'UrineLeaksStarted'

	from survey5Years_referenceIncontinenceSince UrnLeakStrt

	inner join referenceIncontinenceSince  refUrnLeakStrt

		on refUrnLeakStrt.incontinenceSinceId = UrnLeakStrt.incontinenceSinceId
	) UrnLeakStrt 
	PIVOT
	(min([UrineLeaksStarted Type]) For UrineLeaksStarted
		IN ([UrineLeaksStarted 1], [UrineLeaksStarted 2], [UrineLeaksStarted 3], [UrineLeaksStarted 4])
	) 
	pvtUrnLeakStrt  on pvtUrnLeakStrt.ID = surv.survey5YearsId

/*--------- Q67 My dog's faecal incontinence (involuntary loss of poo/faeces) started…  ---------------*/
Left join 
	(Select 
		FcalInconStrt.survey5YearsId ID,
		incontinenceSinceName [FeaclInconStarted Type],
		'FeaclInconStarted ' + cast(FcalInconStrt.faecalIncontinenceStartedId as varchar) as 'FeaclInconStarted'

	from survey5Years_referenceFaecalIncontinenceStarted FcalInconStrt

	inner join referenceIncontinenceSince  refUrnLeakStrt

		on refUrnLeakStrt.incontinenceSinceId = FcalInconStrt.faecalIncontinenceStartedId
	) UrnLeakStrt 
	PIVOT
	(min([FeaclInconStarted Type]) For FeaclInconStarted
		IN ([FeaclInconStarted 1], [FeaclInconStarted 2], [FeaclInconStarted 3], [FeaclInconStarted 4])
	) 
	pvtFcalInconStrt  on pvtUrnLeakStrt.ID = surv.survey5YearsId

/*---Generic for all queries---*/
left join DTGenPupAdmin.dbo.ExcludedDogs adminGP
	on adminGP.DogID = surv.dogId
--left join tblAboutMe tblAbtMe
	--on (tblAbtMe.userid = surv.userId AND tblAbtMe.dogid = surv.dogId AND tblAbtMe.dogId is not null and tblAbtMe.survey5YearsPercComplete is not null)
Order By surv.dogID desc;
