select
  s.dogId,
	s.userId ,
	s.survey5YearsId [5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
  -- 2 "Toby" goes to the wrong side of doors (for example the hinge side)... 
  s.behaviourFrequencyId_wrongSideOfDoors [Q2: Goes Wrong Side of Doors Freq ID],
  bf2.behaviourFrequencyName [Q2: Goes Wrong Side of Doors Freq Desc],
  -- 3 "Toby" gets stuck, cannot navigate around or over obstacles... 
  s.behaviourFrequencyId_getsStuck [Q3: Gets Stuck Freq ID],
  bf3.behaviourFrequencyName [Q3: Gets Stuck Freq Desc],
  -- 4 "Toby" barely reacts/responds to new events or situations... 
  s.behaviourFrequencyId_barelyReacts [Q4: Barely Reacts Freq ID],
  bf4.behaviourFrequencyName [Q4: Barely Reacts Freq Desc],
  -- 5 On an average day, "Toby" comes to me for attention…
  s.behaviourAttentionFrequencyId [Q5: Comes To Me For Attention Freq ID],
  baf.behaviourAttentionFrequencyName [Q5: Comes To Me For Attention Freq Desc],
  -- 6 On an average day, when you arrive home, using a scale of 1 to 5, how enthusiastically does "Toby" greet you?
  s.behaviourEnthusiasmGreetingLevelId [Q6: Average Daily Greeting Enthusiasm Level ID],
  beg.behaviourEnthusiasmGreetingLevelName [Q6: Average Daily Greeting Enthusiasm Level Desc],
  -- 7 On an average day, using a scale of 1 to 5, how often is "Toby" clingy (for example, following you/other household members around)…
  s.behaviourClingyFrequencyId [Q7: Average Daily Clingy Level ID],
  bcf.behaviourClingyFrequencyName [Q7: Average Daily Clingy Level Desc],
  -- 8 Toby stares/fixates/repeatedly snaps or barks at objects...
  s.behaviourFrequencyId_stares [Q8: Stares Freq ID],
  bf8.behaviourFrequencyName [Q8: Stares Freq ID],
  -- 8.1 The object(s) "Toby" stares/fixates/repeatedly snaps or barks at is(/are)...
  pvtbsa.[1] [Q8.1: Shadows],
  pvtbsa.[2] [Q8.1: Lights],
  pvtbsa.[3] [Q8.1: Flies],
  pvtbsa.[4] [Q8.1: Dust],
  pvtbsa.[5] [Q8.1: Reflections],
  pvtbsa.[6] [Q8.1: Walls],
  pvtbsa.[7] [Q8.1: Water or food bowl],
  pvtbsa.[8] [Q8.1: No specific trigger(s) that I can identify],
  pvtburs.[9] [Q8.1: It looks like he/she is reacting to something that isn't there],
  pvtburs.[10] [Q8.1: I'm not sure],
  pvtburs.[11] [Q8.1: Other (please specify) ID],
  s.otherBehaviourStaresAtObjectsTypesName [Q8.1: Other (please specify) Desc],
  -- 8.2 When "Toby" does this behaviour, I usually…
  pvtburs.[1] [Q8.2: Tell him/her off],
  pvtburs.[2] [Q8.2: Physically reprimand/correct him/her (for example smack or tap on nose or bottom)],
  pvtburs.[3] [Q8.2: Verbally reprimand him/her],
  pvtburs.[4] [Q8.2: Distract him/her (for example with a rattled can/loud noise/water spray)],
  pvtburs.[5] [Q8.2: Move away from him/her],
  pvtburs.[6] [Q8.2: Don't give him/her treats that would normally be given at this time],
  pvtburs.[7] [Q8.2: Ignore him/her],
  pvtburs.[8] [Q8.2: Physically manipulate him/her (for example hold still, put into a sit or push down)],
  pvtburs.[9] [Q8.2: Play with him/her],
  pvtburs.[10] [Q8.2: Stroke him/her],
  pvtburs.[11] [Q8.2: Cuddle him/her],
  pvtburs.[12] [Q8.2: Hold him/her still],
  pvtburs.[13] [Q8.2: Encourage him/her to calm down],
  pvtburs.[14] [Q8.2: Move him/her to another part of the house],
  pvtburs.[15] [Q8.2: Let him/her outside into the garden or yard],
  pvtburs.[16] [Q8.2: Give him/her a food treat],
  pvtburs.[17] [Q8.2: Do none of the above],
  pvtburs.[18] [Q8.2: I don't know/can't remember],
  pvtburs.[19] [Q8.2: Other (please specify) ID],
  s.otherBehaviourUsualReactionName_stares [Q8.2: Other (please specify) Desc],
  -- 8.3 I have sought help for this behaviour within the last 12 months….
  s.soughtHelpForThisBehaviour_stares [Q8.3 Sought Help (Staring) ID],
  CASE
    WHEN s.soughtHelpForThisBehaviour_stares = 0 THEN 'No'
    WHEN s.soughtHelpForThisBehaviour_stares = 1 THEN 'Yes'
  END [Q8.3 Sought Help (Staring) Desc],
  -- 8.3.1 I sought help from…
  pvtbshfs.[1] [Q8.3.1: A vet],
  pvtbshfs.[2] [Q8.3.1: A vet who is also a behaviourist],
  pvtbshfs.[3] [Q8.3.1: A behaviourist],
  pvtbshfs.[4] [Q8.3.1: A vet nurse],
  pvtbshfs.[5] [Q8.3.1: Other members of veterinary practice staff],
  pvtbshfs.[6] [Q8.3.1: A dog trainer],
  pvtbshfs.[7] [Q8.3.1: A friend],
  pvtbshfs.[8] [Q8.3.1: Books],
  pvtbshfs.[9] [Q8.3.1: Animal welfare organisation (staff or online resources)],
  pvtbshfs.[10] [Q8.3.1: Online sources not mentioned above - including forums],
  pvtbshfs.[11] [Q8.3.1: I have not sought help],
  pvtbshfs.[12] [Q8.3.1: Other (please specify) ID],
  s.otherBehaviourSoughtHelpFrom_stares [Q8.3.1: Other (please specify) Desc],
  -- 8.3.1.a If you know that the behaviourist and/or dog trainer that you used was a member of a professional organisation, please use this space to tell us the name(s) of the organisation(s)...
  s.behaviourSoughtHelpFromOrgDetails_stares [Q8.3.1.a Sought Help (Staring) - Organisation Details],
  -- 8.3.1.b If you received an explanation or diagnosis for this behaviour please use the space below to provide us with any information you are willing to share (for example diagnosis, recommended treatment, any medication(s))
  s.behaviourSoughtHelpDiagnosisDetails_stares [Q8.3.1.b Sought Help (Staring) - Diagnosis Details],
  -- 8.3.1.c ***If 'Animal welfare organisation (staff or online resources' is selected, then ask Q8.3.1.c
  pvtbshfos.[1] [Q8.3.1.c: Battersea Dogs & Cats Home],
  pvtbshfos.[2] [Q8.3.1.c: Blue Cross],
  pvtbshfos.[3] [Q8.3.1.c: Dogs Trust],
  pvtbshfos.[4] [Q8.3.1.c: PDSA],
  pvtbshfos.[5] [Q8.3.1.c: RSPCA],
  pvtbshfos.[6] [Q8.3.1.c: Other (please specify)… ID],
  s.otherBehaviourSoughtHelpFromOrganisationTypeName_stares [Q8.3.1.c: Other (please specify)… Desc],
  -- 9 Excluding circling prior to lying down or toileting, "Toby" spins in a circle/chases his/her tail... 
  s.behaviourSpinsFrequencyId [Q9: Spins Freq ID],
  bsf.behaviourSpinsFrequencyName [Q9: Spins Freq ID],
  -- 9.1 "Toby" does this when…
  pvtbws.[1] [Q9.1: People are moving around the house],
  pvtbws.[2] [Q9.1: People are preparing to leave the house],
  pvtbws.[3] [Q9.1: Left alone at home (if seen when a household member is leaving or returning to the house)],
  pvtbws.[4] [Q9.1: I'm in the house but busy doing something],
  pvtbws.[5] [Q9.1: He/she is with me/us but not getting attention],
  pvtbws.[6] [Q9.1: Unfamiliar people interact with him/her],
  pvtbws.[7] [Q9.1: Members of the household interact with him/her],
  pvtbws.[8] [Q9.1: I/we tell him/her off],
  pvtbws.[9] [Q9.1: Preparing for going out on a walk],
  pvtbws.[10] [Q9.1: No specific trigger(s) that I can identify],
  pvtbws.[11] [Q9.1: I'm not sure],
  pvtbws.[12] [Q9.1: Other (please specify) ID],
  s.otherBehaviourWhenName_spins [Q9.1: Other (please specify) Desc],
  -- 9.2 When "Toby" does this behaviour, I usually…
  pvtbursp.[1] [Q9.2: Tell him/her off],
  pvtbursp.[2] [Q9.2: Physically reprimand/correct him/her (for example smack or tap on nose or bottom)],
  pvtbursp.[3] [Q9.2: Verbally reprimand him/her],
  pvtbursp.[4] [Q9.2: Distract him/her (for example with a rattled can/loud noise/water spray)],
  pvtbursp.[5] [Q9.2: Move away from him/her],
  pvtbursp.[6] [Q9.2: Don't give him/her treats that would normally be given at this time],
  pvtbursp.[7] [Q9.2: Ignore him/her],
  pvtbursp.[8] [Q9.2: Physically manipulate him/her (for example hold still, put into a sit or push down)],
  pvtbursp.[9] [Q9.2: Play with him/her],
  pvtbursp.[10] [Q9.2: Stroke him/her],
  pvtbursp.[11] [Q9.2: Cuddle him/her],
  pvtbursp.[12] [Q9.2: Hold him/her still],
  pvtbursp.[13] [Q9.2: Encourage him/her to calm down],
  pvtbursp.[14] [Q9.2: Move him/her to another part of the house],
  pvtbursp.[15] [Q9.2: Let him/her outside into the garden or yard],
  pvtbursp.[16] [Q9.2: Give him/her a food treat],
  pvtbursp.[17] [Q9.2: Do none of the above],
  pvtbursp.[18] [Q9.2: I don't know/can't remember],
  pvtbursp.[19] [Q9.2: Other (please specify) ID],  
  s.otherBehaviourUsualReactionName_spins [Q9.2: Other (please specify) Desc], 
  -- 9.3 I have sought help for this behaviour within the last 12 months….
  s.soughtHelpForThisBehaviour_spins [Q9.3 Sought Help (Spins) ID],
  CASE
    WHEN s.soughtHelpForThisBehaviour_spins = 0 THEN 'No'
    WHEN s.soughtHelpForThisBehaviour_spins = 1 THEN 'Yes'
  END [Q9.3 Sought Help (Spins) Desc],
  -- 9.3.1 I sought help from…
  pvtbshfsp.[1] [Q9.3.1: A vet],
  pvtbshfsp.[2] [Q9.3.1: A vet who is also a behaviourist],
  pvtbshfsp.[3] [Q9.3.1: A behaviourist],
  pvtbshfsp.[4] [Q9.3.1: A vet nurse],
  pvtbshfsp.[5] [Q9.3.1: Other members of veterinary practice staff],
  pvtbshfsp.[6] [Q9.3.1: A dog trainer],
  pvtbshfsp.[7] [Q9.3.1: A friend],
  pvtbshfsp.[8] [Q9.3.1: Books],
  pvtbshfsp.[9] [Q9.3.1: Animal welfare organisation (staff or online resources)],
  pvtbshfsp.[10] [Q9.3.1: Online sources not mentioned above - including forums],
  pvtbshfsp.[11] [Q9.3.1: I have not sought help],
  pvtbshfsp.[12] [Q9.3.1: Other (please specify) ID],
  s.otherBehaviourSoughtHelpFrom_spins [Q9.3.1: Other (please specify) Desc],
  -- 9.3.1.a ***If 'a vet who is also a behaviourist', 'behaviourist' and/or 'a dog trainer' are selected, then ask Q9.3.1.a
  s.behaviourSoughtHelpFromOrgDetails_spins [Q9.3.1.a Sought Help (Spins) - Organisation Details],
  -- 9.3.1.b ***If 'a vet who is also a behaviourist', 'behaviourist' and/or 'a dog trainer' are selected, then ask Q9.3.1.b
  s.behaviourSoughtHelpDiagnosisDetails_spins [Q9.3.1.a Sought Help (Spins) - Diagnosis Details],
  -- 9.3.1.c ***If 'Animal welfare organisation (staff or online resources' is selected, then ask Q9.3.1.c
  pvtbshfosp.[1] [Q9.3.1.c: Battersea Dogs & Cats Home],
  pvtbshfosp.[2] [Q9.3.1.c: Blue Cross],
  pvtbshfosp.[3] [Q9.3.1.c: Dogs Trust],
  pvtbshfosp.[4] [Q9.3.1.c: PDSA],
  pvtbshfosp.[5] [Q9.3.1.c: RSPCA],
  pvtbshfosp.[6] [Q9.3.1.c: Other (please specify)… ID],
  s.otherBehaviourSoughtHelpFromOrganisationTypeName_spins [Q9.3.1.c: Other (please specify)… Desc],
  -- 10 "Toby" paces/wanders aimlessly... 
  s.behaviourFrequencyId_paces [Q10: Paces Freq ID],
  bf10.behaviourFrequencyName [Q10: Paces Freq Desc],
  -- 10.1 Toby does this when…
  pvtbwp.[1] [Q10.1: People are moving around the house],
  pvtbwp.[2] [Q10.1: People are preparing to leave the house],
  pvtbwp.[3] [Q10.1: Left alone at home (if seen when a household member is leaving or returning to the house )],
  pvtbwp.[4] [Q10.1: I'm in the house but busy doing something],
  pvtbwp.[5] [Q10.1: He/she is with me/us but not getting attention],
  pvtbwp.[6] [Q10.1: Unfamiliar people interact with him/her],
  pvtbwp.[7] [Q10.1: Members of the household interact with him/her],
  pvtbwp.[8] [Q10.1: I/we tell him/her off],
  pvtbwp.[9] [Q10.1: Preparing for going out on a walk],
  pvtbwp.[10] [Q10.1: No specific trigger(s) that I can identify],
  pvtbwp.[11] [Q10.1: I'm not sure],
  pvtbwp.[12] [Q10.1: Other (please specify) ID],
  s.otherBehaviourWhenName_paces [Q10.1: Other (please specify) Desc],
  -- 10.2 When "Toby" does this behaviour, I usually…
  pvtburp.[1] [Q10.2: Tell him/her off],
  pvtburp.[2] [Q10.2: Physically reprimand/correct him/her (for example smack or tap on nose or bottom)],
  pvtburp.[3] [Q10.2: Verbally reprimand him/her],
  pvtburp.[4] [Q10.2: Distract him/her (for example with a rattled can/loud noise/water spray)],
  pvtburp.[5] [Q10.2: Move away from him/her],
  pvtburp.[6] [Q10.2: Don't give him/her treats that would normally be given at this time],
  pvtburp.[7] [Q10.2: Ignore him/her],
  pvtburp.[8] [Q10.2: Physically manipulate him/her (for example hold still, put into a sit or push down)],
  pvtburp.[9] [Q10.2: Play with him/her],
  pvtburp.[10] [Q10.2: Stroke him/her],
  pvtburp.[11] [Q10.2: Cuddle him/her],
  pvtburp.[12] [Q10.2: Hold him/her still],
  pvtburp.[13] [Q10.2: Encourage him/her to calm down],
  pvtburp.[14] [Q10.2: Move him/her to another part of the house],
  pvtburp.[15] [Q10.2: Let him/her outside into the garden or yard],
  pvtburp.[16] [Q10.2: Give him/her a food treat],
  pvtburp.[17] [Q10.2: Do none of the above],
  pvtburp.[18] [Q10.2: I don't know/can't remember],
  pvtburp.[19] [Q10.2: Other (please specify) ID],  
  s.otherBehaviourUsualReactionName_paces [Q10.2: Other (please specify) Desc],
  -- 10.3 I have sought help for this behaviour within the last 12 months….
  s.soughtHelpForThisBehaviour_paces [Q10.3 Sought Help (Paces) ID],
  CASE
    WHEN s.soughtHelpForThisBehaviour_paces = 0 THEN 'No'
    WHEN s.soughtHelpForThisBehaviour_paces = 1 THEN 'Yes'
  END [Q10.3 Sought Help (Paces) Desc],
  -- 10.3.1 I sought help from…
  pvtbshfp.[1] [Q10.3.1: A vet],
  pvtbshfp.[2] [Q10.3.1: A vet who is also a behaviourist],
  pvtbshfp.[3] [Q10.3.1: A behaviourist],
  pvtbshfp.[4] [Q10.3.1: A vet nurse],
  pvtbshfp.[5] [Q10.3.1: Other members of veterinary practice staff],
  pvtbshfp.[6] [Q10.3.1: A dog trainer],
  pvtbshfp.[7] [Q10.3.1: A friend],
  pvtbshfp.[8] [Q10.3.1: Books],
  pvtbshfp.[9] [Q10.3.1: Animal welfare organisation (staff or online resources)],
  pvtbshfp.[10] [Q10.3.1: Online sources not mentioned above - including forums],
  pvtbshfp.[11] [Q10.3.1: I have not sought help],
  pvtbshfp.[12] [Q10.3.1: Other (please specify) ID],
  s.otherBehaviourSoughtHelpFrom_paces [Q10.3.1: Other (please specify) Desc],
  -- 10.3.1.a ***If 'a vet who is also a behaviourist', 'behaviourist' and/or 'a dog trainer' are selected, then ask Q10.3.1.a
  s.behaviourSoughtHelpFromOrgDetails_paces [Q10.3.1.a Sought Help (Paces) - Organisation Details],
  -- 10.3.1.b ***If 'a vet', 'a vet who is also a behaviourist', 'behaviourist' and/or 'a dog trainer' are selected, then ask Q10.3.1.b
  s.behaviourSoughtHelpDiagnosisDetails_paces [Q10.3.1.b Sought Help (Paces) - Diagnosis Details],
  -- 10.3.1.c ***If 'Animal welfare organisation (staff or online resources' is selected, then ask Q10.3.1.c
  pvtbshfop.[1] [Q10.3.1.c: Battersea Dogs & Cats Home],
  pvtbshfop.[2] [Q10.3.1.c: Blue Cross],
  pvtbshfop.[3] [Q10.3.1.c: Dogs Trust],
  pvtbshfop.[4] [Q10.3.1.c: PDSA],
  pvtbshfop.[5] [Q10.3.1.c: RSPCA],
  pvtbshfop.[6] [Q10.3.1.c: Other (please specify)… ID],
  s.otherBehaviourSoughtHelpFromOrganisationTypeName_paces [Q10.3.1.c: Other (please specify)… Desc],
  -- 11 "Toby" has moments of disorientation/staring vacantly into space... 
  s.behaviourFrequencyId_disorientation [Q11: Disorientation Freq ID],
  bf11.behaviourFrequencyName [Q11: Disorientation Freq Desc],
  -- 11.1 Toby does this when…
  pvtbwd.[1] [Q11.1: People are moving around the house],
  pvtbwd.[2] [Q11.1: People are preparing to leave the house],
  pvtbwd.[3] [Q11.1: Left alone at home (if seen when a household member is leaving or returning to the house )],
  pvtbwd.[4] [Q11.1: I'm in the house but busy doing something],
  pvtbwd.[5] [Q11.1: He/she is with me/us but not getting attention],
  pvtbwd.[6] [Q11.1: Unfamiliar people interact with him/her],
  pvtbwd.[7] [Q11.1: Members of the household interact with him/her],
  pvtbwd.[8] [Q11.1: I/we tell him/her off],
  pvtbwd.[9] [Q11.1: Preparing for going out on a walk],
  pvtbwd.[10] [Q11.1: No specific trigger(s) that I can identify],
  pvtbwd.[11] [Q11.1: I'm not sure],
  pvtbwd.[12] [Q11.1: Other (please specify) ID],
  s.otherBehaviourWhenName_disorientation [Q11.1: Other (please specify) Desc],
  -- 11.2 When "Toby" does this behaviour, I usually…
  pvtburd.[1] [Q11.2: Tell him/her off],
  pvtburd.[2] [Q11.2: Physically reprimand/correct him/her (for example smack or tap on nose or bottom)],
  pvtburd.[3] [Q11.2: Verbally reprimand him/her],
  pvtburd.[4] [Q11.2: Distract him/her (for example with a rattled can/loud noise/water spray)],
  pvtburd.[5] [Q11.2: Move away from him/her],
  pvtburd.[6] [Q11.2: Don't give him/her treats that would normally be given at this time],
  pvtburd.[7] [Q11.2: Ignore him/her],
  pvtburd.[8] [Q11.2: Physically manipulate him/her (for example hold still, put into a sit or push down)],
  pvtburd.[9] [Q11.2: Play with him/her],
  pvtburd.[10] [Q11.2: Stroke him/her],
  pvtburd.[11] [Q11.2: Cuddle him/her],
  pvtburd.[12] [Q11.2: Hold him/her still],
  pvtburd.[13] [Q11.2: Encourage him/her to calm down],
  pvtburd.[14] [Q11.2: Move him/her to another part of the house],
  pvtburd.[15] [Q11.2: Let him/her outside into the garden or yard],
  pvtburd.[16] [Q11.2: Give him/her a food treat],
  pvtburd.[17] [Q11.2: Do none of the above],
  pvtburd.[18] [Q11.2: I don't know/can't remember],
  pvtburd.[19] [Q11.2: Other (please specify) ID],  
  s.otherBehaviourUsualReactionName_disorientation [Q11.2: Other (please specify) Desc],
  -- 11.3 I have sought help for this behaviour within the last 12 months….
  s.soughtHelpForThisBehaviour_disorientation [Q11.3 Sought Help (Disorientation) ID],
  CASE
    WHEN s.soughtHelpForThisBehaviour_disorientation = 0 THEN 'No'
    WHEN s.soughtHelpForThisBehaviour_disorientation = 1 THEN 'Yes'
  END [Q11.3 Sought Help (Disorientation) Desc],
  -- 11.3.1 I sought help from…
  pvtbshfd.[1] [Q11.3.1: A vet],
  pvtbshfd.[2] [Q11.3.1: A vet who is also a behaviourist],
  pvtbshfd.[3] [Q11.3.1: A behaviourist],
  pvtbshfd.[4] [Q11.3.1: A vet nurse],
  pvtbshfd.[5] [Q11.3.1: Other members of veterinary practice staff],
  pvtbshfd.[6] [Q11.3.1: A dog trainer],
  pvtbshfd.[7] [Q11.3.1: A friend],
  pvtbshfd.[8] [Q11.3.1: Books],
  pvtbshfd.[9] [Q11.3.1: Animal welfare organisation (staff or online resources)],
  pvtbshfd.[10] [Q11.3.1: Online sources not mentioned above - including forums],
  pvtbshfd.[11] [Q11.3.1: I have not sought help],
  pvtbshfd.[12] [Q11.3.1: Other (please specify) ID],
  s.otherBehaviourSoughtHelpFrom_disorientation [Q11.3.1: Other (please specify) Desc],
  -- 11.3.1.a ***If 'a vet who is also a behaviourist', 'behaviourist' and/or 'a dog trainer' are selected, then ask Q11.3.1.a
  s.behaviourSoughtHelpFromOrgDetails_disorientation [Q11.3.1.a Sought Help (Disorientation) - Organisation Details],
  -- 11.3.1.b ***If 'a vet', 'a vet who is also a behaviourist', 'behaviourist' and/or 'a dog trainer' are selected, then ask Q11.3.1.b
  s.behaviourSoughtHelpDiagnosisDetails_disorientation [Q11.3.1.b Sought Help (Disorientation) - Diagnosis Details],
  -- 11.3.1.c ***If 'Animal welfare organisation (staff or online resources' is selected, then ask Q11.3.1.c
  pvtbshfod.[1] [Q11.3.1.c: Battersea Dogs & Cats Home],
  pvtbshfod.[2] [Q11.3.1.c: Blue Cross],
  pvtbshfod.[3] [Q11.3.1.c: Dogs Trust],
  pvtbshfod.[4] [Q11.3.1.c: PDSA],
  pvtbshfod.[5] [Q11.3.1.c: RSPCA],
  pvtbshfod.[6] [Q11.3.1.c: Other (please specify)… ID],
  s.otherBehaviourSoughtHelpFromOrganisationTypeName_disorientation [Q11.3.1.c: Other (please specify)… Desc],
  -- 12 In my opinion, "Toby" licks or chews him/herself in the same place more than for usual grooming…
  s.behaviourFrequencyId_chews [Q12: Chews Freq ID],
  bf12.behaviourFrequencyName [Q12: Chews Freq Desc],
  -- 12.1 "Toby" does this when…
  pvtbwc.[1] [Q12.1: People are moving around the house],
  pvtbwc.[2] [Q12.1: People are preparing to leave the house],
  pvtbwc.[3] [Q12.1: Left alone at home (if seen when a household member is leaving or returning to the house )],
  pvtbwc.[4] [Q12.1: I'm in the house but busy doing something],
  pvtbwc.[5] [Q12.1: He/she is with me/us but not getting attention],
  pvtbwc.[6] [Q12.1: Unfamiliar people interact with him/her],
  pvtbwc.[7] [Q12.1: Members of the household interact with him/her],
  pvtbwc.[8] [Q12.1: I/we tell him/her off],
  pvtbwc.[9] [Q12.1: Preparing for going out on a walk],
  pvtbwc.[10] [Q12.1: No specific trigger(s) that I can identify],
  pvtbwc.[11] [Q12.1: I'm not sure],
  pvtbwc.[12] [Q12.1: Other (please specify) ID],
  s.otherBehaviourWhenName_chews [Q12.1: Other (please specify) Desc],
  -- 12.2 "Toby" licks or chews him/herself in this/these place(s) more than for usual grooming…
  pvtbcs.[1] [Q12.2: Face including chin, muzzle and/or side of face],
  pvtbcs.[2] [Q12.2: Ears],
  pvtbcs.[3] [Q12.2: Neck],
  pvtbcs.[4] [Q12.2: Back and/or base of tail],
  pvtbcs.[5] [Q12.2: Tail],
  pvtbcs.[6] [Q12.2: Paws (top or bottom, front or back)],
  pvtbcs.[7] [Q12.2: Back legs and thighs, excluding paws],
  pvtbcs.[8] [Q12.2: Flank],
  pvtbcs.[9] [Q12.2: Chest and sides],
  pvtbcs.[10] [Q12.2: Front legs and shoulders, excluding paws],
  pvtbcs.[11] [Q12.2: Tummy and/or groin],
  pvtbcs.[12] [Q12.2: Armpits],
  pvtbcs.[13] [Q12.2: None of the above],
  pvtbcs.[14] [Q12.2: Other (please specify) ID],
  s.otherBehaviourChewsSelfName [Q12.2: Other (please specify) Desc],
  -- 12.3 When "Toby" does this behaviour, I usually…
  pvtburc.[1] [Q12.3: Tell him/her off],
  pvtburc.[2] [Q12.3: Physically reprimand/correct him/her (for example smack or tap on nose or bottom)],
  pvtburc.[3] [Q12.3: Verbally reprimand him/her],
  pvtburc.[4] [Q12.3: Distract him/her (for example with a rattled can/loud noise/water spray)],
  pvtburc.[5] [Q12.3: Move away from him/her],
  pvtburc.[6] [Q12.3: Don't give him/her treats that would normally be given at this time],
  pvtburc.[7] [Q12.3: Ignore him/her],
  pvtburc.[8] [Q12.3: Physically manipulate him/her (for example hold still, put into a sit or push down)],
  pvtburc.[9] [Q12.3: Play with him/her],
  pvtburc.[10] [Q12.3: Stroke him/her],
  pvtburc.[11] [Q12.3: Cuddle him/her],
  pvtburc.[12] [Q12.3: Hold him/her still],
  pvtburc.[13] [Q12.3: Encourage him/her to calm down],
  pvtburc.[14] [Q12.3: Move him/her to another part of the house],
  pvtburc.[15] [Q12.3: Let him/her outside into the garden or yard],
  pvtburc.[16] [Q12.3: Give him/her a food treat],
  pvtburc.[17] [Q12.3: Do none of the above],
  pvtburc.[18] [Q12.3: I don't know/can't remember],
  pvtburc.[19] [Q12.3: Other (please specify) ID],  
  s.otherBehaviourUsualReactionName_chews [Q12.3: Other (please specify) Desc],
  -- 12.4 I have sought help for this behaviour within the last 12 months….
  s.soughtHelpForThisBehaviour_chews [Q12.4 Sought Help (Chews) ID],
  CASE
    WHEN s.soughtHelpForThisBehaviour_chews = 0 THEN 'No'
    WHEN s.soughtHelpForThisBehaviour_chews = 1 THEN 'Yes'
  END [Q12.4 Sought Help (Chews) Desc],
  -- 12.4.1 I sought help from…
  pvtbshfc.[1] [Q12.4.1: A vet],
  pvtbshfc.[2] [Q12.4.1: A vet who is also a behaviourist],
  pvtbshfc.[3] [Q12.4.1: A behaviourist],
  pvtbshfc.[4] [Q12.4.1: A vet nurse],
  pvtbshfc.[5] [Q12.4.1: Other members of veterinary practice staff],
  pvtbshfc.[6] [Q12.4.1: A dog trainer],
  pvtbshfc.[7] [Q12.4.1: A friend],
  pvtbshfc.[8] [Q12.4.1: Books],
  pvtbshfc.[9] [Q12.4.1: Animal welfare organisation (staff or online resources)],
  pvtbshfc.[10] [Q12.4.1: Online sources not mentioned above - including forums],
  pvtbshfc.[11] [Q12.4.1: I have not sought help],
  pvtbshfc.[12] [Q12.4.1: Other (please specify) ID],
  s.otherBehaviourSoughtHelpFrom_chews [Q12.4.1: Other (please specify) Desc],
  -- 12.4.1.a ***If 'a vet who is also a behaviourist', 'behaviourist' and/or 'a dog trainer' are selected, then ask Q12.4.1.a
  s.behaviourSoughtHelpFromOrgDetails_chews [Q12.4.1.a Sought Help (Chews) - Organisation Details],
  -- 12.4.1.b ***If 'a vet', 'a vet who is also a behaviourist', 'behaviourist' and/or 'a dog trainer' are selected, then ask Q12.4.1.b
  s.behaviourSoughtHelpDiagnosisDetails_chews [Q12.4.1.b Sought Help (Chews) - Diagnosis Details],
  -- 12.4.1.c ***If 'Animal welfare organisation (staff or online resources' is selected, then ask Q12.4.1.c
  pvtbshfoc.[1] [Q12.4.1.c: Battersea Dogs & Cats Home],
  pvtbshfoc.[2] [Q12.4.1.c: Blue Cross],
  pvtbshfoc.[3] [Q12.4.1.c: Dogs Trust],
  pvtbshfoc.[4] [Q12.4.1.c: PDSA],
  pvtbshfoc.[5] [Q12.4.1.c: RSPCA],
  pvtbshfoc.[6] [Q12.4.1.c: Other (please specify)… ID],
  s.otherBehaviourSoughtHelpFromOrganisationTypeName_chews [Q12.4.1.c: Other (please specify)… Desc],
  -- 13 "Toby" excessively licks people/objects/surfaces (please do not include behaviour related to food, e.g. licking his/her bowl/countertops where food has been prepared)...
  s.behaviourFrequencyId_licks [Q13: Licks Freq ID],
  bf13.behaviourFrequencyName [Q13: Licks Freq Desc],
  -- 13.1 Toby does this when…
  pvtbwl.[1] [Q13.1: People are moving around the house],
  pvtbwl.[2] [Q13.1: People are preparing to leave the house],
  pvtbwl.[3] [Q13.1: Left alone at home (if seen when a household member is leaving or returning to the house )],
  pvtbwl.[4] [Q13.1: I'm in the house but busy doing something ],
  pvtbwl.[5] [Q13.1: He/she is with me/us but not getting attention],
  pvtbwl.[6] [Q13.1: Unfamiliar people interact with him/her],
  pvtbwl.[7] [Q13.1: Members of the household interact with him/her],
  pvtbwl.[8] [Q13.1: I/we tell him/her off],
  pvtbwl.[9] [Q13.1: Preparing for going out on a walk],
  pvtbwl.[10] [Q13.1: No specific trigger(s) that I can identify],
  pvtbwl.[11] [Q13.1: I'm not sure],
  pvtbwl.[12] [Q13.1: Other (please specify) ID],
  s.otherBehaviourWhenName_licks [Q13.1: Other (please specify) Desc],
  -- 13.2 "Toby" excessively licks….
  pvtbel.[1] [Q13.2: Walls of the house],
  pvtbel.[2] [Q13.2: Furniture],
  pvtbel.[3] [Q13.2: Flooring],
  pvtbel.[4] [Q13.2: Areas in the garden],
  pvtbel.[5] [Q13.2: People],
  pvtbel.[6] [Q13.2: Other (please specify) ID],
  s.otherBehaviourExcessivelyLicksName [Q13.2: Other (please specify) Desc],
  -- 13.3 When "Toby" does this behaviour, I usually…
  pvtburl.[1] [Q13.3: Tell him/her off],
  pvtburl.[2] [Q13.3: Physically reprimand/correct him/her (for example smack or tap on nose or bottom)],
  pvtburl.[3] [Q13.3: Verbally reprimand him/her],
  pvtburl.[4] [Q13.3: Distract him/her (for example with a rattled can/loud noise/water spray)],
  pvtburl.[5] [Q13.3: Move away from him/her],
  pvtburl.[6] [Q13.3: Don't give him/her treats that would normally be given at this time],
  pvtburl.[7] [Q13.3: Ignore him/her],
  pvtburl.[8] [Q13.3: Physically manipulate him/her (for example hold still, put into a sit or push down)],
  pvtburl.[9] [Q13.3: Play with him/her],
  pvtburl.[10] [Q13.3: Stroke him/her],
  pvtburl.[11] [Q13.3: Cuddle him/her],
  pvtburl.[12] [Q13.3: Hold him/her still],
  pvtburl.[13] [Q13.3: Encourage him/her to calm down],
  pvtburl.[14] [Q13.3: Move him/her to another part of the house],
  pvtburl.[15] [Q13.3: Let him/her outside into the garden or yard],
  pvtburl.[16] [Q13.3: Give him/her a food treat],
  pvtburl.[17] [Q13.3: Do none of the above],
  pvtburl.[18] [Q13.3: I don't know/can't remember],
  pvtburl.[19] [Q13.3: Other (please specify) ID],  
  s.otherBehaviourUsualReactionName_licks [Q13.3: Other (please specify) ID],
  -- 13.4 I have sought help for this behaviour within the last 12 months….
  s.soughtHelpForThisBehaviour_licks [Q13.4 Sought Help (Licks) ID],
  CASE
    WHEN s.soughtHelpForThisBehaviour_licks = 0 THEN 'No'
    WHEN s.soughtHelpForThisBehaviour_licks = 1 THEN 'Yes'
  END [Q13.4 Sought Help (Licks) Desc],
  -- 13.4.1 I sought help from…
  pvtbshfl.[1] [Q13.4.1: A vet],
  pvtbshfl.[2] [Q13.4.1: A vet who is also a behaviourist],
  pvtbshfl.[3] [Q13.4.1: A behaviourist],
  pvtbshfl.[4] [Q13.4.1: A vet nurse],
  pvtbshfl.[5] [Q13.4.1: Other members of veterinary practice staff],
  pvtbshfl.[6] [Q13.4.1: A dog trainer],
  pvtbshfl.[7] [Q13.4.1: A friend],
  pvtbshfl.[8] [Q13.4.1: Books],
  pvtbshfl.[9] [Q13.4.1: Animal welfare organisation (staff or online resources)],
  pvtbshfl.[10] [Q13.4.1: Online sources not mentioned above - including forums],
  pvtbshfl.[11] [Q13.4.1: I have not sought help],
  pvtbshfl.[12] [Q13.4.1: Other (please specify) ID],
  s.otherBehaviourSoughtHelpFrom_licks [Q13.4.1: Other (please specify) Desc],
  -- 13.4.1.a ***If 'a vet who is also a behaviourist', 'behaviourist' and/or 'a dog trainer' are selected, then ask Q13.4.1.a
  s.behaviourSoughtHelpFromOrgDetails_licks [Q13.4.1.a Sought Help (Licks) - Organisation Details],
  -- 13.4.1.b ***If 'a vet', 'a vet who is also a behaviourist', 'behaviourist' and/or 'a dog trainer' are selected, then ask Q13.4.1.b
  s.behaviourSoughtHelpDiagnosisDetails_licks [Q13.4.1.b Sought Help (Licks) - Diagnosis Details],
  -- 13.4.1.c ***If 'Animal welfare organisation (staff or online resources' is selected, then ask Q13.4.1.c
  pvtbshfol.[1] [Q13.4.1.c: Battersea Dogs & Cats Home],
  pvtbshfol.[2] [Q13.4.1.c: Blue Cross],
  pvtbshfol.[3] [Q13.4.1.c: Dogs Trust],
  pvtbshfol.[4] [Q13.4.1.c: PDSA],
  pvtbshfol.[5] [Q13.4.1.c: RSPCA],
  pvtbshfol.[6] [Q13.4.1.c: Other (please specify)… ID],
  s.otherBehaviourSoughtHelpFromOrganisationTypeName_licks [Q13.4.1.c: Other (please specify)… Desc],
  -- 14 "Toby" barks a lot/excessively... 
  s.behaviourFrequencyId_barks [Q14: Barks Freq ID],
  bf14.behaviourFrequencyName [Q14: Barks Freq Desc],
  -- 14.1 "Toby" barks a lot/excessively when…
  pvtbebw.[1] [Q14.1: Left alone at home],
  pvtbebw.[2] [Q14.1: I am/we are in the house but busy doing something else],
  pvtbebw.[3] [Q14.1: People pass by the house when he/she is indoors],
  pvtbebw.[4] [Q14.1: People pass by the house when he/she is in the garden],
  pvtbebw.[5] [Q14.1: The doorbell rings/someone knocks on the door],
  pvtbebw.[6] [Q14.1: There are noises from outside the household when he/she is indoors],
  pvtbebw.[7] [Q14.1: Dogs approach whilst out on walks],
  pvtbebw.[8] [Q14.1: People approach whilst out on walks],
  pvtbebw.[9] [Q14.1: Ignored by members of the household ],
  pvtbebw.[10] [Q14.1: There is passing traffic whilst out on walks], 
  pvtbebw.[11] [Q14.1: There are sudden and/or loud noises when out on walks],
  pvtbebw.[12] [Q14.1: Other (please specify)… ID],
  s.otherBehaviourExcessivelyBarksWhenName [Q14.1: Other (please specify)… Desc],
  -- 14.2 When "Toby" does this behaviour, I usually…
  pvtburb.[1] [Q14.2: Tell him/her off],
  pvtburb.[2] [Q14.2: Physically reprimand/correct him/her (for example smack or tap on nose or bottom)],
  pvtburb.[3] [Q14.2: Verbally reprimand him/her],
  pvtburb.[4] [Q14.2: Distract him/her (for example with a rattled can/loud noise/water spray)],
  pvtburb.[5] [Q14.2: Move away from him/her],
  pvtburb.[6] [Q14.2: Don't give him/her treats that would normally be given at this time],
  pvtburb.[7] [Q14.2: Ignore him/her],
  pvtburb.[8] [Q14.2: Physically manipulate him/her (for example hold still, put into a sit or push down)],
  pvtburb.[9] [Q14.2: Play with him/her],
  pvtburb.[10] [Q14.2: Stroke him/her],
  pvtburb.[11] [Q14.2: Cuddle him/her],
  pvtburb.[12] [Q14.2: Hold him/her still],
  pvtburb.[13] [Q14.2: Encourage him/her to calm down],
  pvtburb.[14] [Q14.2: Move him/her to another part of the house],
  pvtburb.[15] [Q14.2: Let him/her outside into the garden or yard],
  pvtburb.[16] [Q14.2: Give him/her a food treat],
  pvtburb.[17] [Q14.2: Do none of the above],
  pvtburb.[18] [Q14.2: I don't know/can't remember],
  pvtburb.[19] [Q14.2: Other (please specify) ID],  
  s.otherBehaviourUsualReactionName_barks [Q14.2: Other (please specify) Desc],
  -- 14.3 I have sought help for this behaviour within the last 12 months….
  s.soughtHelpForThisBehaviour_barks [Q14.4 Sought Help (Barks) ID],
  CASE
    WHEN s.soughtHelpForThisBehaviour_barks = 0 THEN 'No'
    WHEN s.soughtHelpForThisBehaviour_barks = 1 THEN 'Yes'
  END [Q14.4 Sought Help (Barks) Desc],
  -- 14.4.1 I sought help from…
  pvtbshfb.[1] [Q14.4.1: A vet],
  pvtbshfb.[2] [Q14.4.1: A vet who is also a behaviourist],
  pvtbshfb.[3] [Q14.4.1: A behaviourist],
  pvtbshfb.[4] [Q14.4.1: A vet nurse],
  pvtbshfb.[5] [Q14.4.1: Other members of veterinary practice staff],
  pvtbshfb.[6] [Q14.4.1: A dog trainer],
  pvtbshfb.[7] [Q14.4.1: A friend],
  pvtbshfb.[8] [Q14.4.1: Books],
  pvtbshfb.[9] [Q14.4.1: Animal welfare organisation (staff or online resources)],
  pvtbshfb.[10] [Q14.4.1: Online sources not mentioned above - including forums],
  pvtbshfb.[11] [Q14.4.1: I have not sought help],
  pvtbshfb.[12] [Q14.4.1: Other (please specify) ID],
  s.otherBehaviourSoughtHelpFrom_barks [Q14.4.1: Other (please specify) Desc],
  -- 14.4.1.a ***If 'a vet who is also a behaviourist', 'behaviourist' and/or 'a dog trainer' are selected, then ask Q14.4.1.a
  s.behaviourSoughtHelpFromOrgDetails_barks [Q14.4.1.a Sought Help (Barks) - Organisation Details],
  -- 14.4.1.b ***If 'a vet', 'a vet who is also a behaviourist', 'behaviourist' and/or 'a dog trainer' are selected, then ask Q14.4.1.b
  s.behaviourSoughtHelpDiagnosisDetails_barks [Q14.4.1.b Sought Help (Barks) - Diagnosis Details],
  -- 14.4.1.c ***If 'Animal welfare organisation (staff or online resources' is selected, then ask Q14.4.1.c
  pvtbshfol.[1] [Q14.4.1.c: Battersea Dogs & Cats Home],
  pvtbshfol.[2] [Q14.4.1.c: Blue Cross],
  pvtbshfol.[3] [Q14.4.1.c: Dogs Trust],
  pvtbshfol.[4] [Q14.4.1.c: PDSA],
  pvtbshfol.[5] [Q14.4.1.c: RSPCA],
  pvtbshfol.[6] [Q14.4.1.c: Other (please specify)… ID],
  s.otherBehaviourSoughtHelpFromOrganisationTypeName_barks [Q14.4.1.c: Other (please specify)… Desc],
  -- 15 "Toby" always seems to be hungry…
  s.excellentAppetiteLevelId_hungry [Q15: Always Hungry ID],
  eal.excellentAppetiteLevelName [Q15: Always Hungry Desc],
  -- 16 When "Toby" goes to a place he/she hasn't been before, he/she…
  /*---Gets excited---*/
  s.behaviourFrequencyId_getsExcited [Q16: New Place Response - Gets Excited ID],
  bfge.behaviourFrequencyName [Q16: New Place Response - Gets Excited Desc],
  /*---Explores---*/
  s.behaviourFrequencyId_explores [Q16: New Place Response - Explores ID],
  bfe.behaviourFrequencyName [Q16: New Place Response - Explores Desc],
  /*---Is calm---*/
  s.behaviourFrequencyId_isCalm [Q16: New Place Response - Is Calm ID],
  bfic.behaviourFrequencyName [Q16: New Place Response - Is Calm Desc],
  /*---Sticks close to me/us---*/
  s.behaviourFrequencyId_sticksClose [Q16: New Place Response - Sticks Close to Me/Us ID],
  bfsc.behaviourFrequencyName [Q16: New Place Response - Sticks Close to Me/Us Desc],
  /*---Is unresponsive---*/
  s.behaviourFrequencyId_isUnresponsive [Q16: New Place Response - Is Unresponsive ID],
  bfiu.behaviourFrequencyName [Q16: New Place Response - Is Unresponsive Desc], 
 
  -- 17 "Toby" starts play sessions with me/us (for example bringing toys)…
  s.behaviourFrequencyId_startsPlaySessions [Q17: Starts Play Session ID],
  bf17.behaviourFrequencyName [Q17: Starts Play Session Desc],
  
  -- 18 "Toby" has an excellent appetite... 
  s.excellentAppetiteLevelId_appetite [Q18: Has Excelent Appetite ID],
  eal18.excellentAppetiteLevelName [Q18: Has Excelent Appetite Desc],
  
  -- 19 Toby shows restless/agitated behaviour... 
  s.behaviourFrequencyId_restlessBehaviour [Q19: Shows Restless Behaviour ID],
  bf19.behaviourFrequencyName [Q19: Shows Restless Behaviour Desc],
  
  -- 20 "Toby" shows irritable behaviour (for example grumbling, growling or snapping in situations when this would not normally happen)...
  s.behaviourFrequencyId_irritableBehaviour [Q20: Shows Irritable Behaviour ID],
  bf20.behaviourFrequencyName [Q20: Shows Irritable Behaviour Desc], 
  
  -- 21 "Toby" has restless sleep/wakes at night... 
  s.behaviourFrequencyId_restlessSleep [Q21: Restless Sleep ID],
  bf21.behaviourFrequencyName [Q21: Restless Sleep Desc],
  
  -- 22 "Toby" spends much of the day asleep... 
  s.behaviourFrequencyId_dayAsleep [Q22: Spends Much of Day Asleep ID],
  bf22.behaviourFrequencyName [Q22: Spends Much of Day Asleep Desc],
  
  -- 23 "Toby" urinates(wees)/defecates(poos) indoors…
  s.behaviourFrequencyId_urinatesIndoors [Q23: Toilets Indoors ID],
  bf23.behaviourFrequencyName [Q23: Toilets Indoors Desc],
  
  -- 24 "Toby" does not or barely signals that he/she needs to go out to urinate(wee)/defecate(poo)... 
  s.behaviourFrequencyId_urinatesBarelySignals [Q24: Does Not Signal Toileting ID],
  bf24.behaviourFrequencyName [Q24: Does Not Signal Toileting Desc],
  
  -- 25 "Toby" goes outdoors, then returns indoors and urinates(wees)/defecates(poos)... 
  s.behaviourFrequencyId_urinatesOnReturn [Q25: Toilets Indoors After Going Outdoors ID],
  bf25.behaviourFrequencyName [Q25: Toilets Indoors After Going Outdoors Desc],
  
  -- 26 "Toby" has difficulties with/is unable to recognise familiar people/pets... 
  s.behaviourFrequencyId_unableToRecognisePeople [Q26: Unable To Recognise Familiar People ID],
  bf26.behaviourFrequencyName [Q26: Unable To Recognise Familiar People Desc],
  
  -- 27 "Toby" gets lost/disorientated in familiar areas (inside or outside)... 
  s.behaviourFrequencyId_disorientatedFamilarPlaces [Q27: Disorientated in familiar areas ID],
  bf27.behaviourFrequencyName [Q27: Disorientated in familiar areas Desc],
  
  -- 28 "Toby" does not respond to known commands and tricks... 
  s.behaviourFrequencyId_noResponseToKnownCommands [Q28: Doesn't Respond To Known Commands ID],
  bf28.behaviourFrequencyName [Q28: Doesn't Respond To Known Commands Desc],
  
  -- 32 "Toby" is slow/unable to learn new tasks... 
  s.behaviourFrequencyId_unableToLearnNewTricks [Q32: Slow To Learn New Tricks ID],
  bf32.behaviourFrequencyName [Q32: Slow To Learn New Tricks Desc]
from survey5Years s

  -- 2 "Toby" goes to the wrong side of doors (for example the hinge side)... 
left join referenceBehaviourFrequency bf2
  on bf2.behaviourFrequencyId = s.behaviourFrequencyId_wrongSideOfDoors
  
  -- 3 "Toby" gets stuck, cannot navigate around or over obstacles... 
left join referenceBehaviourFrequency bf3
  on bf3.behaviourFrequencyId = s.behaviourFrequencyId_getsStuck
  
  -- 4 "Toby" barely reacts/responds to new events or situations... 
left join referenceBehaviourFrequency bf4
  on bf4.behaviourFrequencyId = s.behaviourFrequencyId_barelyReacts
  

-- 5 On an average day, "Toby" comes to me for attention…
left join referenceBehaviourAttentionFrequency baf
  on baf.behaviourAttentionFrequencyId = s.behaviourAttentionFrequencyId
  
-- 6 On an average day, when you arrive home, using a scale of 1 to 5, how enthusiastically does "Toby" greet you?
left join referenceBehaviourEnthusiasmGreetingLevel beg
  on beg.behaviourEnthusiasmGreetingLevelId = s.behaviourEnthusiasmGreetingLevelId

-- 7 On an average day, using a scale of 1 to 5, how often is "Toby" clingy (for example, following you/other household members around)…
left join referenceBehaviourClingyFrequency bcf
  on s.behaviourClingyFrequencyId = bcf.behaviourClingyFrequencyId
  
-- 8 Toby stares/fixates/repeatedly snaps or barks at objects...
left join referenceBehaviourFrequency bf8
  on bf8.behaviourFrequencyId = s.behaviourFrequencyId_stares
  
-- 8.1 The object(s) "Toby" stares/fixates/repeatedly snaps or barks at is(/are)...
Left join 
	(Select 
		bsa.survey5YearsId ID,
		behaviourStaresAtObjectsTypesName [Behaviour Type],
		cast(bsa.behaviourStaresAtObjectsTypesId as varchar) as 'Behaviour'

	   from survey5Years_referenceBehaviourStaresAtObjectsTypes bsa

	inner join  referenceBehaviourStaresAtObjectsTypes refbsa

		on refbsa.behaviourStaresAtObjectsTypesId = bsa.behaviourStaresAtObjectsTypesId
	) bsa 
	PIVOT
	
	(min([Behaviour Type]) For Behaviour
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11])
	) 
	pvtbsa on pvtbsa.ID = s.survey5YearsID

  
-- 8.2 When "Toby" does this behaviour, I usually…
Left join 
	(Select 
		burs.survey5YearsId ID,
		behaviourUsualReactionName [Reaction Type],
		cast(burs.behaviourUsualReactionId as varchar) as 'Reaction'

	   from survey5Years_referenceBehaviourUsualReaction_stares burs

	inner join  referenceBehaviourUsualReaction refbur

		on refbur.behaviourUsualReactionId = burs.behaviourUsualReactionId
	) burs
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19])
	) 
	pvtburs on pvtburs.ID = s.survey5YearsID
  
-- 8.3.1 I sought help from…
Left join 
	(Select 
		bshfs.survey5YearsId ID,
		behaviourSoughtHelpFromName [Help Type],
		cast(bshfs.behaviourSoughtHelpFromId as varchar) as 'Help'

	   from survey5Years_referenceBehaviourSoughtHelpFrom_stares bshfs

	inner join  referenceBehaviourSoughtHelpFrom refbshfs

		on refbshfs.behaviourSoughtHelpFromId = bshfs.behaviourSoughtHelpFromId
	) bshfs
	PIVOT
	
	(min([Help Type]) For Help
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	) 
	pvtbshfs on pvtbshfs.ID = s.survey5YearsID
  
-- 8.3.1.c ***If 'Animal welfare organisation (staff or online resources' is selected, then ask Q8.3.1.c
Left join 
	(Select 
		bshfos.survey5YearsId ID,
		behaviourSoughtHelpFromOrganisationTypeName [Organisation Type],
		cast(bshfos.behaviourSoughtHelpFromOrganisationTypeId as varchar) as 'Organisation'

	   from survey5Years_referenceBehaviourSoughtHelpFromOrganisationType_stares bshfos

	inner join  referenceBehaviourSoughtHelpFromOrganisationType refbshfos

		on refbshfos.behaviourSoughtHelpFromOrganisationTypeId = bshfos.behaviourSoughtHelpFromOrganisationTypeId
	) bshfos
	PIVOT
	
	(min([Organisation Type]) For Organisation
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtbshfos on pvtbshfos.ID = s.survey5YearsID
  
-- 9 Excluding circling prior to lying down or toileting, "Toby" spins in a circle/chases his/her tail... 
left join referenceBehaviourSpinsFrequency bsf
  on bsf.behaviourSpinsFrequencyId = s.behaviourSpinsFrequencyId
 
-- 9.1 "Toby" does this when…
Left join 
	(Select 
		bws.survey5YearsId ID,
		behaviourWhenName [Behaviour Type],
		cast(bws.behaviourWhenId as varchar) as 'Behaviour'

	   from survey5Years_referenceBehaviourWhen_spins bws

	inner join  referenceBehaviourWhen refbws

		on refbws.behaviourWhenId = bws.behaviourWhenId 
	) bws 
	PIVOT
	
	(min([Behaviour Type]) For Behaviour
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	) 
	pvtbws on pvtbws.ID = s.survey5YearsID

-- 9.2 When "Toby" does this behaviour, I usually…
Left join 
	(Select 
		bursp.survey5YearsId ID,
		behaviourUsualReactionName [Reaction Type],
		cast(bursp.behaviourUsualReactionId as varchar) as 'Reaction'

	   from survey5Years_referenceBehaviourUsualReaction_spins bursp

	inner join  referenceBehaviourUsualReaction refbur

		on refbur.behaviourUsualReactionId = bursp.behaviourUsualReactionId
	) bursp
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19])
	) 
	pvtbursp on pvtbursp.ID = s.survey5YearsID
  
-- 9.3.1 I sought help from…
Left join 
	(Select 
		bshfsp.survey5YearsId ID,
		behaviourSoughtHelpFromName [Help Type],
		cast(bshfsp.behaviourSoughtHelpFromId as varchar) as 'Help'

	   from survey5Years_referenceBehaviourSoughtHelpFrom_spins bshfsp

	inner join  referenceBehaviourSoughtHelpFrom refbshfs

		on refbshfs.behaviourSoughtHelpFromId = bshfsp.behaviourSoughtHelpFromId
	) bshfsp
	PIVOT
	
	(min([Help Type]) For Help
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	) 
	pvtbshfsp on pvtbshfsp.ID = s.survey5YearsID

-- 9.3.1.c ***If 'Animal welfare organisation (staff or online resources' is selected, then ask Q9.3.1.c
Left join 
	(Select 
		bshfosp.survey5YearsId ID,
		behaviourSoughtHelpFromOrganisationTypeName [Organisation Type],
		cast(bshfosp.behaviourSoughtHelpFromOrganisationTypeId as varchar) as 'Organisation'

	   from survey5Years_referenceBehaviourSoughtHelpFromOrganisationType_spins bshfosp

	inner join  referenceBehaviourSoughtHelpFromOrganisationType refbshfos

		on refbshfos.behaviourSoughtHelpFromOrganisationTypeId = bshfosp.behaviourSoughtHelpFromOrganisationTypeId
	) bshfosp
	PIVOT
	
	(min([Organisation Type]) For Organisation
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtbshfosp on pvtbshfosp.ID = s.survey5YearsID
  
-- 10 "Toby" paces/wanders aimlessly... 
left join referenceBehaviourFrequency bf10
  on bf10.behaviourFrequencyId = s.behaviourFrequencyId_paces
  
-- 10.1 Toby does this when…
Left join 
	(Select 
		bwp.survey5YearsId ID,
		behaviourWhenName [Behaviour Type],
		cast(bwp.behaviourWhenId as varchar) as 'Behaviour'

	   from survey5Years_referenceBehaviourWhen_paces bwp

	inner join  referenceBehaviourWhen refbwp

		on refbwp.behaviourWhenId = bwp.behaviourWhenId
	) bwp 
	PIVOT
	
	(min([Behaviour Type]) For Behaviour
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	) 
	pvtbwp on pvtbwp.ID = s.survey5YearsID
  
-- 10.2 When "Toby" does this behaviour, I usually…
Left join 
	(Select 
		burp.survey5YearsId ID,
		behaviourUsualReactionName [Reaction Type],
		cast(burp.behaviourUsualReactionId as varchar) as 'Reaction'

	   from survey5Years_referenceBehaviourUsualReaction_paces burp

	inner join  referenceBehaviourUsualReaction refbur

		on refbur.behaviourUsualReactionId = burp.behaviourUsualReactionId
	) burp
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19])
	) 
	pvtburp on pvtburp.ID = s.survey5YearsID
  
-- 10.3.1 I sought help from…
Left join 
	(Select 
		bshfp.survey5YearsId ID,
		behaviourSoughtHelpFromName [Help Type],
		cast(bshfp.behaviourSoughtHelpFromId as varchar) as 'Help'

	   from survey5Years_referenceBehaviourSoughtHelpFrom_paces bshfp

	inner join  referenceBehaviourSoughtHelpFrom refbshfs

		on refbshfs.behaviourSoughtHelpFromId = bshfp.behaviourSoughtHelpFromId
	) bshfp
	PIVOT
	
	(min([Help Type]) For Help
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	) 
	pvtbshfp on pvtbshfp.ID = s.survey5YearsID
  
-- 10.3.1.c ***If 'Animal welfare organisation (staff or online resources' is selected, then ask Q10.3.1.c
Left join 
	(Select 
		bshfop.survey5YearsId ID,
		behaviourSoughtHelpFromOrganisationTypeName [Organisation Type],
		cast(bshfop.behaviourSoughtHelpFromOrganisationTypeId as varchar) as 'Organisation'

	   from survey5Years_referenceBehaviourSoughtHelpFromOrganisationType_paces bshfop

	inner join  referenceBehaviourSoughtHelpFromOrganisationType refbshfos

		on refbshfos.behaviourSoughtHelpFromOrganisationTypeId = bshfop.behaviourSoughtHelpFromOrganisationTypeId
	) bshfop
	PIVOT
	
	(min([Organisation Type]) For Organisation
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtbshfop on pvtbshfop.ID = s.survey5YearsID
  
-- 11 "Toby" has moments of disorientation/staring vacantly into space... 
left join referenceBehaviourFrequency bf11
  on bf11.behaviourFrequencyId = s.behaviourFrequencyId_disorientation
  
-- 11.1 Toby does this when…
Left join 
	(Select 
		bwd.survey5YearsId ID,
		behaviourWhenName [Behaviour Type],
		cast(bwd.behaviourWhenId as varchar) as 'Behaviour'

	   from survey5Years_referenceBehaviourWhen_disorientation bwd

	inner join  referenceBehaviourWhen refbwd

		on refbwd.behaviourWhenId = bwd.behaviourWhenId
	) bwd
	PIVOT
	
	(min([Behaviour Type]) For Behaviour
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	) 
	pvtbwd on pvtbwd.ID = s.survey5YearsID
  
-- 11.2 When "Toby" does this behaviour, I usually…
Left join 
	(Select 
		burd.survey5YearsId ID,
		behaviourUsualReactionName [Reaction Type],
		cast(burd.behaviourUsualReactionId as varchar) as 'Reaction'

	   from survey5Years_referenceBehaviourUsualReaction_disorientation burd

	inner join  referenceBehaviourUsualReaction refbur

		on refbur.behaviourUsualReactionId = burd.behaviourUsualReactionId
	) burd
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19])
	) 
	pvtburd on pvtburd.ID = s.survey5YearsID
  
-- 11.3.1 I sought help from…
Left join 
	(Select 
		bshfd.survey5YearsId ID,
		behaviourSoughtHelpFromName [Help Type],
		cast(bshfd.behaviourSoughtHelpFromId as varchar) as 'Help'

	   from survey5Years_referenceBehaviourSoughtHelpFrom_disorientation bshfd

	inner join  referenceBehaviourSoughtHelpFrom refbshfs

		on refbshfs.behaviourSoughtHelpFromId = bshfd.behaviourSoughtHelpFromId
	) bshfd
	PIVOT
	
	(min([Help Type]) For Help
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	) 
	pvtbshfd on pvtbshfd.ID = s.survey5YearsID

-- 11.3.1.c ***If 'Animal welfare organisation (staff or online resources' is selected, then ask Q11.3.1.c
Left join 
	(Select 
		bshfod.survey5YearsId ID,
		behaviourSoughtHelpFromOrganisationTypeName [Organisation Type],
		cast(bshfod.behaviourSoughtHelpFromOrganisationTypeId as varchar) as 'Organisation'

	   from survey5Years_referenceBehaviourSoughtHelpFromOrganisationType_disorientation bshfod

	inner join  referenceBehaviourSoughtHelpFromOrganisationType refbshfos

		on refbshfos.behaviourSoughtHelpFromOrganisationTypeId = bshfod.behaviourSoughtHelpFromOrganisationTypeId
	) bshfod
	PIVOT
	
	(min([Organisation Type]) For Organisation
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtbshfod on pvtbshfod.ID = s.survey5YearsID
  
-- 12 In my opinion, "Toby" licks or chews him/herself in the same place more than for usual grooming…
left join referenceBehaviourFrequency bf12
  on bf12.behaviourFrequencyId = s.behaviourFrequencyId_chews
  
-- 12.1 "Toby" does this when…
Left join 
	(Select 
		bwc.survey5YearsId ID,
		behaviourWhenName [Behaviour Type],
		cast(bwc.behaviourWhenId as varchar) as 'Behaviour'

	   from survey5Years_referenceBehaviourWhen_chews bwc

	inner join  referenceBehaviourWhen refbwc

		on refbwc.behaviourWhenId = bwc.behaviourWhenId
	) bwc
	PIVOT
	
	(min([Behaviour Type]) For Behaviour
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	) 
	pvtbwc on pvtbwc.ID = s.survey5YearsID
  
-- 12.2 "Toby" licks or chews him/herself in this/these place(s) more than for usual grooming…
Left join 
	(Select 
		bcs.survey5YearsId ID,
		behaviourChewsSelfName [Chew Type],
		cast(bcs.behaviourChewsSelfId as varchar) as 'Chew'

	   from survey5Years_referenceBehaviourChewsSelf2 bcs

	inner join  referenceBehaviourChewsSelf2 refbcs

		on refbcs.numOrderDisplay = bcs.behaviourChewsSelfId
	) bcs
	PIVOT
	
	(min([Chew Type]) For Chew
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14])
	) 
	pvtbcs on pvtbcs.ID = s.survey5YearsID
  
-- 12.3 When "Toby" does this behaviour, I usually…
Left join 
	(Select 
		burc.survey5YearsId ID,
		behaviourUsualReactionName [Reaction Type],
		cast(burc.behaviourUsualReactionId as varchar) as 'Reaction'

	   from survey5Years_referenceBehaviourUsualReaction_chews burc

	inner join  referenceBehaviourUsualReaction refbur

		on refbur.behaviourUsualReactionId = burc.behaviourUsualReactionId
	) burc
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19])
	) 
	pvtburc on pvtburc.ID = s.survey5YearsID
  
-- 12.4.1 I sought help from…
Left join 
	(Select 
		bshfc.survey5YearsId ID,
		behaviourSoughtHelpFromName [Help Type],
		cast(bshfc.behaviourSoughtHelpFromId as varchar) as 'Help'

	   from survey5Years_referenceBehaviourSoughtHelpFrom_chews bshfc

	inner join  referenceBehaviourSoughtHelpFrom refbshfs

		on refbshfs.behaviourSoughtHelpFromId = bshfc.behaviourSoughtHelpFromId
	) bshfc
	PIVOT
	
	(min([Help Type]) For Help
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	) 
	pvtbshfc on pvtbshfc.ID = s.survey5YearsID
  
-- 12.4.1.c ***If 'Animal welfare organisation (staff or online resources' is selected, then ask Q12.4.1.c
Left join 
	(Select 
		bshfoc.survey5YearsId ID,
		behaviourSoughtHelpFromOrganisationTypeName [Organisation Type],
		cast(bshfoc.behaviourSoughtHelpFromOrganisationTypeId as varchar) as 'Organisation'

	   from survey5Years_referenceBehaviourSoughtHelpFromOrganisationType_chews bshfoc

	inner join  referenceBehaviourSoughtHelpFromOrganisationType refbshfos

		on refbshfos.behaviourSoughtHelpFromOrganisationTypeId = bshfoc.behaviourSoughtHelpFromOrganisationTypeId
	) bshfoc
	PIVOT
	
	(min([Organisation Type]) For Organisation
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtbshfoc on pvtbshfoc.ID = s.survey5YearsID
  
-- 13 "Toby" excessively licks people/objects/surfaces (please do not include behaviour related to food, e.g. licking his/her bowl/countertops where food has been prepared)...
left join referenceBehaviourFrequency bf13
  on bf13.behaviourFrequencyId = s.behaviourFrequencyId_licks
  
-- 13.1 Toby does this when…
Left join 
	(Select 
		bwl.survey5YearsId ID,
		behaviourWhenName [Behaviour Type],
		cast(bwl.behaviourWhenId as varchar) as 'Behaviour'

	   from survey5Years_referenceBehaviourWhen_licks bwl

	inner join  referenceBehaviourWhen refbwl

		on refbwl.behaviourWhenId = bwl.behaviourWhenId
	) bwl
	PIVOT
	
	(min([Behaviour Type]) For Behaviour
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	) 
	pvtbwl on pvtbwl.ID = s.survey5YearsID
  
-- 13.2 "Toby" excessively licks….
Left join 
	(Select 
		bel.survey5YearsId ID,
		behaviourExcessivelyLicksName [Lick Type],
		cast(bel.behaviourExcessivelyLicksId as varchar) as 'Lick'

	   from survey5Years_referenceBehaviourExcessivelyLicks bel

	inner join  referenceBehaviourExcessivelyLicks refbel

		on refbel.behaviourExcessivelyLicksId = bel.behaviourExcessivelyLicksId
	) bel
	PIVOT
	
	(min([Lick Type]) For Lick
		IN ([1], [2], [3], [4], [5], [6])
	) 
	pvtbel on pvtbel.ID = s.survey5YearsID
  
-- 13.3 When "Toby" does this behaviour, I usually…
Left join 
	(Select 
		burl.survey5YearsId ID,
		behaviourUsualReactionName [Reaction Type],
		cast(burl.behaviourUsualReactionId as varchar) as 'Reaction'

	   from survey5Years_referenceBehaviourUsualReaction_licks burl

	inner join  referenceBehaviourUsualReaction refbur

		on refbur.behaviourUsualReactionId = burl.behaviourUsualReactionId
	) burl
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19])
	) 
	pvtburl on pvtburl.ID = s.survey5YearsID
  
-- 13.4.1 I sought help from…
Left join 
	(Select 
		bshfl.survey5YearsId ID,
		behaviourSoughtHelpFromName [Help Type],
		cast(bshfl.behaviourSoughtHelpFromId as varchar) as 'Help'

	   from survey5Years_referenceBehaviourSoughtHelpFrom_licks bshfl

	inner join  referenceBehaviourSoughtHelpFrom refbshfs

		on refbshfs.behaviourSoughtHelpFromId = bshfl.behaviourSoughtHelpFromId
	) bshfl
	PIVOT
	
	(min([Help Type]) For Help
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	) 
	pvtbshfl on pvtbshfl.ID = s.survey5YearsID 
  
-- 13.4.1.c ***If 'Animal welfare organisation (staff or online resources' is selected, then ask Q13.4.1.c
Left join 
	(Select 
		bshfol.survey5YearsId ID,
		behaviourSoughtHelpFromOrganisationTypeName [Organisation Type],
		cast(bshfol.behaviourSoughtHelpFromOrganisationTypeId as varchar) as 'Organisation'

	   from survey5Years_referenceBehaviourSoughtHelpFromOrganisationType_licks bshfol

	inner join  referenceBehaviourSoughtHelpFromOrganisationType refbshfos

		on refbshfos.behaviourSoughtHelpFromOrganisationTypeId = bshfol.behaviourSoughtHelpFromOrganisationTypeId
	) bshfol
	PIVOT
	
	(min([Organisation Type]) For Organisation
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtbshfol on pvtbshfol.ID = s.survey5YearsID
  
-- 14 "Toby" barks a lot/excessively... 
left join referenceBehaviourFrequency bf14
  on bf14.behaviourFrequencyId = s.behaviourFrequencyId_barks
  
-- 14.1 "Toby" barks a lot/excessively when…
Left join 
	(Select 
		bebw.survey5YearsId ID,
		behaviourExcessivelyBarksWhenName [Behaviour Type],
		cast(bebw.behaviourExcessivelyBarksWhenId as varchar) as 'Behaviour'

	   from survey5Years_referenceBehaviourExcessivelyBarksWhen bebw

	inner join  referenceBehaviourExcessivelyBarksWhen refbebw

		on refbebw.behaviourExcessivelyBarksWhenId = bebw.behaviourExcessivelyBarksWhenId
	) bebw
	PIVOT
	
	(min([Behaviour Type]) For Behaviour
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	) 
	pvtbebw on pvtbebw.ID = s.survey5YearsID
  
-- 14.2 When "Toby" does this behaviour, I usually…
Left join 
	(Select 
		burb.survey5YearsId ID,
		behaviourUsualReactionName [Reaction Type],
		cast(burb.behaviourUsualReactionId as varchar) as 'Reaction'

	   from survey5Years_referenceBehaviourUsualReaction_barks burb

	inner join  referenceBehaviourUsualReaction refbur

		on refbur.behaviourUsualReactionId = burb.behaviourUsualReactionId
	) burb
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19])
	) 
	pvtburb on pvtburb.ID = s.survey5YearsID
  
-- 14.4.1 I sought help from…
Left join 
	(Select 
		bshfb.survey5YearsId ID,
		behaviourSoughtHelpFromName [Help Type],
		cast(bshfb.behaviourSoughtHelpFromId as varchar) as 'Help'

	   from survey5Years_referenceBehaviourSoughtHelpFrom_barks bshfb

	inner join  referenceBehaviourSoughtHelpFrom refbshfs

		on refbshfs.behaviourSoughtHelpFromId = bshfb.behaviourSoughtHelpFromId
	) bshfb
	PIVOT
	
	(min([Help Type]) For Help
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
	) 
	pvtbshfb on pvtbshfb.ID = s.survey5YearsID 
  
-- 14.4.1.c ***If 'Animal welfare organisation (staff or online resources' is selected, then ask Q14.4.1.c
Left join 
	(Select 
		bshfob.survey5YearsId ID,
		behaviourSoughtHelpFromOrganisationTypeName [Organisation Type],
		cast(bshfob.behaviourSoughtHelpFromOrganisationTypeId as varchar) as 'Organisation'

	   from survey5Years_referenceBehaviourSoughtHelpFromOrganisationType_barks bshfob

	inner join  referenceBehaviourSoughtHelpFromOrganisationType refbshfos

		on refbshfos.behaviourSoughtHelpFromOrganisationTypeId = bshfob.behaviourSoughtHelpFromOrganisationTypeId
	) bshfob
	PIVOT
	
	(min([Organisation Type]) For Organisation
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtbshfob on pvtbshfob.ID = s.survey5YearsID
  
-- 15 "Toby" always seems to be hungry…
left join referenceExcellentAppetiteLevel eal
  on eal.excellentAppetiteLevelId = s.excellentAppetiteLevelId_hungry
  
-- 16 When "Toby" goes to a place he/she hasn't been before, he/she…
/*---Gets excited---*/
left join referenceBehaviourFrequency bfge
  on bfge.behaviourFrequencyId = s.behaviourFrequencyId_getsExcited 
  
/*---Explores---*/
left join referenceBehaviourFrequency bfe
  on bfe.behaviourFrequencyId = s.behaviourFrequencyId_explores 
  
/*---Is calm---*/
left join referenceBehaviourFrequency bfic
  on bfic.behaviourFrequencyId = s.behaviourFrequencyId_isCalm 
  
/*---Sticks close to me/us---*/
left join referenceBehaviourFrequency bfsc
  on bfsc.behaviourFrequencyId = s.behaviourFrequencyId_sticksClose 
  
/*---Is unresponsive---*/
left join referenceBehaviourFrequency bfiu
  on bfiu.behaviourFrequencyId = s.behaviourFrequencyId_isUnresponsive 
  
-- 17 "Toby" starts play sessions with me/us (for example bringing toys)…
left join referenceBehaviourFrequency bf17
  on bf17.behaviourFrequencyId = s.behaviourFrequencyId_startsPlaySessions
  
-- 18 "Toby" has an excellent appetite... 
left join referenceExcellentAppetiteLevel eal18
  on eal18.excellentAppetiteLevelId = s.excellentAppetiteLevelId_appetite
 
-- 19 Toby shows restless/agitated behaviour... 
left join referenceBehaviourFrequency bf19
  on bf19.behaviourFrequencyId = s.behaviourFrequencyId_restlessBehaviour
  
-- 20 "Toby" shows irritable behaviour (for example grumbling, growling or snapping in situations when this would not normally happen)...
left join referenceBehaviourFrequency bf20
  on bf20.behaviourFrequencyId = s.behaviourFrequencyId_irritableBehaviour
  
-- 21 "Toby" has restless sleep/wakes at night... 
left join referenceBehaviourFrequency bf21
  on bf21.behaviourFrequencyId = s.behaviourFrequencyId_restlessSleep

-- 22 "Toby" spends much of the day asleep... 
left join referenceBehaviourFrequency bf22
  on bf22.behaviourFrequencyId = s.behaviourFrequencyId_dayAsleep
  
-- 23 "Toby" urinates(wees)/defecates(poos) indoors…
left join referenceBehaviourFrequency bf23
  on bf23.behaviourFrequencyId = s.behaviourFrequencyId_urinatesIndoors
  
-- 24 "Toby" does not or barely signals that he/she needs to go out to urinate(wee)/defecate(poo)... 
left join referenceBehaviourFrequency bf24
  on bf24.behaviourFrequencyId = s.behaviourFrequencyId_urinatesBarelySignals
 
-- 25 "Toby" goes outdoors, then returns indoors and urinates(wees)/defecates(poos)... 
left join referenceBehaviourFrequency bf25
  on bf25.behaviourFrequencyId = s.behaviourFrequencyId_urinatesOnReturn
  
-- 26 "Toby" has difficulties with/is unable to recognise familiar people/pets... 
left join referenceBehaviourFrequency bf26
  on bf26.behaviourFrequencyId = s.behaviourFrequencyId_unableToRecognisePeople
 
-- 27 "Toby" gets lost/disorientated in familiar areas (inside or outside)... 
left join referenceBehaviourFrequency bf27
  on bf27.behaviourFrequencyId = s.behaviourFrequencyId_disorientatedFamilarPlaces
  
-- 28 "Toby" does not respond to known commands and tricks... 
left join referenceBehaviourFrequency bf28
  on bf28.behaviourFrequencyId = s.behaviourFrequencyId_noResponseToKnownCommands
  
-- 32 "Toby" is slow/unable to learn new tasks... 
left join referenceBehaviourFrequency bf32
  on bf32.behaviourFrequencyId = s.behaviourFrequencyId_unableToLearnNewTricks
  
  
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