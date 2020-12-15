/****** 5yr Step 6 Play ******/
/**** Last Updated 2020-09-08 by ET *******
*** In progress **** */
select 
	surv.dogId,
	surv.userId,
	surv.survey5YearsId [5yr Survey ID],
	Cast(surv.surveyCreationDate as DATE) [Survey Creation Date],
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
	--tblAbtMe.survey15MonthsPercComplete [% Complete],
	------------------------- Step 6 --------------------------
/*------------ Q1 In total on a normal WEEK DAY, my dog... ----------*/

/* plays with other dogs */
	coalesce(surv.playDurationWithDogsWeekdayTypeId, '999') [Q1 Plays with other dogs ID (WEEK DAY) ],
	refPlayDurationDogWeekday.playDurationWithDogsWeekdayTypeName [Q1 Plays with other dogs Desc (WEEK DAY)], 

/*------------ Q1a These other dogs are (Weekday)----------*/
	coalesce(surv.playsWithWhichDogsWeekdayTypeId, '999') [Q1a These dogs are ID (WEEK DAY) ],
	refPlayWithDogWeekday.playsWithWhichDogsWeekdayTypeName [Q1a These dogs are Desc (WEEK DAY) ],

/* Q1 Plays with me or other people in my household */
	coalesce(surv.playDurationWithPeopleWeekdayTypeId, '999') [Q1 Plays with me or people in the house ID (WEEK DAY) ],
	refPlayDurationPeopleWeekday.playDurationWithPeopleWeekdayTypeName [Q1 Plays with me or people in the house Desc (WEEK DAY)], 

/* Q1 Plays on his/her own with his/her own toys or other items he/she picks up (for example chewing a rawhide) */
	coalesce(surv.playDurationWithToysWeekdayTypeId, '999') [Q1 Plays on own with toys or other items ID (WEEK DAY) ],
	refPlayDurationToysWeekday.playDurationWithToysWeekdayTypeName [Q1 Plays on own with toys or other items Desc (WEEK DAY)], 

/* Q1 Plays on his/her own without toys (for example dashing about the garden) */
	coalesce(surv.playDurationOnOwnWeekdayTypeId, '999') [Q1 Plays on own without toys ID (WEEK DAY) ],
	refPlayDurationOwnWeekday.playDuratioOnOwnWeekdayTypeName [Q1 Plays on own without toys Desc (WEEK DAY)], 


/* --------------------- WEEK END ----------------------*/

/* plays with other dogs weekend */
	coalesce(surv.playDurationWithDogsWeekendTypeId, '999') [Q2 Plays with other dogs ID (WEEK END) ],
	refPlayDurationDogWeekEnd.playDurationWithDogsWeekendTypeName [Q2 Plays with other dogs Desc (WEEK END)], 


/*------------ Q2a These other dogs are (Weekend)----------*/
	coalesce(surv.playsWithWhichDogsWeekendTypeId, '999') [Q2a These dogs are (WEEK END) ID ],
	refPlayWhichDogWeekend.playsWithWhichDogsWeekendTypeName [Q2a These dogs are (WEEK END) Desc ],

/*------------ Q2 Plays with me or other people in my household WEEK END----------*/
	coalesce(surv.playDurationWithPeopleWeekendTypeId, '999') [Q2 Plays with me or other in house (WEEK END) ID ],
	RefPlayDurationPeopleWeekend.playDurationWithPeopleWeekendTypeName [Q2 Plays with me or other in house (WEEK END) Desc ],

/*------------ Q2 Plays on his/her own with his/her own toys or other items he/she picks up (for example chewing a rawhide) WEEK END----------*/
	coalesce(surv.playDurationWithToysWeekendTypeId, '999') [Q2 Plays on own with toys or other items (WEEK END) ID ],
	refPlayDurationToysWeekend.playDurationWithToysWeekendTypeName [Q2 Plays on own with toys or other items (WEEK END) Desc ],

/*------------ Q2 Plays on his/her own without toys (for example dashing about the garden) WEEK END----------*/
	coalesce(surv.playDurationOnOwnWeekendTypeId, '999') [Q2 Plays on own without toys ID (WEEK END) ],
	refPlayDurationOwnWeekend.playDuratioOnOwnWeekendTypeName [Q2 Plays on own without toys Desc (WEEK END) ],

/*------------- Q3 Can you tell me about your dog's toys --------------------------*/

/*------------Toys with food inside (for example a stuffed Kong)------------------*/
	coalesce(surv.hasToyWithFoodInsideTypeId, '999') [Q3 Toys with food inside ID ],
	refHasToyFoodInside.hasToyWithFoodInsideTypeName [Q3 Toys with food inside Desc ],

/*------------Puzzle or 'brain games' --------*/ 
	coalesce(surv.hasToyPuzzleTypeId, '999') [Q3 Puzzle or 'brain games' ID ],
	refHasToyPuzzle.hasToyPuzzleTypeName [Q3 Puzzle or 'brain games' Desc ],

/*------------ Tugger or rope toys --------*/
	coalesce(surv.hasToyTuggerTypeId, '999') [Q3 Tugger or rope toys ID ],
	refHasToyTugger.hasToyTuggerTypeName [Q3 PTugger or rope toys Desc ],

/*------------ Squeaky Toys --------*/
	coalesce(surv.hasToySqueakyTypeId, '999') [Q3 Squeaky toys ID ],
	refHasToySqueaky.hasToySqueakyTypeName [Q3 Squeaky toys Desc ],

/*------------ Chew or rawhide treats --------*/
	coalesce(surv.hasToyChewTypeId, '999') [Q3 Chew or rawhide treats ID ],
	refHasToyChew.hasToyChewTypeName [Q3 Chew or rawhide treats Desc ],

/*------------ Ball, frisbee or other items to throw --------*/
	coalesce(surv.hasToyThrowableTypeId, '999') [Q3 Ball, frisbee or other items to throw ID ],
	refHasToyThrowable.hasToyThrowableTypeName [Q3 Ball, frisbee or other items to throw Desc ],

/*------------------- Soft toys ----------*/
	coalesce(surv.hasToySoftTypeId, '999') [Q3 Soft toys ID ],
	refHasToySoft.hasToySoftTypeName [Q3 Soft toys Desc ],

/*------------------- Soft toys ----------*/
surv.otherHasToyType [Q3 Other toy type ],

--Q4 The games I/we play with my puppy include...
	surv.playGameFetch [Q4 Fetch or retrieve games ID],
	CASE 
		WHEN surv.playGameFetch = 0 THEN 'No'
		WHEN surv.playGameFetch = 1 THEN 'Yes'
	END [Q4 Fetch or retrieve games Desc],

	surv.playGameTugOfWar [Q4 Tug of war or 'ragger' type games ID],
	CASE 
		WHEN surv.playGameTugOfWar = 0 THEN 'No'
		WHEN surv.playGameTugOfWar = 1 THEN 'Yes'
	END [Q4 Tug of war or 'ragger' type games Desc],

	surv.plugGameWrestling [Q4 Wrestling or rough and tumble games ID],
	CASE 
		WHEN surv.plugGameWrestling = 0 THEN 'No'
		WHEN surv.plugGameWrestling = 1 THEN 'Yes'
	END [Q4 Wrestling or rough and tumble games Desc],

	surv.playGameWeChaseDog [Q4 Chasing games (where we chase him/her) ID],
		CASE 
		WHEN surv.playGameWeChaseDog = 0 THEN 'No'
		WHEN surv.playGameWeChaseDog = 1 THEN 'Yes'
	END [Q4 Chasing games (where we chase him/her) Desc],

	surv.playGameDogChaseUs [Q4 Chasing games (where we chase him/her) ID],
	CASE 
		WHEN surv.playGameDogChaseUs = 0 THEN 'No'
		WHEN surv.playGameDogChaseUs = 1 THEN 'Yes'
	END [Q4 Chasing games (where we chase him/her) Desc],

	surv.playGameTricks [Q4 Training my puppy to do tricks ID],
	CASE 
		WHEN surv.playGameTricks = 0 THEN 'No'
		WHEN surv.playGameTricks = 1 THEN 'Yes'
	END [Q4 Training my puppy to do tricks Desc],

	surv.playGamesOtherTraining [Q4 Other types of training ID],
	CASE 
		WHEN surv.playGamesOtherTraining = 0 THEN 'No'
		WHEN surv.playGamesOtherTraining = 1 THEN 'Yes'
	END [Q4 Other types of training Desc],

	surv.playGamesSearching [Q4 Searching or 'find it' games ID],
	CASE 
		WHEN surv.playGamesSearching = 0 THEN 'No'
		WHEN surv.playGamesSearching = 1 THEN 'Yes'
	END [Q4 Searching or 'find it' games Desc],

	surv.playGamesOtherDetails [Q4 Other games we play]


from survey5Years surv


			/*---------Step 6  Play ----------------*/
/*------------ Q1 In total on a normal WEEK DAY, my dog... ----------*/

/* plays with other dogs */

left join referencePlayDurationWithDogsWeekdayType refPlayDurationDogWeekday
	on refPlayDurationDogWeekday.playDurationWithDogsWeekdayTypeId = surv.playDurationWithDogsWeekdayTypeId

/*------------ Q1a These other dogs are ----------*/
left join referencePlaysWithWhichDogsWeekdayType refPlayWithDogWeekday
	on refPlayWithDogWeekday.playsWithWhichDogsWeekdayTypeId = surv.playsWithWhichDogsWeekdayTypeId

/* Q1 Plays with me or other people in my household */
left join referencePlayDurationWithPeopleWeekdayType  refPlayDurationPeopleWeekday
	on refPlayDurationPeopleWeekday.playDurationWithPeopleWeekdayTypeId = surv.playDurationWithPeopleWeekdayTypeId

/* Q1 Plays on his/her own with his/her own toys or other items he/she picks up (for example chewing a rawhide) */
left join referencePlayDurationWithToysWeekdayType  refPlayDurationToysWeekday
	on refPlayDurationToysWeekday.playDurationWithToysWeekdayTypeId = surv.playDurationWithToysWeekdayTypeId

/* Q1 Plays on his/her own without toys (for example dashing about the garden) */ 
left join referencePlayDurationOnOwnWeekdayType  refPlayDurationOwnWeekday
	on refPlayDurationOwnWeekday.playDurationOnOwnWeekdayTypeId = surv.playDurationOnOwnWeekdayTypeId

/* ----------------------- WEEK END -------------- */

/* Q2 plays with other dogs */

left join referencePlayDurationWithDogsWeekEndType refPlayDurationDogWeekEnd
	on refPlayDurationDogWeekEnd.playDurationWithDogsWeekendTypeId = surv.playDurationWithDogsWeekendTypeId

/*------------ Q2a These other dogs are WEEK END----------*/
left join referencePlaysWithWhichDogsWeekendType refPlayWhichDogWeekend
	on refPlayWhichDogWeekend.playsWithWhichDogsWeekendTypeId = surv.playsWithWhichDogsWeekendTypeId

/*------------ Q2 Plays with me or other people in my household WEEK END----------*/
left join referencePlayDurationWithPeopleWeekendType RefPlayDurationPeopleWeekend
	on RefPlayDurationPeopleWeekend.playDurationWithPeopleWeekendTypeId = surv.playDurationWithPeopleWeekendTypeId

/*------------ Q2 Plays on his/her own with his/her own toys or other items he/she picks up (for example chewing a rawhide) WEEK END----------*/
left join referencePlayDurationWithToysWeekendType refPlayDurationToysWeekend
	on refPlayDurationToysWeekend.playDurationWithToysWeekendTypeId = surv.playDurationWithToysWeekendTypeId

/*------------ Q2 Plays on his/her own without toys (for example dashing about the garden) WEEK END----------*/
left join referencePlayDurationOnOwnWeekendType refPlayDurationOwnWeekend 
	on refPlayDurationOwnWeekend.playDurationOnOwnWeekendTypeId = surv.playDurationOnOwnWeekendTypeId

/*--------------------- QUESTION 3 -----------------*/
/*------------- Q3 Can you tell me about your dog's toys --------------------------*/
/*------------Toys with food inside (for example a stuffed Kong)------------------*/
left join referenceHasToyWithFoodInsideType refHasToyFoodInside 
	on refHasToyFoodInside.hasToyWithFoodInsideTypeId = surv.hasToyWithFoodInsideTypeId

/*------------Puzzle or 'brain games' --------*/
left join referenceHasToyPuzzleType refHasToyPuzzle 
	on refHasToyPuzzle.hasToyPuzzleTypeId = surv.hasToyPuzzleTypeId

/*------------ Tugger or rope toys --------*/
left join referenceHasToyTuggerType refHasToyTugger
	on refHasToyTugger.hasToyTuggerTypeId = surv.hasToyTuggerTypeId

	/*------------ Squeaky Toys --------*/
left join referenceHasToySqueakyType refHasToySqueaky
	on refHasToySqueaky.hasToySqueakyTypeId = surv.hasToySqueakyTypeId

/*------------ Chew or rawhide treats --------*/
left join referenceHasToyChewType refHasToyChew
	on refHasToyChew.hasToyChewTypeId = surv.hasToyChewTypeId

/*------------ Ball, frisbee or other items to throw --------*/
left join referenceHasToyThrowableType refHasToyThrowable
	on refHasToyThrowable.hasToyThrowableTypeId = surv.hasToyThrowableTypeId

/*------------------- Soft toys ----------*/
left join referenceHasToySoftType refHasToySoft
	on refHasToySoft.hasToySoftTypeId = surv.hasToySoftTypeId


/*---Generic for all queries---*/
left join DTGenPupAdmin.dbo.ExcludedDogs adminGP
	on adminGP.DogID = surv.dogId
--left join tblAboutMe tblAbtMe
	--on (tblAbtMe.userid = surv.userId AND tblAbtMe.dogid = surv.dogId AND tblAbtMe.dogId is not null and tblAbtMe.survey15MonthsPercComplete is not null)
Order By surv.dogID desc;



