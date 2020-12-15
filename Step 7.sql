select 
	s.dogId,
	s.userId ,
	s.survey5YearsId [5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
	--Q155 "Toby" is taken for exercise (on and/or off lead) away from our household...
	s.puppyExercisedAwayFromHome [Q155 Exercised away from home ID],
	CASE	
		WHEN s.puppyExercisedAwayFromHome = 0 THEN 'No'
		WHEN s.puppyExercisedAwayFromHome = 1 THEN 'Yes'
	END [Q155 Exercised away from home Desc],
	--Q156 On an average WEEKDAY, "Toby" is usually taken for exercise (on and/or off lead)…
	COALESCE(s.averageWeekdayExerciseLevelId, '999') [Q156 Average Weekday Exercise Level ID],
	exlwd.exerciseLevelTypeName [Q156 Average Weekday Exercise Level Desc],
	--Q157 On an average WEEKDAY the total amount of time that "Toby" is exercised either on or off lead is usually about...
	COALESCE(s.averageWeekdayExerciseTimeId, '999') [Q157 Total Weekday Time Exercised ID],
	extwd.timeExercisedTypeName [Q157 Total Weekday Time Exercised Desc],
	--Q158 Of this, the total amount of time "Toby" is on a short or long lead is...
	COALESCE(s.totalWeekdayExerciseOnLeadTimeId, '999') [Q158 Total Weekday Time Exercised On Lead ID],
	extlwd.timeExercisedTypeName [Q158 Total Weekday Time Exercised On Lead Desc],
	--Q159 On an average WEEKEND day, "Toby" is usually taken for exercise (on and/or off lead)...
	COALESCE(s.averageWeekendExerciseLevelId, '999') [Q159 Average Weekend Excercie Level ID],
	exlwe.exerciseLevelTypeName [Q159 Average Weekend Excercie Level Desc],
	--Q160 On an average WEEKEND day the total amount of time that "Toby" is exercised either on or off lead is usually about...
	COALESCE(s.averageWeekendExerciseTimeId, '999') [Q160 Total Weekdend Time Exercised ID],
	extwe.timeExercisedTypeName [Q160 Total Weekdend Time Exercised Desc],
	--Q161 Of this, the total amount of time "Toby" is on a short or long lead is...
	COALESCE(s.totalWeekendExerciseOnLeadTimeId, '999') [Q161 Total Weekend Time Exercised On Lead ID],
	extlwe.timeExercisedTypeName [Q161 Total Weekend Time Exercised On Lead Desc],
	--Q162 When "Toby" is on a lead, I mostly use...
	COALESCE(s.puppyLeadUseTypeId, '999') [Q162 Lead Used ID],
	lu.puppyLeadUseTypeName [Q162 Lead Used Desc],
	/*----other please specify field to be added when included by 4d----*/
	--Q163 When "Toby" is on a lead, his/her lead is usually...
	COALESCE(s.leadFitTypeId, '999') [Q163 Lead Fit ID],
	ft.leadFitTypeName [Q163 Lead Fit Desc],
	s.otherLeadFitType [Q163 Lead Fit (Other (Please Specify...))],
	--Q164 "Toby" chases sticks that are thrown for him/her...
	COALESCE(s.chasesSticksId, '999') [Q164 Chases Sticks ID],
	cs.chasesSticksName [Q164 Chases Sticks Desc],
	--Q165 "Toby" finds sticks to play with, even if they are not thrown for him/her...
	COALESCE(s.findsSticksNotThrownId, '999') [Q165 Finds Sticks ID],
	fs.findsSticksNotThrownName [Q165 Finds Sticks Desc]
from survey5Years s

--Q156 On an average WEEKDAY, "Toby" is usually taken for exercise (on and/or off lead)…
left join referenceExerciseLevelType exlwd
	on exlwd.exerciseLevelTypeId = s.averageWeekdayExerciseLevelId

--Q157 On an average WEEKDAY the total amount of time that "Toby" is exercised either on or off lead is usually about...
left join referenceTimeExercisedType extwd
	on extwd.timeExercisedTypeId = s.averageWeekdayExerciseTimeId

--Q158 Of this, the total amount of time "Toby" is on a short or long lead is...
left join referenceTimeExercisedType extlwd
	on extlwd.timeExercisedTypeId = s.totalWeekdayExerciseOnLeadTimeId

--Q159 On an average WEEKEND day, "Toby" is usually taken for exercise (on and/or off lead)...
left join referenceExerciseLevelType exlwe
	on exlwe.exerciseLevelTypeId = s.averageWeekendExerciseLevelId

--Q160 On an average WEEKEND day the total amount of time that "Toby" is exercised either on or off lead is usually about...
left join referenceTimeExercisedType extwe
	on extwe.timeExercisedTypeId = s.averageWeekendExerciseTimeId

--Q161 Of this, the total amount of time "Toby" is on a short or long lead is...
left join referenceTimeExercisedType extlwe
	on extlwe.timeExercisedTypeId = s.totalWeekendExerciseOnLeadTimeId

--Q162 When "Toby" is on a lead, I mostly use...
left join referencePuppyLeadUseType lu
	on lu.puppyLeadUseTypeId = s.puppyLeadUseTypeId

--Q163 When "Toby" is on a lead, his/her lead is usually...
left join referenceLeadFitType ft
	on ft.leadFitTypeId = s.leadFitTypeId

--Q164 "Toby" chases sticks that are thrown for him/her...
left join referenceChasesSticks cs
	on cs.chasesSticksId = s.chasesSticksId

--Q165 "Toby" finds sticks to play with, even if they are not thrown for him/her...
left join referenceFindsSticksNotThrown fs
	on fs.findsSticksNotThrownId = s.findsSticksNotThrownId

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