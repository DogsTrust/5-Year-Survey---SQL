select 
	s.dogId,
	s.userId ,
	s.survey5YearsId [5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
	--0a During the last twelve months, the number of dogs joining the household has been...
	COALESCE(s.joinedDogsNum, '999') [0a Num Dogs Joined Household (Last 12 Months) ID],
	CASE
		WHEN s.joinedDogsNum = 0 THEN 'None'
		WHEN s.joinedDogsNum = 1 THEN '1'
		WHEN s.joinedDogsNum = 2 THEN '2'
		WHEN s.joinedDogsNum = 3 THEN '3'
		WHEN s.joinedDogsNum = 4 THEN '4'
		WHEN s.joinedDogsNum = 5 THEN '5'
		WHEN s.joinedDogsNum = 6 THEN '6'
		WHEN s.joinedDogsNum = 99 THEN 'More Than 6'
		WHEN s.joinedDogsNum = 100 THEN 'Don''t Know/Can''t Remember'
	END [0a Num Dogs Joined Household (Last 12 Months) Desc],
	--0b During the last twelve months, the number of cats joining the household has been...
	COALESCE(s.joinedCatsNum, '999') [0b Num Cats Joined Household (Last 12 Months) ID],
	CASE
		WHEN s.joinedCatsNum = 0 THEN 'None'
		WHEN s.joinedCatsNum = 1 THEN '1'
		WHEN s.joinedCatsNum = 2 THEN '2'
		WHEN s.joinedCatsNum = 3 THEN '3'
		WHEN s.joinedCatsNum = 4 THEN '4'
		WHEN s.joinedCatsNum = 5 THEN '5'
		WHEN s.joinedCatsNum = 6 THEN '6'
		WHEN s.joinedCatsNum = 99 THEN 'More Than 6'
		WHEN s.joinedCatsNum = 100 THEN 'Don''t Know/Can''t Remember'
	END [0b Num Cats Joined Household (Last 12 Months) Desc],
	--0c During the last twelve months, the number of people joining the household has been...
	COALESCE(s.joinedPeopleNum, '999') [0c Num People Joined Household (Last 12 Months) ID],
	CASE
		WHEN s.joinedPeopleNum = 0 THEN 'None'
		WHEN s.joinedPeopleNum = 1 THEN '1'
		WHEN s.joinedPeopleNum = 2 THEN '2'
		WHEN s.joinedPeopleNum = 3 THEN '3'
		WHEN s.joinedPeopleNum = 4 THEN '4'
		WHEN s.joinedPeopleNum = 5 THEN '5'
		WHEN s.joinedPeopleNum = 6 THEN '6'
		WHEN s.joinedPeopleNum = 99 THEN 'More Than 6'
		WHEN s.joinedPeopleNum = 100 THEN 'Don''t Know/Can''t Remember'
	END [0c Num People Joined Household (Last 12 Months) Desc],
	--0d During the last twelve months, the number of dogs leaving the household (for example due to being rehomed or put to sleep) has been...
	COALESCE(s.leftDogsNum, '999') [0d Num Dogs Left Household (Last 12 Months) ID],
	CASE
		WHEN s.leftDogsNum = 0 THEN 'None'
		WHEN s.leftDogsNum = 1 THEN '1'
		WHEN s.leftDogsNum = 2 THEN '2'
		WHEN s.leftDogsNum = 3 THEN '3'
		WHEN s.leftDogsNum = 4 THEN '4'
		WHEN s.leftDogsNum = 5 THEN '5'
		WHEN s.leftDogsNum = 6 THEN '6'
		WHEN s.leftDogsNum = 99 THEN 'More Than 6'
		WHEN s.leftDogsNum = 100 THEN 'Don''t Know/Can''t Remember'
	END [0d Num Dogs Left Household (Last 12 Months) Desc],
	--0e During the last twelve months, the number of cats leaving the household (for example due to being rehomed or put to sleep) has been...
	COALESCE(s.leftCatsNum, '999') [0e Num Cats Left Household (Last 12 Months) ID],
	CASE
		WHEN s.leftCatsNum = 0 THEN 'None'
		WHEN s.leftCatsNum = 1 THEN '1'
		WHEN s.leftCatsNum = 2 THEN '2'
		WHEN s.leftCatsNum = 3 THEN '3'
		WHEN s.leftCatsNum = 4 THEN '4'
		WHEN s.leftCatsNum = 5 THEN '5'
		WHEN s.leftCatsNum = 6 THEN '6'
		WHEN s.leftCatsNum = 99 THEN 'More Than 6'
		WHEN s.leftCatsNum = 100 THEN 'Don''t Know/Can''t Remember'
	END [0e Num Cats Left Household (Last 12 Months) Desc],
	--0f During the last twelve months, the number of people leaving the household (for example moving out to live elsewhere) has been…
	COALESCE(s.leftPeopleNum, '999') [0f Num People Left Household (Last 12 Months) ID],
	CASE
		WHEN s.leftPeopleNum = 0 THEN 'None'
		WHEN s.leftPeopleNum = 1 THEN '1'
		WHEN s.leftPeopleNum = 2 THEN '2'
		WHEN s.leftPeopleNum = 3 THEN '3'
		WHEN s.leftPeopleNum = 4 THEN '4'
		WHEN s.leftPeopleNum = 5 THEN '5'
		WHEN s.leftPeopleNum = 6 THEN '6'
		WHEN s.leftPeopleNum = 99 THEN 'More Than 6'
		WHEN s.leftPeopleNum = 100 THEN 'Don''t Know/Can''t Remember'
	END [0f Num People Left Household (Last 12 Months) Desc],
	--0g The total number of dogs (including "Toby") in the household is now:
	COALESCE(s.totalDogsNum, '999') [0g Total Dogs In Household (Last 12 Months)],
	--0h The total number of cats in the household is now:
	COALESCE(s.totalCatsNum, '999') [0h Total Cats In Household (Last 12 Months)],
	--0i The total number of people in the household is now:
	COALESCE(s.totalPeopleNum, '999') [0i Total People In Household (Last 12 Months)],
	--0j The total number of babies (aged under 12 months) in the household is now:
	COALESCE(s.totalBabiesNum, '999') [0j Total Babies (<12m) In Household (Last 12 Months)],
	--0k The total number of children (aged 1-4 years) in the household is now:
	COALESCE(s.totalChildren1To4Num, '999') [0k Total Children (1yr to 4yr) In Household (Last 12 Months)],
	--0l The total number of children (aged 5-10 years) in the household is now:
	COALESCE(s.totalChildren5To10Num, '999') [0l Total Children (5yr to 10yr) In Household (Last 12 Months)],
	--0m The total number of children (aged 11-15 years) in the household is now:
	COALESCE(s.totalChildren11To15Num, '999') [0m Total Children (11yr to 15yr) In Household (Last 12 Months)],
	--0.1 During the last twelve months, have the working hours of householders changed, so that "Toby" is left at home for more or less time than he/she used to be left for?
	COALESCE(s.haveHouseholdHoursChanged, '999') [0.1 Working Hours Changed in Last 12 Months ID],
	CASE
		WHEN s.haveHouseholdHoursChanged = 0 THEN 'No'
		WHEN s.haveHouseholdHoursChanged = 1 THEN 'Yes'
    WHEN s.haveHouseholdHoursChanged = 3 THEN 'I would rather not say'
	END [0.1 Working Hours Changed in Last 12 Months Desc],
	--0.15 if you are willing to do so, please use the space below to the share with us the information on the change in working hours that influence "Toby"'s day. If possible please let us know approximately when this change occurred.
	s.householdHoursChangeDetail [0.1 Working Hours Changed in Last 12 Months Detail],
	--0.2 During the last twelve months, have you experienced any exciting events that may have impacted on "Toby"? For example, getting married, having a baby, starting a new job, building work to your house, winning a major competition).
	COALESCE(s.haveHadExcitingEvents, '999') [0.2 Exciting Events in Last 12 Months ID],
	CASE
		WHEN s.haveHadExcitingEvents = 0 THEN 'No'
		WHEN s.haveHadExcitingEvents = 1 THEN 'Yes'
    WHEN s.haveHadExcitingEvents = 3 THEN 'I would rather not say'
	END [0.2 Exciting Events in Last 12 Months Desc],
	--0.25 if you are willing to do so, please use the space below to the share with us the information about any exciting events you have experienced that may have impacted on "Toby". If possible please let us know approximately when these events occurred.
	s.haveHadExcitingEventsDetail [0.2 Exciting Events in Last 12 Months Details],
	--0.3 During the last twelve months, have you experienced any stressful events that may have impacted on "Toby"? (For example, a divorce or separation, building work to your house, redundancy, a bereavement or illness).
	COALESCE(s.haveHadStressfulEvents, '999') [0.3 Stressful Events in Last 12 Months ID],
	CASE
		WHEN s.haveHadStressfulEvents = 0 THEN 'No'
		WHEN s.haveHadStressfulEvents = 1 THEN 'Yes'
    WHEN s.haveHadStressfulEvents = 3 THEN 'I would rather not say'
	END [0.3 Stressful Events in Last 12 Months Desc],
	--0.35 if you are willing and comfortable to do so, please use the space below to the share with us the information about any stressful events you have experienced that may have impacted on "Toby". If possible please let us know approximately when these events occurred.
	s.haveHadStressfulEventsDetail [0.3 Stressful Events in Last 12 Months Detail],
	--1.1 During the last 12 months, "Toby" has travelled to…(please do not include travel within the country he/she currently lives in)... 
	pvtct.[1] [1.1 No countries outside England, Scotland and Wales],
	pvtct.[2] [1.1 Africa],
	pvtct.[3] [1.1 America],
	pvtct.[4] [1.1 Asia],
	pvtct.[5] [1.1 Australia],
	pvtct.[6] [1.1 Denmark],
	pvtct.[7] [1.1 Finland],
	pvtct.[8] [1.1 France],
	pvtct.[9] [1.1 Germany],
	pvtct.[10] [1.1 Hungary],
	pvtct.[11] [1.1 Ireland (Northern)],
	pvtct.[12] [1.1 Ireland (Republic of)],
	pvtct.[13] [1.1 Italy],
	pvtct.[14] [1.1 New Zealand],
	pvtct.[15] [1.1 Norway],
	pvtct.[16] [1.1 Portugal],
	pvtct.[17] [1.1 Spain],
	pvtct.[18] [1.1 Sweden],
	pvtct.[19] [1.1 Switzerland],
	pvtct.[20] [1.1 The Netherlands],
	pvtct.[21] [1.1 The UK (excluding Northern Ireland)],
	pvtct.[22] [1.1 Other European country (excluding England, Scotland, Wales, Ireland) - please specify ID],
	s.otherEuropeanCountryTravelledTo [1.1 Other European country (excluding England, Scotland, Wales, Ireland) - please specify Desc],
	pvtct.[23] [1.1 Other (please specify) ID],
	s.otherCountryTravelledTo [1.1 Other (please specify) Desc],
	pvtct.[24] [1.1 No countries outside of the Republic of Ireland or Northern Ireland],
	--1.2 The country that "Toby" visited most recently was…
	pvtcvmr.[1] [1.2 Africa],
	pvtcvmr.[2] [1.2 America],
	pvtcvmr.[3] [1.2 Asia],
	pvtcvmr.[4] [1.2 Australia],
	pvtcvmr.[5] [1.2 Denmark],
	pvtcvmr.[6] [1.2 Finland],
	pvtcvmr.[7] [1.2 France],
	pvtcvmr.[8] [1.2 Germany],
	pvtcvmr.[9] [1.2 Hungary],
	pvtcvmr.[10] [1.2 Ireland (Northern)],
	pvtcvmr.[11] [1.2 Ireland (Republic of)],
	pvtcvmr.[12] [1.2 Italy],
	pvtcvmr.[13] [1.2 New Zealand],
	pvtcvmr.[14] [1.2 Norway],
	pvtcvmr.[15] [1.2 Portugal],
	pvtcvmr.[16] [1.2 Spain],
	pvtcvmr.[17] [1.2 Sweden],
	pvtcvmr.[18] [1.2 Switzerland],
	pvtcvmr.[19] [1.2 The Netherlands],
	pvtcvmr.[20] [1.2 Other European country (excluding England, Scotland, Wales, Ireland) - please specify ID],
	s.otherEuropeanCountryVisitedMostRecently [1.2 Other European country (excluding England, Scotland, Wales, Ireland) - please specify Desc],
	pvtcvmr.[21] [1.2 Other (please specify) ID],
	s.otherCountryVisitedMostRecently [1.2 Other (please specify) Desc],
	--1.3 On his/her most recent trip, "Toby" was abroad for approximately...
	COALESCE(s.mostRecentTripTimeId, '999') [1.3 Time Abroad ID],
	mrtt.mostRecentTripTimeName [1.3 Time Abroad Desc],
	--1.4 His/her most recent abroad trip started in the month of…
	COALESCE(s.mostRecentTripStartedId, '999') [1.4 Trip Abroad Start Month ID],
	mrts.mostRecentTripStartedName [1.4 Trip Abroad Start Month Desc],
	--1.5 Before taking "Toby" on his/her most recent trip abroad, he/she was given the following by a vet specifically for his/her travels…
	pvtvgb.[1] [1.5 Medication to repel ticks (which can transmit diseases like Babesiosis/Ehrlichiosis)],
	pvtvgb.[2] [1.5 Vaccination against Leishmaniasis (spread by sand flies)],
	pvtvgb.[3] [1.5 Medication to reduce the risk of heartworm (spread by mosquitoes)],
	pvtvgb.[4] [1.5 I don't know/can't remember],
	pvtvgb.[5] [1.5 Other (please specify) ID],
	s.otherMostRecentTripVetGaveNameBefore [1.5 Other (please specify) Desc],
	pvtvgb.[6] [1.5 None of the above],
	--1.6 During "Toby"'s most recent trip abroad, he/she was given the following…
	pvtvgd.[1] [1.6 Medication to repel ticks (which can transmit diseases like Babesiosis/Ehrlichiosis)],
	pvtvgd.[2] [1.6 Vaccination against Leishmaniasis (spread by sand flies)],
	pvtvgd.[3] [1.6 Medication to reduce the risk of heartworm (spread by mosquitoes)],
	pvtvgd.[4] [1.6 I don't know/can't remember],
	pvtvgd.[5] [1.6 Other (please specify) ID],
	s.otherMostRecentTripVetGaveNameDuring [1.6 Other (please specify) Desc],
	pvtvgd.[6] [1.6 None of the above],
	--1.7 After "Toby"'s most recent trip abroad, he/she was given the following…
	pvtvga.[1] [1.7 Medication to repel ticks (which can transmit diseases like Babesiosis/Ehrlichiosis)],
	pvtvga.[2] [1.7 Vaccination against Leishmaniasis (spread by sand flies)],
	pvtvga.[3] [1.7 Medication to reduce the risk of heartworm (spread by mosquitoes)],
	pvtvga.[4] [1.7 I don't know/can't remember],
	pvtvga.[5] [1.7 Other (please specify) ID],
	s.otherMostRecentTripVetGaveNameAfter [1.7 Other (please specify) Desc],
	pvtvga.[6] [1.7 None of the above],
	--1.8 Whilst on "Toby's" most recent trip abroad, or immediately on your return, did you notice one or more ticks on him/her?
	COALESCE(s.tripNoticedTicks, '999') [1.8 Noticed More Ticks ID],
	CASE
		WHEN s.tripNoticedTicks = 0 THEN 'No'
		WHEN s.tripNoticedTicks = 1 THEN 'Yes'
    WHEN s.tripNoticedTicks = 2 THEN 'I don''t know/can''t remember'
	END [1.8 Noticed More Ticks Desc],
	--40 Did "Toby" have any health issues whilst away on and/or on return from his/her most recent trip abroad?
	pvthi.[1] [40 No, he/she had no health issues whilst there, or on return  ],
	pvthi.[2] [40 He/she had health issues whilst on the trip],
	pvthi.[3] [40 He/she had health issues that started within 2 weeks of the end of the trip  ],
	pvthi.[4] [40 I don't know/can't remember],
	--40.1 Please use the space below to tell us any information about the health issues that "Toby" had when on the trip abroad (if possible please specify the problem(s), the sign(s), diagnosis and treatment if known)
	COALESCE(s.otherAbroadHealthIssuesDetail, '999') [40.1 Health Issues Abroad Detail],
	--40.2 Please use the space below to tell us about the health issues that "Toby"  had on return from the trip abroad (if possible please specify the problem(s), the sign(s), diagnosis and treatment if known)
	COALESCE(s.otherAbroadReturnHealthIssuesDetail, '999') [40.2 Health Issues on Return Detail],
	--1.9 During the last three months, "Toby" has been…
	pvtrb.[1] [1.9 Into a town/city (for example, walking down the street on the lead with me)],
	pvtrb.[2] [1.9 To a park where he/she saw other dogs off the lead],
	pvtrb.[3] [1.9 To the beach],
	pvtrb.[4] [1.9 On a bus],
	pvtrb.[5] [1.9 On a train],
	pvtrb.[6] [1.9 Into a pub/café],
	pvtrb.[7] [1.9 To adult dog training classes],
	pvtrb.[8] [1.9 To a country show],
	pvtrb.[9] [1.9 To a village fete],
	pvtrb.[10] [1.9 To a Kennel Club dog show],
	pvtrb.[11] [1.9 To a fun dog show],
	pvtrb.[12] [1.9 To Flyball training],
	pvtrb.[13] [1.9 To a Flyball competition],
	pvtrb.[14] [1.9 To agility training],
	pvtrb.[15] [1.9 To an agility competition],
	pvtrb.[16] [1.9 To work with me],
	pvtrb.[17] [1.9 To stay on a campsite],
	pvtrb.[18] [1.9 Running/jogging with me (on the lead)],
	pvtrb.[19] [1.9 Running/jogging with me (off the lead)],
	pvtrb.[20] [1.9 To a canicross competition],
	pvtrb.[21] [1.9 To ringcraft (in preparation for showing at dog shows)],
	pvtrb.[22] [1.9 To heel work to music],
	pvtrb.[23] [1.9 To gundog training classes],
	pvtrb.[24] [1.9 To another activity or event…(please specify) ID],
	s.otherRecentlyBeenTypeName [1.9 To another activity or event…(please specify) Desc],
	pvtrb.[25] [1.9 To none of the above],
	--1.10 The last time 'Toby' was….(insert relevant text...in a town/city, pub/café, at the beach, at a park etc etc etc), he/she…
	/*----Into a town/city----*/
	pvtrtwn.[1] [1.10.a Was interested but stayed calm],
	pvtrtwn.[2] [1.10.a Was disinterested/didn't react],
	pvtrtwn.[3] [1.10.a Held tail down between his/her legs],
	pvtrtwn.[4] [1.10.a Became excited],
	pvtrtwn.[5] [1.10.a Explored or sniffed],
	pvtrtwn.[6] [1.10.a Pined, whined, or cried],
	pvtrtwn.[7] [1.10.a Froze or stayed still],
	pvtrtwn.[8] [1.10.a Trembled or shook],
	pvtrtwn.[9] [1.10.a Toileted in an inappropriate location],
	pvtrtwn.[10] [1.10.a Pulled/ran away or tried to run away],
	pvtrtwn.[11] [1.10.a Raised his/her hackles],
	pvtrtwn.[12] [1.10.a Played/tried to play with a dog],
	pvtrtwn.[13] [1.10.a Chased a dog],
	pvtrtwn.[14] [1.10.a Was chased by a dog],
	pvtrtwn.[15] [1.10.a Barked at a person],
	pvtrtwn.[16] [1.10.a Barked at a dog],
	pvtrtwn.[17] [1.10.a Growled/snarled at a person],
	pvtrtwn.[18] [1.10.a Growled/snarled at a dog],
	pvtrtwn.[19] [1.10.a Snarled/raised upper lip at a person],
	pvtrtwn.[20] [1.10.a Snarled/raised upper lip at a dog],
	pvtrtwn.[21] [1.10.a Snapped at/bit a person],
	pvtrtwn.[22] [1.10.a Snapped at/bit a dog],
	pvtrtwn.[23] [1.10.a Was snapped at/bitten by other dog],
	pvtrtwn.[24] [1.10.a I don’t know/can’t remember],
	pvtrtwn.[25] [1.10.a Other (please specify) ID],
	s.otherRecentlyBeenReactionToTown [1.10.a Other (please specify) Desc],
	/*----To a park where he/she saw other dogs off the lead----*/
	pvtrPrk.[1] [1.10.b Was interested but stayed calm],
	pvtrPrk.[2] [1.10.b Was disinterested/didn't react],
	pvtrPrk.[3] [1.10.b Held tail down between his/her legs],
	pvtrPrk.[4] [1.10.b Became excited],
	pvtrPrk.[5] [1.10.b Explored or sniffed],
	pvtrPrk.[6] [1.10.b Pined, whined, or cried],
	pvtrPrk.[7] [1.10.b Froze or stayed still],
	pvtrPrk.[8] [1.10.b Trembled or shook],
	pvtrPrk.[9] [1.10.b Toileted in an inappropriate location],
	pvtrPrk.[10] [1.10.b Pulled/ran away or tried to run away],
	pvtrPrk.[11] [1.10.b Raised his/her hackles],
	pvtrPrk.[12] [1.10.b Played/tried to play with a dog],
	pvtrPrk.[13] [1.10.b Chased a dog],
	pvtrPrk.[14] [1.10.b Was chased by a dog],
	pvtrPrk.[15] [1.10.b Barked at a person],
	pvtrPrk.[16] [1.10.b Barked at a dog],
	pvtrPrk.[17] [1.10.b Growled/snarled at a person],
	pvtrPrk.[18] [1.10.b Growled/snarled at a dog],
	pvtrPrk.[19] [1.10.b Snarled/raised upper lip at a person],
	pvtrPrk.[20] [1.10.b Snarled/raised upper lip at a dog],
	pvtrPrk.[21] [1.10.b Snapped at/bit a person],
	pvtrPrk.[22] [1.10.b Snapped at/bit a dog],
	pvtrPrk.[23] [1.10.b Was snapped at/bitten by other dog],
	pvtrPrk.[24] [1.10.b I don’t know/can’t remember],
	pvtrPrk.[25] [1.10.b Other (please specify) ID],
	s.otherRecentlyBeenReactionToPark [1.10.b Other (please specify) Desc],
	/*----To the beach----*/
	pvtrbch.[1] [1.10.c Was interested but stayed calm],
	pvtrbch.[2] [1.10.c Was disinterested/didn't react],
	pvtrbch.[3] [1.10.c Held tail down between his/her legs],
	pvtrbch.[4] [1.10.c Became excited],
	pvtrbch.[5] [1.10.c Explored or sniffed],
	pvtrbch.[6] [1.10.c Pined, whined, or cried],
	pvtrbch.[7] [1.10.c Froze or stayed still],
	pvtrbch.[8] [1.10.c Trembled or shook],
	pvtrbch.[9] [1.10.c Toileted in an inappropriate location],
	pvtrbch.[10] [1.10.c Pulled/ran away or tried to run away],
	pvtrbch.[11] [1.10.c Raised his/her hackles],
	pvtrbch.[12] [1.10.c Played/tried to play with a dog],
	pvtrbch.[13] [1.10.c Chased a dog],
	pvtrbch.[14] [1.10.c Was chased by a dog],
	pvtrbch.[15] [1.10.c Barked at a person],
	pvtrbch.[16] [1.10.c Barked at a dog],
	pvtrbch.[17] [1.10.c Growled/snarled at a person],
	pvtrbch.[18] [1.10.c Growled/snarled at a dog],
	pvtrbch.[19] [1.10.c Snarled/raised upper lip at a person],
	pvtrbch.[20] [1.10.c Snarled/raised upper lip at a dog],
	pvtrbch.[21] [1.10.c Snapped at/bit a person],
	pvtrbch.[22] [1.10.c Snapped at/bit a dog],
	pvtrbch.[23] [1.10.c Was snapped at/bitten by other dog],
	pvtrbch.[24] [1.10.c I don’t know/can’t remember],
	pvtrbch.[25] [1.10.c Other (please specify) ID],
	s.otherRecentlyBeenReactionToBeach [1.10.c Other (please specify) Desc],
	/*----On a bus----*/
	pvtrbus.[1] [1.10.d Was interested but stayed calm],
	pvtrbus.[2] [1.10.d Was disinterested/didn't react],
	pvtrbus.[3] [1.10.d Held tail down between his/her legs],
	pvtrbus.[4] [1.10.d Became excited],
	pvtrbus.[5] [1.10.d Explored or sniffed],
	pvtrbus.[6] [1.10.d Pined, whined, or cried],
	pvtrbus.[7] [1.10.d Froze or stayed still],
	pvtrbus.[8] [1.10.d Trembled or shook],
	pvtrbus.[9] [1.10.d Toileted in an inappropriate location],
	pvtrbus.[10] [1.10.d Pulled/ran away or tried to run away],
	pvtrbus.[11] [1.10.d Raised his/her hackles],
	pvtrbus.[12] [1.10.d Played/tried to play with a dog],
	pvtrbus.[13] [1.10.d Chased a dog],
	pvtrbus.[14] [1.10.d Was chased by a dog],
	pvtrbus.[15] [1.10.d Barked at a person],
	pvtrbus.[16] [1.10.d Barked at a dog],
	pvtrbus.[17] [1.10.d Growled/snarled at a person],
	pvtrbus.[18] [1.10.d Growled/snarled at a dog],
	pvtrbus.[19] [1.10.d Snarled/raised upper lip at a person],
	pvtrbus.[20] [1.10.d Snarled/raised upper lip at a dog],
	pvtrbus.[21] [1.10.d Snapped at/bit a person],
	pvtrbus.[22] [1.10.d Snapped at/bit a dog],
	pvtrbus.[23] [1.10.d Was snapped at/bitten by other dog],
	pvtrbus.[24] [1.10.d I don’t know/can’t remember],
	pvtrbus.[25] [1.10.d Other (please specify) ID],
	s.otherRecentlyBeenReactionToBus [1.10.d Other (please specify) Desc],
	/*----On a train----*/
	pvtrtrn.[1] [1.10.e Was interested but stayed calm],
	pvtrtrn.[2] [1.10.e Was disinterested/didn't react],
	pvtrtrn.[3] [1.10.e Held tail down between his/her legs],
	pvtrtrn.[4] [1.10.e Became excited],
	pvtrtrn.[5] [1.10.e Explored or sniffed],
	pvtrtrn.[6] [1.10.e Pined, whined, or cried],
	pvtrtrn.[7] [1.10.e Froze or stayed still],
	pvtrtrn.[8] [1.10.e Trembled or shook],
	pvtrtrn.[9] [1.10.e Toileted in an inappropriate location],
	pvtrtrn.[10] [1.10.e Pulled/ran away or tried to run away],
	pvtrtrn.[11] [1.10.e Raised his/her hackles],
	pvtrtrn.[12] [1.10.e Played/tried to play with a dog],
	pvtrtrn.[13] [1.10.e Chased a dog],
	pvtrtrn.[14] [1.10.e Was chased by a dog],
	pvtrtrn.[15] [1.10.e Barked at a person],
	pvtrtrn.[16] [1.10.e Barked at a dog],
	pvtrtrn.[17] [1.10.e Growled/snarled at a person],
	pvtrtrn.[18] [1.10.e Growled/snarled at a dog],
	pvtrtrn.[19] [1.10.e Snarled/raised upper lip at a person],
	pvtrtrn.[20] [1.10.e Snarled/raised upper lip at a dog],
	pvtrtrn.[21] [1.10.e Snapped at/bit a person],
	pvtrtrn.[22] [1.10.e Snapped at/bit a dog],
	pvtrtrn.[23] [1.10.e Was snapped at/bitten by other dog],
	pvtrtrn.[24] [1.10.e I don’t know/can’t remember],
	pvtrtrn.[25] [1.10.e Other (please specify) ID],
	s.otherRecentlyBeenReactionToTrain [1.10.e Other (please specify) Desc],
	/*----Into a pub/café----*/
	pvtrpub.[1] [1.10.f Was interested but stayed calm],
	pvtrpub.[2] [1.10.f Was disinterested/didn't react],
	pvtrpub.[3] [1.10.f Held tail down between his/her legs],
	pvtrpub.[4] [1.10.f Became excited],
	pvtrpub.[5] [1.10.f Explored or sniffed],
	pvtrpub.[6] [1.10.f Pined, whined, or cried],
	pvtrpub.[7] [1.10.f Froze or stayed still],
	pvtrpub.[8] [1.10.f Trembled or shook],
	pvtrpub.[9] [1.10.f Toileted in an inappropriate location],
	pvtrpub.[10] [1.10.f Pulled/ran away or tried to run away],
	pvtrpub.[11] [1.10.f Raised his/her hackles],
	pvtrpub.[12] [1.10.f Played/tried to play with a dog],
	pvtrpub.[13] [1.10.f Chased a dog],
	pvtrpub.[14] [1.10.f Was chased by a dog],
	pvtrpub.[15] [1.10.f Barked at a person],
	pvtrpub.[16] [1.10.f Barked at a dog],
	pvtrpub.[17] [1.10.f Growled/snarled at a person],
	pvtrpub.[18] [1.10.f Growled/snarled at a dog],
	pvtrpub.[19] [1.10.f Snarled/raised upper lip at a person],
	pvtrpub.[20] [1.10.f Snarled/raised upper lip at a dog],
	pvtrpub.[21] [1.10.f Snapped at/bit a person],
	pvtrpub.[22] [1.10.f Snapped at/bit a dog],
	pvtrpub.[23] [1.10.f Was snapped at/bitten by other dog],
	pvtrpub.[24] [1.10.f I don’t know/can’t remember],
	pvtrpub.[25] [1.10.f Other (please specify) ID],
	s.otherRecentlyBeenReactionToPub [1.10.f Other (please specify) Desc],
	/*----To adult dog training classes----*/
	pvtrac.[1] [1.10.g Was interested but stayed calm],
	pvtrac.[2] [1.10.g Was disinterested/didn't react],
	pvtrac.[3] [1.10.g Held tail down between his/her legs],
	pvtrac.[4] [1.10.g Became excited],
	pvtrac.[5] [1.10.g Explored or sniffed],
	pvtrac.[6] [1.10.g Pined, whined, or cried],
	pvtrac.[7] [1.10.g Froze or stayed still],
	pvtrac.[8] [1.10.g Trembled or shook],
	pvtrac.[9] [1.10.g Toileted in an inappropriate location],
	pvtrac.[10] [1.10.g Pulled/ran away or tried to run away],
	pvtrac.[11] [1.10.g Raised his/her hackles],
	pvtrac.[12] [1.10.g Played/tried to play with a dog],
	pvtrac.[13] [1.10.g Chased a dog],
	pvtrac.[14] [1.10.g Was chased by a dog],
	pvtrac.[15] [1.10.g Barked at a person],
	pvtrac.[16] [1.10.g Barked at a dog],
	pvtrac.[17] [1.10.g Growled/snarled at a person],
	pvtrac.[18] [1.10.g Growled/snarled at a dog],
	pvtrac.[19] [1.10.g Snarled/raised upper lip at a person],
	pvtrac.[20] [1.10.g Snarled/raised upper lip at a dog],
	pvtrac.[21] [1.10.g Snapped at/bit a person],
	pvtrac.[22] [1.10.g Snapped at/bit a dog],
	pvtrac.[23] [1.10.g Was snapped at/bitten by other dog],
	pvtrac.[24] [1.10.g I don’t know/can’t remember],
	pvtrac.[25] [1.10.g Other (please specify) ID],
	s.otherRecentlyBeenReactionToAdultClasses [1.10.g Other (please specify) Desc],
	/*----To a country show----*/
	pvtrcs.[1] [1.10.h Was interested but stayed calm],
	pvtrcs.[2] [1.10.h Was disinterested/didn't react],
	pvtrcs.[3] [1.10.h Held tail down between his/her legs],
	pvtrcs.[4] [1.10.h Became excited],
	pvtrcs.[5] [1.10.h Explored or sniffed],
	pvtrcs.[6] [1.10.h Pined, whined, or cried],
	pvtrcs.[7] [1.10.h Froze or stayed still],
	pvtrcs.[8] [1.10.h Trembled or shook],
	pvtrcs.[9] [1.10.h Toileted in an inappropriate location],
	pvtrcs.[10] [1.10.h Pulled/ran away or tried to run away],
	pvtrcs.[11] [1.10.h Raised his/her hackles],
	pvtrcs.[12] [1.10.h Played/tried to play with a dog],
	pvtrcs.[13] [1.10.h Chased a dog],
	pvtrcs.[14] [1.10.h Was chased by a dog],
	pvtrcs.[15] [1.10.h Barked at a person],
	pvtrcs.[16] [1.10.h Barked at a dog],
	pvtrcs.[17] [1.10.h Growled/snarled at a person],
	pvtrcs.[18] [1.10.h Growled/snarled at a dog],
	pvtrcs.[19] [1.10.h Snarled/raised upper lip at a person],
	pvtrcs.[20] [1.10.h Snarled/raised upper lip at a dog],
	pvtrcs.[21] [1.10.h Snapped at/bit a person],
	pvtrcs.[22] [1.10.h Snapped at/bit a dog],
	pvtrcs.[23] [1.10.h Was snapped at/bitten by other dog],
	pvtrcs.[24] [1.10.h I don’t know/can’t remember],
	pvtrcs.[25] [1.10.h Other (please specify) ID],
	s.otherRecentlyBeenReactionToCountryShow [1.10.h Other (please specify) Desc],
	/*----To a village fete----*/
	pvtrvf.[1] [1.10.i Was interested but stayed calm],
	pvtrvf.[2] [1.10.i Was disinterested/didn't react],
	pvtrvf.[3] [1.10.i Held tail down between his/her legs],
	pvtrvf.[4] [1.10.i Became excited],
	pvtrvf.[5] [1.10.i Explored or sniffed],
	pvtrvf.[6] [1.10.i Pined, whined, or cried],
	pvtrvf.[7] [1.10.i Froze or stayed still],
	pvtrvf.[8] [1.10.i Trembled or shook],
	pvtrvf.[9] [1.10.i Toileted in an inappropriate location],
	pvtrvf.[10] [1.10.i Pulled/ran away or tried to run away],
	pvtrvf.[11] [1.10.i Raised his/her hackles],
	pvtrvf.[12] [1.10.i Played/tried to play with a dog],
	pvtrvf.[13] [1.10.i Chased a dog],
	pvtrvf.[14] [1.10.i Was chased by a dog],
	pvtrvf.[15] [1.10.i Barked at a person],
	pvtrvf.[16] [1.10.i Barked at a dog],
	pvtrvf.[17] [1.10.i Growled/snarled at a person],
	pvtrvf.[18] [1.10.i Growled/snarled at a dog],
	pvtrvf.[19] [1.10.i Snarled/raised upper lip at a person],
	pvtrvf.[20] [1.10.i Snarled/raised upper lip at a dog],
	pvtrvf.[21] [1.10.i Snapped at/bit a person],
	pvtrvf.[22] [1.10.i Snapped at/bit a dog],
	pvtrvf.[23] [1.10.i Was snapped at/bitten by other dog],
	pvtrvf.[24] [1.10.i I don’t know/can’t remember],
	pvtrvf.[25] [1.10.i Other (please specify) ID],
	s.otherRecentlyBeenReactionToFete  [1.10.a Other (please specify) Desc],
	/*----To a Kennel Club dog show----*/
	pvtrkcds.[1] [1.10.j Was interested but stayed calm],
	pvtrkcds.[2] [1.10.j Was disinterested/didn't react],
	pvtrkcds.[3] [1.10.j Held tail down between his/her legs],
	pvtrkcds.[4] [1.10.j Became excited],
	pvtrkcds.[5] [1.10.j Explored or sniffed],
	pvtrkcds.[6] [1.10.j Pined, whined, or cried],
	pvtrkcds.[7] [1.10.j Froze or stayed still],
	pvtrkcds.[8] [1.10.j Trembled or shook],
	pvtrkcds.[9] [1.10.j Toileted in an inappropriate location],
	pvtrkcds.[10] [1.10.j Pulled/ran away or tried to run away],
	pvtrkcds.[11] [1.10.j Raised his/her hackles],
	pvtrkcds.[12] [1.10.j Played/tried to play with a dog],
	pvtrkcds.[13] [1.10.j Chased a dog],
	pvtrkcds.[14] [1.10.j Was chased by a dog],
	pvtrkcds.[15] [1.10.j Barked at a person],
	pvtrkcds.[16] [1.10.j Barked at a dog],
	pvtrkcds.[17] [1.10.j Growled/snarled at a person],
	pvtrkcds.[18] [1.10.j Growled/snarled at a dog],
	pvtrkcds.[19] [1.10.j Snarled/raised upper lip at a person],
	pvtrkcds.[20] [1.10.j Snarled/raised upper lip at a dog],
	pvtrkcds.[21] [1.10.j Snapped at/bit a person],
	pvtrkcds.[22] [1.10.j Snapped at/bit a dog],
	pvtrkcds.[23] [1.10.j Was snapped at/bitten by other dog],
	pvtrkcds.[24] [1.10.j I don’t know/can’t remember],
	pvtrkcds.[25] [1.10.j Other (please specify) ID],
	s.otherRecentlyBeenReactionToKennelClubDogShow [1.10.j Other (please specify) Desc],
	/*----To a fun dog show----*/
	pvtrfds.[1] [1.10.k Was interested but stayed calm],
	pvtrfds.[2] [1.10.k Was disinterested/didn't react],
	pvtrfds.[3] [1.10.k Held tail down between his/her legs],
	pvtrfds.[4] [1.10.k Became excited],
	pvtrfds.[5] [1.10.k Explored or sniffed],
	pvtrfds.[6] [1.10.k Pined, whined, or cried],
	pvtrfds.[7] [1.10.k Froze or stayed still],
	pvtrfds.[8] [1.10.k Trembled or shook],
	pvtrfds.[9] [1.10.k Toileted in an inappropriate location],
	pvtrfds.[10] [1.10.k Pulled/ran away or tried to run away],
	pvtrfds.[11] [1.10.k Raised his/her hackles],
	pvtrfds.[12] [1.10.k Played/tried to play with a dog],
	pvtrfds.[13] [1.10.k Chased a dog],
	pvtrfds.[14] [1.10.k Was chased by a dog],
	pvtrfds.[15] [1.10.k Barked at a person],
	pvtrfds.[16] [1.10.k Barked at a dog],
	pvtrfds.[17] [1.10.k Growled/snarled at a person],
	pvtrfds.[18] [1.10.k Growled/snarled at a dog],
	pvtrfds.[19] [1.10.k Snarled/raised upper lip at a person],
	pvtrfds.[20] [1.10.k Snarled/raised upper lip at a dog],
	pvtrfds.[21] [1.10.k Snapped at/bit a person],
	pvtrfds.[22] [1.10.k Snapped at/bit a dog],
	pvtrfds.[23] [1.10.k Was snapped at/bitten by other dog],
	pvtrfds.[24] [1.10.k I don’t know/can’t remember],
	pvtrfds.[25] [1.10.k Other (please specify) ID],
	s.otherRecentlyBeenReactionToFunDogShow [1.10.k Other (please specify) Desc],
	/*----To Flyball training----*/
	pvtrft.[1] [1.10.l Was interested but stayed calm],
	pvtrft.[2] [1.10.l Was disinterested/didn't react],
	pvtrft.[3] [1.10.l Held tail down between his/her legs],
	pvtrft.[4] [1.10.l Became excited],
	pvtrft.[5] [1.10.l Explored or sniffed],
	pvtrft.[6] [1.10.l Pined, whined, or cried],
	pvtrft.[7] [1.10.l Froze or stayed still],
	pvtrft.[8] [1.10.l Trembled or shook],
	pvtrft.[9] [1.10.l Toileted in an inappropriate location],
	pvtrft.[10] [1.10.l Pulled/ran away or tried to run away],
	pvtrft.[11] [1.10.l Raised his/her hackles],
	pvtrft.[12] [1.10.l Played/tried to play with a dog],
	pvtrft.[13] [1.10.l Chased a dog],
	pvtrft.[14] [1.10.l Was chased by a dog],
	pvtrft.[15] [1.10.l Barked at a person],
	pvtrft.[16] [1.10.l Barked at a dog],
	pvtrft.[17] [1.10.l Growled/snarled at a person],
	pvtrft.[18] [1.10.l Growled/snarled at a dog],
	pvtrft.[19] [1.10.l Snarled/raised upper lip at a person],
	pvtrft.[20] [1.10.l Snarled/raised upper lip at a dog],
	pvtrft.[21] [1.10.l Snapped at/bit a person],
	pvtrft.[22] [1.10.l Snapped at/bit a dog],
	pvtrft.[23] [1.10.l Was snapped at/bitten by other dog],
	pvtrft.[24] [1.10.l I don’t know/can’t remember],
	pvtrft.[25] [1.10.l Other (please specify) ID],
	s.otherRecentlyBeenReactionToFlyballTraining [1.10.l Other (please specify) Desc],
	/*----To a Flyball competition----*/
	pvtrfc.[1] [1.10.m Was interested but stayed calm],
	pvtrfc.[2] [1.10.m Was disinterested/didn't react],
	pvtrfc.[3] [1.10.m Held tail down between his/her legs],
	pvtrfc.[4] [1.10.m Became excited],
	pvtrfc.[5] [1.10.m Explored or sniffed],
	pvtrfc.[6] [1.10.m Pined, whined, or cried],
	pvtrfc.[7] [1.10.m Froze or stayed still],
	pvtrfc.[8] [1.10.m Trembled or shook],
	pvtrfc.[9] [1.10.m Toileted in an inappropriate location],
	pvtrfc.[10] [1.10.m Pulled/ran away or tried to run away],
	pvtrfc.[11] [1.10.m Raised his/her hackles],
	pvtrfc.[12] [1.10.m Played/tried to play with a dog],
	pvtrfc.[13] [1.10.m Chased a dog],
	pvtrfc.[14] [1.10.m Was chased by a dog],
	pvtrfc.[15] [1.10.m Barked at a person],
	pvtrfc.[16] [1.10.m Barked at a dog],
	pvtrfc.[17] [1.10.m Growled/snarled at a person],
	pvtrfc.[18] [1.10.m Growled/snarled at a dog],
	pvtrfc.[19] [1.10.m Snarled/raised upper lip at a person],
	pvtrfc.[20] [1.10.m Snarled/raised upper lip at a dog],
	pvtrfc.[21] [1.10.m Snapped at/bit a person],
	pvtrfc.[22] [1.10.m Snapped at/bit a dog],
	pvtrfc.[23] [1.10.m Was snapped at/bitten by other dog],
	pvtrfc.[24] [1.10.m I don’t know/can’t remember],
	pvtrfc.[25] [1.10.m Other (please specify) ID],
	s.otherRecentlyBeenReactionToFlyballCompetition [1.10.m Other (please specify) Desc],
	/*----To agility training----*/
	pvtrat.[1] [1.10.n Was interested but stayed calm],
	pvtrat.[2] [1.10.n Was disinterested/didn't react],
	pvtrat.[3] [1.10.n Held tail down between his/her legs],
	pvtrat.[4] [1.10.n Became excited],
	pvtrat.[5] [1.10.n Explored or sniffed],
	pvtrat.[6] [1.10.n Pined, whined, or cried],
	pvtrat.[7] [1.10.n Froze or stayed still],
	pvtrat.[8] [1.10.n Trembled or shook],
	pvtrat.[9] [1.10.n Toileted in an inappropriate location],
	pvtrat.[10] [1.10.n Pulled/ran away or tried to run away],
	pvtrat.[11] [1.10.n Raised his/her hackles],
	pvtrat.[12] [1.10.n Played/tried to play with a dog],
	pvtrat.[13] [1.10.n Chased a dog],
	pvtrat.[14] [1.10.n Was chased by a dog],
	pvtrat.[15] [1.10.n Barked at a person],
	pvtrat.[16] [1.10.n Barked at a dog],
	pvtrat.[17] [1.10.n Growled/snarled at a person],
	pvtrat.[18] [1.10.n Growled/snarled at a dog],
	pvtrat.[19] [1.10.n Snarled/raised upper lip at a person],
	pvtrat.[20] [1.10.n Snarled/raised upper lip at a dog],
	pvtrat.[21] [1.10.n Snapped at/bit a person],
	pvtrat.[22] [1.10.n Snapped at/bit a dog],
	pvtrat.[23] [1.10.n Was snapped at/bitten by other dog],
	pvtrat.[24] [1.10.n I don’t know/can’t remember],
	pvtrat.[25] [1.10.n Other (please specify) ID],
	s.otherRecentlyBeenReactionToAgilityTraining [1.10.n Other (please specify) Desc],
	/*----To an agility competition----*/
	pvtragcomp.[1] [1.10.o Was interested but stayed calm],
	pvtragcomp.[2] [1.10.o Was disinterested/didn't react],
	pvtragcomp.[3] [1.10.o Held tail down between his/her legs],
	pvtragcomp.[4] [1.10.o Became excited],
	pvtragcomp.[5] [1.10.o Explored or sniffed],
	pvtragcomp.[6] [1.10.o Pined, whined, or cried],
	pvtragcomp.[7] [1.10.o Froze or stayed still],
	pvtragcomp.[8] [1.10.o Trembled or shook],
	pvtragcomp.[9] [1.10.o Toileted in an inappropriate location],
	pvtragcomp.[10] [1.10.o Pulled/ran away or tried to run away],
	pvtragcomp.[11] [1.10.o Raised his/her hackles],
	pvtragcomp.[12] [1.10.o Played/tried to play with a dog],
	pvtragcomp.[13] [1.10.o Chased a dog],
	pvtragcomp.[14] [1.10.o Was chased by a dog],
	pvtragcomp.[15] [1.10.o Barked at a person],
	pvtragcomp.[16] [1.10.o Barked at a dog],
	pvtragcomp.[17] [1.10.o Growled/snarled at a person],
	pvtragcomp.[18] [1.10.o Growled/snarled at a dog],
	pvtragcomp.[19] [1.10.o Snarled/raised upper lip at a person],
	pvtragcomp.[20] [1.10.o Snarled/raised upper lip at a dog],
	pvtragcomp.[21] [1.10.o Snapped at/bit a person],
	pvtragcomp.[22] [1.10.o Snapped at/bit a dog],
	pvtragcomp.[23] [1.10.o Was snapped at/bitten by other dog],
	pvtragcomp.[24] [1.10.o I don’t know/can’t remember],
	pvtragcomp.[25] [1.10.o Other (please specify) ID],
	s.otherRecentlyBeenReactionToAgilityCompetition [1.10.o Other (please specify) Desc],
	/*----To work with me----*/
	pvtrwrk.[1] [1.10.p Was interested but stayed calm],
	pvtrwrk.[2] [1.10.p Was disinterested/didn't react],
	pvtrwrk.[3] [1.10.p Held tail down between his/her legs],
	pvtrwrk.[4] [1.10.p Became excited],
	pvtrwrk.[5] [1.10.p Explored or sniffed],
	pvtrwrk.[6] [1.10.p Pined, whined, or cried],
	pvtrwrk.[7] [1.10.p Froze or stayed still],
	pvtrwrk.[8] [1.10.p Trembled or shook],
	pvtrwrk.[9] [1.10.p Toileted in an inappropriate location],
	pvtrwrk.[10] [1.10.p Pulled/ran away or tried to run away],
	pvtrwrk.[11] [1.10.p Raised his/her hackles],
	pvtrwrk.[12] [1.10.p Played/tried to play with a dog],
	pvtrwrk.[13] [1.10.p Chased a dog],
	pvtrwrk.[14] [1.10.p Was chased by a dog],
	pvtrwrk.[15] [1.10.p Barked at a person],
	pvtrwrk.[16] [1.10.p Barked at a dog],
	pvtrwrk.[17] [1.10.p Growled/snarled at a person],
	pvtrwrk.[18] [1.10.p Growled/snarled at a dog],
	pvtrwrk.[19] [1.10.p Snarled/raised upper lip at a person],
	pvtrwrk.[20] [1.10.p Snarled/raised upper lip at a dog],
	pvtrwrk.[21] [1.10.p Snapped at/bit a person],
	pvtrwrk.[22] [1.10.p Snapped at/bit a dog],
	pvtrwrk.[23] [1.10.p Was snapped at/bitten by other dog],
	pvtrwrk.[24] [1.10.p I don’t know/can’t remember],
	pvtrwrk.[25] [1.10.p Other (please specify) ID],
	s.otherRecentlyBeenReactionToWork [1.10.p Other (please specify) Desc],
	/*----To stay on a campsite----*/
	pvtrcamp.[1] [1.10.q Was interested but stayed calm],
	pvtrcamp.[2] [1.10.q Was disinterested/didn't react],
	pvtrcamp.[3] [1.10.q Held tail down between his/her legs],
	pvtrcamp.[4] [1.10.q Became excited],
	pvtrcamp.[5] [1.10.q Explored or sniffed],
	pvtrcamp.[6] [1.10.q Pined, whined, or cried],
	pvtrcamp.[7] [1.10.q Froze or stayed still],
	pvtrcamp.[8] [1.10.q Trembled or shook],
	pvtrcamp.[9] [1.10.q Toileted in an inappropriate location],
	pvtrcamp.[10] [1.10.q Pulled/ran away or tried to run away],
	pvtrcamp.[11] [1.10.q Raised his/her hackles],
	pvtrcamp.[12] [1.10.q Played/tried to play with a dog],
	pvtrcamp.[13] [1.10.q Chased a dog],
	pvtrcamp.[14] [1.10.q Was chased by a dog],
	pvtrcamp.[15] [1.10.q Barked at a person],
	pvtrcamp.[16] [1.10.q Barked at a dog],
	pvtrcamp.[17] [1.10.q Growled/snarled at a person],
	pvtrcamp.[18] [1.10.q Growled/snarled at a dog],
	pvtrcamp.[19] [1.10.q Snarled/raised upper lip at a person],
	pvtrcamp.[20] [1.10.q Snarled/raised upper lip at a dog],
	pvtrcamp.[21] [1.10.q Snapped at/bit a person],
	pvtrcamp.[22] [1.10.q Snapped at/bit a dog],
	pvtrcamp.[23] [1.10.q Was snapped at/bitten by other dog],
	pvtrcamp.[24] [1.10.q I don’t know/can’t remember],
	pvtrcamp.[25] [1.10.q Other (please specify) ID],
	s.otherRecentlyBeenReactionToCampsite [1.10.q Other (please specify) Desc],
	/*----Running/jogging with me (on the lead)----*/
	pvtrron.[1] [1.10.r Was interested but stayed calm],
	pvtrron.[2] [1.10.r Was disinterested/didn't react],
	pvtrron.[3] [1.10.r Held tail down between his/her legs],
	pvtrron.[4] [1.10.r Became excited],
	pvtrron.[5] [1.10.r Explored or sniffed],
	pvtrron.[6] [1.10.r Pined, whined, or cried],
	pvtrron.[7] [1.10.r Froze or stayed still],
	pvtrron.[8] [1.10.r Trembled or shook],
	pvtrron.[9] [1.10.r Toileted in an inappropriate location],
	pvtrron.[10] [1.10.r Pulled/ran away or tried to run away],
	pvtrron.[11] [1.10.r Raised his/her hackles],
	pvtrron.[12] [1.10.r Played/tried to play with a dog],
	pvtrron.[13] [1.10.r Chased a dog],
	pvtrron.[14] [1.10.r Was chased by a dog],
	pvtrron.[15] [1.10.r Barked at a person],
	pvtrron.[16] [1.10.r Barked at a dog],
	pvtrron.[17] [1.10.r Growled/snarled at a person],
	pvtrron.[18] [1.10.r Growled/snarled at a dog],
	pvtrron.[19] [1.10.r Snarled/raised upper lip at a person],
	pvtrron.[20] [1.10.r Snarled/raised upper lip at a dog],
	pvtrron.[21] [1.10.r Snapped at/bit a person],
	pvtrron.[22] [1.10.r Snapped at/bit a dog],
	pvtrron.[23] [1.10.r Was snapped at/bitten by other dog],
	pvtrron.[24] [1.10.r I don’t know/can’t remember],
	pvtrron.[25] [1.10.r Other (please specify) ID],
	s.otherRecentlyBeenReactionToRunningOn [1.10.r Other (please specify) Desc],
	/*----Running/jogging with me (off the lead)----*/
	pvtrroff.[1] [1.10.s Was interested but stayed calm],
	pvtrroff.[2] [1.10.s Was disinterested/didn't react],
	pvtrroff.[3] [1.10.s Held tail down between his/her legs],
	pvtrroff.[4] [1.10.s Became excited],
	pvtrroff.[5] [1.10.s Explored or sniffed],
	pvtrroff.[6] [1.10.s Pined, whined, or cried],
	pvtrroff.[7] [1.10.s Froze or stayed still],
	pvtrroff.[8] [1.10.s Trembled or shook],
	pvtrroff.[9] [1.10.s Toileted in an inappropriate location],
	pvtrroff.[10] [1.10.s Pulled/ran away or tried to run away],
	pvtrroff.[11] [1.10.s Raised his/her hackles],
	pvtrroff.[12] [1.10.s Played/tried to play with a dog],
	pvtrroff.[13] [1.10.s Chased a dog],
	pvtrroff.[14] [1.10.s Was chased by a dog],
	pvtrroff.[15] [1.10.s Barked at a person],
	pvtrroff.[16] [1.10.s Barked at a dog],
	pvtrroff.[17] [1.10.s Growled/snarled at a person],
	pvtrroff.[18] [1.10.s Growled/snarled at a dog],
	pvtrroff.[19] [1.10.s Snarled/raised upper lip at a person],
	pvtrroff.[20] [1.10.s Snarled/raised upper lip at a dog],
	pvtrroff.[21] [1.10.s Snapped at/bit a person],
	pvtrroff.[22] [1.10.s Snapped at/bit a dog],
	pvtrroff.[23] [1.10.s Was snapped at/bitten by other dog],
	pvtrroff.[24] [1.10.s I don’t know/can’t remember],
	pvtrroff.[25] [1.10.s Other (please specify) ID],
	s.otherRecentlyBeenReactionToRunningOff [1.10.s Other (please specify) Desc],
	/*----To a canicross competition----*/
	pvtrcccomp.[1] [1.10.t Was interested but stayed calm],
	pvtrcccomp.[2] [1.10.t Was disinterested/didn't react],
	pvtrcccomp.[3] [1.10.t Held tail down between his/her legs],
	pvtrcccomp.[4] [1.10.t Became excited],
	pvtrcccomp.[5] [1.10.t Explored or sniffed],
	pvtrcccomp.[6] [1.10.t Pined, whined, or cried],
	pvtrcccomp.[7] [1.10.t Froze or stayed still],
	pvtrcccomp.[8] [1.10.t Trembled or shook],
	pvtrcccomp.[9] [1.10.t Toileted in an inappropriate location],
	pvtrcccomp.[10] [1.10.t Pulled/ran away or tried to run away],
	pvtrcccomp.[11] [1.10.t Raised his/her hackles],
	pvtrcccomp.[12] [1.10.t Played/tried to play with a dog],
	pvtrcccomp.[13] [1.10.t Chased a dog],
	pvtrcccomp.[14] [1.10.t Was chased by a dog],
	pvtrcccomp.[15] [1.10.t Barked at a person],
	pvtrcccomp.[16] [1.10.t Barked at a dog],
	pvtrcccomp.[17] [1.10.t Growled/snarled at a person],
	pvtrcccomp.[18] [1.10.t Growled/snarled at a dog],
	pvtrcccomp.[19] [1.10.t Snarled/raised upper lip at a person],
	pvtrcccomp.[20] [1.10.t Snarled/raised upper lip at a dog],
	pvtrcccomp.[21] [1.10.t Snapped at/bit a person],
	pvtrcccomp.[22] [1.10.t Snapped at/bit a dog],
	pvtrcccomp.[23] [1.10.t Was snapped at/bitten by other dog],
	pvtrcccomp.[24] [1.10.t I don’t know/can’t remember],
	pvtrcccomp.[25] [1.10.t Other (please specify) ID],
	s.otherRecentlyBeenReactionToCanicross [1.10.t Other (please specify) Desc],
	/*----To ringcraft (in preparation for showing at dog shows)----*/
	pvtrrc.[1] [1.10.u Was interested but stayed calm],
	pvtrrc.[2] [1.10.u Was disinterested/didn't react],
	pvtrrc.[3] [1.10.u Held tail down between his/her legs],
	pvtrrc.[4] [1.10.u Became excited],
	pvtrrc.[5] [1.10.u Explored or sniffed],
	pvtrrc.[6] [1.10.u Pined, whined, or cried],
	pvtrrc.[7] [1.10.u Froze or stayed still],
	pvtrrc.[8] [1.10.u Trembled or shook],
	pvtrrc.[9] [1.10.u Toileted in an inappropriate location],
	pvtrrc.[10] [1.10.u Pulled/ran away or tried to run away],
	pvtrrc.[11] [1.10.u Raised his/her hackles],
	pvtrrc.[12] [1.10.u Played/tried to play with a dog],
	pvtrrc.[13] [1.10.u Chased a dog],
	pvtrrc.[14] [1.10.u Was chased by a dog],
	pvtrrc.[15] [1.10.u Barked at a person],
	pvtrrc.[16] [1.10.u Barked at a dog],
	pvtrrc.[17] [1.10.u Growled/snarled at a person],
	pvtrrc.[18] [1.10.u Growled/snarled at a dog],
	pvtrrc.[19] [1.10.u Snarled/raised upper lip at a person],
	pvtrrc.[20] [1.10.u Snarled/raised upper lip at a dog],
	pvtrrc.[21] [1.10.u Snapped at/bit a person],
	pvtrrc.[22] [1.10.u Snapped at/bit a dog],
	pvtrrc.[23] [1.10.u Was snapped at/bitten by other dog],
	pvtrrc.[24] [1.10.u I don’t know/can’t remember],
	pvtrrc.[25] [1.10.u Other (please specify) ID],
	s.otherRecentlyBeenReactionToRingCraft [1.10.u Other (please specify) Desc],
	/*----To heel work to music----*/
	pvtrhl.[1] [1.10.v Was interested but stayed calm],
	pvtrhl.[2] [1.10.v Was disinterested/didn't react],
	pvtrhl.[3] [1.10.v Held tail down between his/her legs],
	pvtrhl.[4] [1.10.v Became excited],
	pvtrhl.[5] [1.10.v Explored or sniffed],
	pvtrhl.[6] [1.10.v Pined, whined, or cried],
	pvtrhl.[7] [1.10.v Froze or stayed still],
	pvtrhl.[8] [1.10.v Trembled or shook],
	pvtrhl.[9] [1.10.v Toileted in an inappropriate location],
	pvtrhl.[10] [1.10.v Pulled/ran away or tried to run away],
	pvtrhl.[11] [1.10.v Raised his/her hackles],
	pvtrhl.[12] [1.10.v Played/tried to play with a dog],
	pvtrhl.[13] [1.10.v Chased a dog],
	pvtrhl.[14] [1.10.v Was chased by a dog],
	pvtrhl.[15] [1.10.v Barked at a person],
	pvtrhl.[16] [1.10.v Barked at a dog],
	pvtrhl.[17] [1.10.v Growled/snarled at a person],
	pvtrhl.[18] [1.10.v Growled/snarled at a dog],
	pvtrhl.[19] [1.10.v Snarled/raised upper lip at a person],
	pvtrhl.[20] [1.10.v Snarled/raised upper lip at a dog],
	pvtrhl.[21] [1.10.v Snapped at/bit a person],
	pvtrhl.[22] [1.10.v Snapped at/bit a dog],
	pvtrhl.[23] [1.10.v Was snapped at/bitten by other dog],
	pvtrhl.[24] [1.10.v I don’t know/can’t remember],
	pvtrhl.[25] [1.10.v Other (please specify) ID],
	s.otherRecentlyBeenReactionToHeel [1.10.v Other (please specify) Desc],
	/*----To gundog training classes----*/
	pvtrgdc.[1] [1.10.w Was interested but stayed calm],
	pvtrgdc.[2] [1.10.w Was disinterested/didn't react],
	pvtrgdc.[3] [1.10.w Held tail down between his/her legs],
	pvtrgdc.[4] [1.10.w Became excited],
	pvtrgdc.[5] [1.10.w Explored or sniffed],
	pvtrgdc.[6] [1.10.w Pined, whined, or cried],
	pvtrgdc.[7] [1.10.w Froze or stayed still],
	pvtrgdc.[8] [1.10.w Trembled or shook],
	pvtrgdc.[9] [1.10.w Toileted in an inappropriate location],
	pvtrgdc.[10] [1.10.w Pulled/ran away or tried to run away],
	pvtrgdc.[11] [1.10.w Raised his/her hackles],
	pvtrgdc.[12] [1.10.w Played/tried to play with a dog],
	pvtrgdc.[13] [1.10.w Chased a dog],
	pvtrgdc.[14] [1.10.w Was chased by a dog],
	pvtrgdc.[15] [1.10.w Barked at a person],
	pvtrgdc.[16] [1.10.w Barked at a dog],
	pvtrgdc.[17] [1.10.w Growled/snarled at a person],
	pvtrgdc.[18] [1.10.w Growled/snarled at a dog],
	pvtrgdc.[19] [1.10.w Snarled/raised upper lip at a person],
	pvtrgdc.[20] [1.10.w Snarled/raised upper lip at a dog],
	pvtrgdc.[21] [1.10.w Snapped at/bit a person],
	pvtrgdc.[22] [1.10.w Snapped at/bit a dog],
	pvtrgdc.[23] [1.10.w Was snapped at/bitten by other dog],
	pvtrgdc.[24] [1.10.w I don’t know/can’t remember],
	pvtrgdc.[25] [1.10.w Other (please specify) ID],
	s.otherRecentlyBeenReactionToGundogClasses [1.10.w Other (please specify) Desc],
	/*----To another activity or event…(please specify)----*/
	pvtroth.[1] [1.10.x Was interested but stayed calm],
	pvtroth.[2] [1.10.x Was disinterested/didn't react],
	pvtroth.[3] [1.10.x Held tail down between his/her legs],
	pvtroth.[4] [1.10.x Became excited],
	pvtroth.[5] [1.10.x Explored or sniffed],
	pvtroth.[6] [1.10.x Pined, whined, or cried],
	pvtroth.[7] [1.10.x Froze or stayed still],
	pvtroth.[8] [1.10.x Trembled or shook],
	pvtroth.[9] [1.10.x Toileted in an inappropriate location],
	pvtroth.[10] [1.10.x Pulled/ran away or tried to run away],
	pvtroth.[11] [1.10.x Raised his/her hackles],
	pvtroth.[12] [1.10.x Played/tried to play with a dog],
	pvtroth.[13] [1.10.x Chased a dog],
	pvtroth.[14] [1.10.x Was chased by a dog],
	pvtroth.[15] [1.10.x Barked at a person],
	pvtroth.[16] [1.10.x Barked at a dog],
	pvtroth.[17] [1.10.x Growled/snarled at a person],
	pvtroth.[18] [1.10.x Growled/snarled at a dog],
	pvtroth.[19] [1.10.x Snarled/raised upper lip at a person],
	pvtroth.[20] [1.10.x Snarled/raised upper lip at a dog],
	pvtroth.[21] [1.10.x Snapped at/bit a person],
	pvtroth.[22] [1.10.x Snapped at/bit a dog],
	pvtroth.[23] [1.10.x Was snapped at/bitten by other dog],
	pvtroth.[24] [1.10.x I don’t know/can’t remember],
	pvtroth.[25] [1.10.x Other (please specify) ID],
	s.otherRecentlyBeenReactionToOther [1.10.x Other (please specify) Desc],

	--2 "Toby" travels in a car/van...
	COALESCE(s.travelsCarVanFrequencyId, '999') [2 Travels in car/van frequency ID],
	tcvf.travelsCarVanFrequencyName [2 Travels in car/van frequency Desc],
	s.otherTravelsCarVanFrequencyDetail [2 Travels in car/van frequency Detail],
	--2.1 Usually, when travelling in a car/van, "Toby"…
	pvttcvb.[1] [2.1 Is interested but stays calm],
	pvttcvb.[2] [2.1 Is disinterested/doesn't react],
	pvttcvb.[3] [2.1 Rests or sleeps],
	pvttcvb.[4] [2.1 Becomes excited],
	pvttcvb.[5] [2.1 Pines, whines, or cries],
	pvttcvb.[6] [2.1 Trembles or shakes],
	pvttcvb.[7] [2.1 Wees/urinates],
	pvttcvb.[8] [2.1 Poos/defaecates],
	pvttcvb.[9] [2.1 Vomits],
	pvttcvb.[10] [2.1 Dribbles/drools],
	pvttcvb.[11] [2.1 I don't know how he/she behaves],
	pvttcvb.[12] [2.1 Other (please specify) ID],
	s.otherTravelsCarVanBehaviourDetail [2.1 Other (please specify) Desc],
	--2.1.1 "Toby" reacts when we reach certain destinations in the car/van (for example the park or house) b
	pvttcvrd.[1] [2.1.1 Barking],
	pvttcvrd.[2] [2.1.1 Whining],
	pvttcvrd.[3] [2.1.1 Hiding/trying to hide (for example under a blanket)],
	pvttcvrd.[4] [2.1.1 Jumping about],
	pvttcvrd.[5] [2.1.1 Pulling/straining against his/her seat belt/restraint],
	pvttcvrd.[6] [2.1.1 Scratching at the car window/door],
	pvttcvrd.[7] [2.1.1 Scratching the floor/door of the crate/cage],
	pvttcvrd.[8] [2.1.1 Not applicable - he/she does not react],
	pvttcvrd.[9] [2.1.1 I don't know how he/she reacts],
	pvttcvrd.[10] [2.1.1 Other (please specify) ID],
	s.otherTravelsCarVanReactionDetail_destinations  [2.1.1 Other (please specify) Desc],
	--2.1.2 "Toby" reacts when passing people in the car/van by…
	pvttcvrp.[1] [2.1.2 Barking],
	pvttcvrp.[2] [2.1.2 Whining],
	pvttcvrp.[3] [2.1.2 Hiding/trying to hide (for example under a blanket)],
	pvttcvrp.[4] [2.1.2 Jumping about],
	pvttcvrp.[5] [2.1.2 Pulling/straining against his/her seat belt/restraint],
	pvttcvrp.[6] [2.1.2 Scratching at the car window/door],
	pvttcvrp.[7] [2.1.2 Scratching the floor/door of the crate/cage],
	pvttcvrp.[8] [2.1.2 Not applicable - he/she does not react],
	pvttcvrp.[9] [2.1.2 I don't know how he/she reacts],
	pvttcvrp.[10] [2.1.2 Other (please specify) ID],
	s.otherTravelsCarVanReactionDetail_passingPeople [2.1.2 Other (please specify) Desc],
	--2.1.3 "Toby" reacts when passing dogs in the car/van by...
	pvttcvrdg.[1] [2.1.3 Barking],
	pvttcvrdg.[2] [2.1.3 Whining],
	pvttcvrdg.[3] [2.1.3 Hiding/trying to hide (for example under a blanket)],
	pvttcvrdg.[4] [2.1.3 Jumping about],
	pvttcvrdg.[5] [2.1.3 Pulling/straining against his/her seat belt/restraint],
	pvttcvrdg.[6] [2.1.3 Scratching at the car window/door],
	pvttcvrdg.[7] [2.1.3 Scratching the floor/door of the crate/cage],
	pvttcvrdg.[8] [2.1.3 Not applicable - he/she does not react],
	pvttcvrdg.[9] [2.1.3 I don't know how he/she reacts],
	pvttcvrdg.[10] [2.1.3 Other (please specify) ID],
	s.otherTravelsCarVanReactionDetail_passingDogs [2.1.3 Other (please specify) Desc],
	--2.2 When travelling in a car/van, "Toby" is most often…
	COALESCE(s.travelsCarVanLocationId, '999')  [2.2 Travel position in car/van ID],
	tcvl.travelsCarVanLocationName [2.2 Travel position in car/van Desc],
	s.otherTravelsCarVanLocationDetail [2.2 Travel position in car/van Detail]

from survey5Years s

--1.1 During the last 12 months, "Toby" has travelled to…(please do not include travel within the country he/she currently lives in)... 
Left join 
	(Select 
		ct.survey5YearsId ID,
		countriesTravelledToName [Location Type],
		cast(ct.countriesTravelledToId as varchar) as 'Location'

	   from survey5Years_referenceCountriesTravelledTo ct

	inner join  referenceCountriesTravelledTo refct

		on refct.countriesTravelledToId = ct.countriesTravelledToId
	) ct 
	PIVOT
	
	(min([Location Type]) For Location
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24])
	) 
	pvtct on pvtct.ID = s.survey5YearsId

--1.2 The country that "Toby" visited most recently was…
Left join 
	(Select 
		cvmr.survey5YearsId ID,
		countryVisitedMostRecentlyName [Location Type],
		cast(cvmr.countryVisitedMostRecentlyId as varchar) as 'Location'

	   from survey5Years_referenceCountryVisitedMostRecently cvmr

	inner join  referenceCountryVisitedMostRecently refcvmr

		on refcvmr.countryVisitedMostRecentlyId = cvmr.countryVisitedMostRecentlyId
	) cvmr 
	PIVOT
	
	(min([Location Type]) For Location
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21])
	) 
	pvtcvmr on pvtcvmr.ID = s.survey5YearsId

--1.3 On his/her most recent trip, "Toby" was abroad for approximately...
left join referenceMostRecentTripTime mrtt
	on mrtt.mostRecentTripTimeId = s.mostRecentTripTimeId

--1.4 His/her most recent abroad trip started in the month of…
left join referenceMostRecentTripStarted mrts
	on mrts.mostRecentTripStartedId = s.mostRecentTripStartedId

--1.5 Before taking "Toby" on his/her most recent trip abroad, he/she was given the following by a vet specifically for his/her travels…
Left join 
	(Select 
		vgb.survey5YearsId ID,
		mostRecentTripVetGaveName [Med Type],
		cast(vgb.mostRecentTripVetGaveId as varchar) as 'Med'

	   from survey5Years_referenceMostRecentTripVetGaveBefore vgb

	inner join  referenceMostRecentTripVetGave refvgb

		on refvgb.mostRecentTripVetGaveId = vgb.mostRecentTripVetGaveId
	) vgb 
	PIVOT
	
	(min([Med Type]) For Med
		IN ([1], [2], [3], [4], [5], [6])
	) 
	pvtvgb on pvtvgb.ID = s.survey5YearsId

--1.6 During "Toby"'s most recent trip abroad, he/she was given the following…
Left join 
	(Select 
		vgd.survey5YearsId ID,
		mostRecentTripVetGaveName [Med Type],
		cast(vgd.mostRecentTripVetGaveId as varchar) as 'Med'

	   from survey5Years_referenceMostRecentTripVetGaveDuring vgd

	inner join  referenceMostRecentTripVetGave refvgd

		on refvgd.mostRecentTripVetGaveId = vgd.mostRecentTripVetGaveId
	) vgd
	PIVOT
	
	(min([Med Type]) For Med
		IN ([1], [2], [3], [4], [5], [6])
	) 
	pvtvgd on pvtvgd.ID = s.survey5YearsId

--1.7 After "Toby"'s most recent trip abroad, he/she was given the following…
Left join 
	(Select 
		vga.survey5YearsId ID,
		mostRecentTripVetGaveName [Med Type],
		cast(vga.mostRecentTripVetGaveId as varchar) as 'Med'

	   from survey5Years_referenceMostRecentTripVetGaveAfter vga

	inner join  referenceMostRecentTripVetGave refvga

		on refvga.mostRecentTripVetGaveId = vga.mostRecentTripVetGaveId
	) vga
	PIVOT
	
	(min([Med Type]) For Med
		IN ([1], [2], [3], [4], [5], [6])
	) 
	pvtvga on pvtvga.ID = s.survey5YearsId

--40 Did "Toby" have any health issues whilst away on and/or on return from his/her most recent trip abroad?
Left join 
	(Select 
		hi.survey5YearsId ID,
		abroadHealthIssues5YearsName [Issue Type],
		cast(hi.abroadHealthIssues5YearsId as varchar) as 'Issue'

	   from survey5Years_referenceAbroadHealthIssues5Years hi

	inner join  referenceAbroadHealthIssues5Years refhi

		on refhi.abroadHealthIssues5YearsId = hi.abroadHealthIssues5YearsId
	) hi
	PIVOT
	
	(min([Issue Type]) For Issue
		IN ([1], [2], [3], [4])
	) 
	pvthi on pvthi.ID = s.survey5YearsId

--1.9 During the last three months, "Toby" has been…
Left join 
	(Select 
		rb.survey5YearsId ID,
		recentlyBeenTypeName [Location Type],
		cast(rb.recentlyBeenTypeId as varchar) as 'Location'

	   from survey5Years_referenceRecentlyBeenType rb

	inner join  referenceRecentlyBeenType refrb

		on refrb.recentlyBeenTypeId = rb.recentlyBeenTypeId
	) rb 
	PIVOT
	
	(min([Location Type]) For Location
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrb on pvtrb.ID = s.survey5YearsId

--1.10 The last time 'Toby' was….(insert relevant text...in a town/city, pub/café, at the beach, at a park etc etc etc), he/she…
/*----Into a town/city----*/
Left join 
	(Select 
		rtwn.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rtwn.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeTown rtwn

	inner join  referenceRecentlyBeenReactionType refrtwn

		on refrtwn.recentlyBeenReactionTypeId = rtwn.recentlyBeenReactionTypeId
	) rtwn 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrtwn on pvtrtwn.ID = s.survey5YearsId
/*----To a park where he/she saw other dogs off the lead----*/
Left join 
	(Select 
		rPrk.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rPrk.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypePark rPrk

	inner join  referenceRecentlyBeenReactionType refrrPrk

		on refrrPrk.recentlyBeenReactionTypeId = rPrk.recentlyBeenReactionTypeId
	) rPrk 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrPrk on pvtrPrk.ID = s.survey5YearsId
/*----To the beach----*/
Left join 
	(Select 
		rbch.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rbch.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeBeach rbch

	inner join  referenceRecentlyBeenReactionType refrbch

		on refrbch.recentlyBeenReactionTypeId = rbch.recentlyBeenReactionTypeId
	) rbch 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrbch on pvtrbch.ID = s.survey5YearsId
/*----On a bus----*/
Left join 
	(Select 
		rbus.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rbus.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeBus rbus

	inner join  referenceRecentlyBeenReactionType refrbus

		on refrbus.recentlyBeenReactionTypeId = rbus.recentlyBeenReactionTypeId
	) rbus 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrbus on pvtrbus.ID = s.survey5YearsId
/*----On a train----*/
Left join 
	(Select 
		rtrn.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rtrn.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeTrain rtrn

	inner join  referenceRecentlyBeenReactionType refrtrn

		on refrtrn.recentlyBeenReactionTypeId = rtrn.recentlyBeenReactionTypeId
	) rtrn 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrtrn on pvtrtrn.ID = s.survey5YearsId
/*----Into a pub/café----*/
Left join 
	(Select 
		rpub.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rpub.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypePub rpub

	inner join  referenceRecentlyBeenReactionType refrpub

		on refrpub.recentlyBeenReactionTypeId = rpub.recentlyBeenReactionTypeId
	) rpub 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrpub on pvtrpub.ID = s.survey5YearsId
/*----To adult dog training classes----*/
Left join 
	(Select 
		rac.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rac.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeAdultClasses rac

	inner join  referenceRecentlyBeenReactionType refrac

		on refrac.recentlyBeenReactionTypeId = rac.recentlyBeenReactionTypeId
	) rac 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrac on pvtrac.ID = s.survey5YearsId
/*----To a country show----*/
Left join 
	(Select 
		rcs.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rcs.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeCountryShow rcs

	inner join  referenceRecentlyBeenReactionType refrcs

		on refrcs.recentlyBeenReactionTypeId = rcs.recentlyBeenReactionTypeId
	) rcs 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrcs on pvtrcs.ID = s.survey5YearsId
/*----To a village fete----*/
Left join 
	(Select 
		rvf.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rvf.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeFete rvf

	inner join  referenceRecentlyBeenReactionType refrvf

		on refrvf.recentlyBeenReactionTypeId = rvf.recentlyBeenReactionTypeId
	) rvf 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrvf on pvtrvf.ID = s.survey5YearsId
/*----To a Kennel Club dog show----*/
Left join 
	(Select 
		rkcds.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rkcds.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeKennelClubDogShow rkcds

	inner join  referenceRecentlyBeenReactionType refrkcds

		on refrkcds.recentlyBeenReactionTypeId = rkcds.recentlyBeenReactionTypeId
	) rkcds 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrkcds on pvtrkcds.ID = s.survey5YearsId
/*----To a fun dog show----*/
Left join 
	(Select 
		rfds.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rfds.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeFunDogShow rfds

	inner join  referenceRecentlyBeenReactionType refrfds

		on refrfds.recentlyBeenReactionTypeId = rfds.recentlyBeenReactionTypeId
	) rfds 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrfds on pvtrfds.ID = s.survey5YearsId
/*----To Flyball training----*/
Left join 
	(Select 
		rft.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rft.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeFlyballTraining rft

	inner join  referenceRecentlyBeenReactionType refrft

		on refrft.recentlyBeenReactionTypeId = rft.recentlyBeenReactionTypeId
	) rft 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrft on pvtrft.ID = s.survey5YearsId
/*----To a Flyball competition----*/
Left join 
	(Select 
		rfc.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rfc.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeFlyballCompetition rfc

	inner join  referenceRecentlyBeenReactionType refrfc

		on refrfc.recentlyBeenReactionTypeId = rfc.recentlyBeenReactionTypeId
	) rfc 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrfc on pvtrfc.ID = s.survey5YearsId
/*----To agility training----*/
Left join 
	(Select 
		rat.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rat.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeAgilityTraining rat

	inner join  referenceRecentlyBeenReactionType refrat

		on refrat.recentlyBeenReactionTypeId = rat.recentlyBeenReactionTypeId
	) rat 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrat on pvtrat.ID = s.survey5YearsId
/*----To an agility competition----*/
Left join 
	(Select 
		ragcomp.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(ragcomp.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeAgilityCompetition ragcomp

	inner join  referenceRecentlyBeenReactionType refragcomp

		on refragcomp.recentlyBeenReactionTypeId = ragcomp.recentlyBeenReactionTypeId
	) ragcomp 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtragcomp on pvtragcomp.ID = s.survey5YearsId
/*----To work with me----*/
Left join 
	(Select 
		rwrk.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rwrk.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeWork rwrk

	inner join  referenceRecentlyBeenReactionType refrwrk

		on refrwrk.recentlyBeenReactionTypeId = rwrk.recentlyBeenReactionTypeId
	) rwrk 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrwrk on pvtrwrk.ID = s.survey5YearsId
/*----To stay on a campsite----*/
Left join 
	(Select 
		rcamp.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rcamp.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeCampsite rcamp

	inner join  referenceRecentlyBeenReactionType refrcamp

		on refrcamp.recentlyBeenReactionTypeId = rcamp.recentlyBeenReactionTypeId
	) rcamp 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrcamp on pvtrcamp.ID = s.survey5YearsId
/*----Running/jogging with me (on the lead)----*/
Left join 
	(Select 
		rron.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rron.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeRunningOn rron

	inner join  referenceRecentlyBeenReactionType refrron

		on refrron.recentlyBeenReactionTypeId = rron.recentlyBeenReactionTypeId
	) rron
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrron on pvtrron.ID = s.survey5YearsId
/*----Running/jogging with me (off the lead)----*/
Left join 
	(Select 
		rroff.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rroff.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeRunningOff rroff

	inner join  referenceRecentlyBeenReactionType refrroff

		on refrroff.recentlyBeenReactionTypeId = rroff.recentlyBeenReactionTypeId
	) rroff 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrroff on pvtrroff.ID = s.survey5YearsId
/*----To a canicross competition----*/
Left join 
	(Select 
		rcccomp.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rcccomp.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeCanicross rcccomp

	inner join  referenceRecentlyBeenReactionType refrcccomp

		on refrcccomp.recentlyBeenReactionTypeId = rcccomp.recentlyBeenReactionTypeId
	) rcccomp 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrcccomp on pvtrcccomp.ID = s.survey5YearsId
/*----To ringcraft (in preparation for showing at dog shows)----*/
Left join 
	(Select 
		rrc.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rrc.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeRingCraft rrc

	inner join  referenceRecentlyBeenReactionType refrrc

		on refrrc.recentlyBeenReactionTypeId = rrc.recentlyBeenReactionTypeId
	) rrc 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrrc on pvtrrc.ID = s.survey5YearsId
/*----To heel work to music----*/
Left join 
	(Select 
		rhl.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rhl.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeHeel rhl

	inner join  referenceRecentlyBeenReactionType refrhl

		on refrhl.recentlyBeenReactionTypeId = rhl.recentlyBeenReactionTypeId
	) rhl 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrhl on pvtrhl.ID = s.survey5YearsId
/*----To gundog training classes----*/
Left join 
	(Select 
		rgdc.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(rgdc.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeGundogClasses rgdc

	inner join  referenceRecentlyBeenReactionType refrgdc

		on refrgdc.recentlyBeenReactionTypeId = rgdc.recentlyBeenReactionTypeId
	) rgdc 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtrgdc on pvtrgdc.ID = s.survey5YearsId
/*----To another activity or event…(please specify)----*/
Left join 
	(Select 
		roth.survey5YearsId ID,
		recentlyBeenReactionTypeName [Reaction Type],
		cast(roth.recentlyBeenReactionTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceRecentlyBeenReactionTypeOther roth

	inner join  referenceRecentlyBeenReactionType refroth

		on refroth.recentlyBeenReactionTypeId = roth.recentlyBeenReactionTypeId
	) roth 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25])
	) 
	pvtroth on pvtroth.ID = s.survey5YearsId


--2 "Toby" travels in a car/van...
left join referenceTravelsCarVanFrequency tcvf
	on tcvf.travelsCarVanFrequencyId = s.travelsCarVanFrequencyId

--2.1 Usually, when travelling in a car/van, "Toby"…
Left join 
	(Select 
		tcvb.survey5YearsId ID,
		travelsCarVanBehaviourName [Behaviour Type],
		cast(tcvb.travelsCarVanBehaviourId as varchar) as 'Behaviour'

	   from survey5Years_referenceTravelsCarVanBehaviour tcvb

	inner join  referenceTravelsCarVanBehaviour reftcvb

		on reftcvb.travelsCarVanBehaviourId = tcvb.travelsCarVanBehaviourId
	) tcvb 
	PIVOT
	
	(min([Behaviour Type]) For Behaviour
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	) 
	pvttcvb on pvttcvb.ID = s.survey5YearsId

--2.1.1 "Toby" reacts when we reach certain destinations in the car/van (for example the park or house) by…
Left join 
	(Select 
		tcvrd.survey5YearsId ID,
		travelsCarVanReactionName [Reaction Type],
		cast(tcvrd.travelsCarVanReactionId as varchar) as 'Reaction'

	   from survey5Years_referenceTravelsCarVanReaction_destinations tcvrd

	inner join  referenceTravelsCarVanReaction reftcvrd

		on reftcvrd.travelsCarVanReactionId = tcvrd.travelsCarVanReactionId
	) tcvrd 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10])
	) 
	pvttcvrd on pvttcvrd.ID = s.survey5YearsId

--2.1.2 "Toby" reacts when passing people in the car/van by…
Left join 
	(Select 
		tcvrp.survey5YearsId ID,
		travelsCarVanReactionName [Reaction Type],
		cast(tcvrp.travelsCarVanReactionId as varchar) as 'Reaction'

	   from survey5Years_referenceTravelsCarVanReaction_passingPeople tcvrp

	inner join  referenceTravelsCarVanReaction reftcvrd

		on reftcvrd.travelsCarVanReactionId = tcvrp.travelsCarVanReactionId
	) tcvrd 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10])
	) 
	pvttcvrp on pvttcvrp.ID = s.survey5YearsId

--2.1.3 "Toby" reacts when passing dogs in the car/van by...
Left join 
	(Select 
		tcvrdg.survey5YearsId ID,
		travelsCarVanReactionName [Reaction Type],
		cast(tcvrdg.travelsCarVanReactionId as varchar) as 'Reaction'

	   from survey5Years_referenceTravelsCarVanReaction_passingDogs tcvrdg

	inner join  referenceTravelsCarVanReaction reftcvrd

		on reftcvrd.travelsCarVanReactionId = tcvrdg.travelsCarVanReactionId
	) tcvrd 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10])
	) 
	pvttcvrdg on pvttcvrdg.ID = s.survey5YearsId

--2.2 When travelling in a car/van, "Toby" is most often…
Left join referenceTravelsCarVanLocation tcvl
	on tcvl.travelsCarVanLocationId = s.travelsCarVanLocationId
	
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


