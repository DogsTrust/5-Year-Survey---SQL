select 
  s.dogId,
	s.userId ,
	s.survey5YearsId [5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
  -- Q1: In the last six months, I have taken "Toby" to a veterinary practice…
  s.vetVisitPrev6MthType [Q1: Vet Visit Last 6 Months ID],
  VetVisL6m.vetVisitPrev6MthTypeName [Q1: Vet Visit Last 6 Months Desc],
  -- Q2: The vet...
  pvtva.[1] [Q2: Carried out a routine health check],
  pvtva.[2] [Q2: Inserted a microchip],
  pvtva.[3] [Q2: Provided or administered flea and/or worm prevention],
  pvtva.[4] [Q2: Provided or administered flea and/or worm treatment],
  pvtva.[5] [Q2: Carried out an examination or treatment for another ailment/condition],
  pvtva.[6] [Q2: Carried out an operation that required a general anaesthetic],
  pvtva.[7] [Q2: Vaccinated my dog],
  pvtva.[8] [Q2: Other reason for a visit, for example for weighing. (Please specify…) ID],
  s.otherVetActionType [Q2: Other reason for a visit, for example for weighing. (Please specify…) Desc],
  -- Q6.1: During the last six months, "Toby" has been administered worming products…
  s.wormingFrequencyId [Q6.1: Worming Frequency (Last 6 Months) ID],
  wf.wormingFrequencyName [Q6.1: Worming Frequency (Last 6 Months) Desc],
  s.otherWormingFrequencyName [Q6.1: Worming Frequency (Last 6 Months: Other (Please Specify)],
  -- Q6.2: The worming product(s) that "Toby" has been administered is(/are)  (if you have used more than one worming product please let us know the timeframe/frequency that you used each product for)……
  s.otherWormingProductsDetail [Q6.2: Worming Product Detail],
  s.otherWormingProductsDetailRemembered [Q6.2: Worming Product Detail: Can't remember ID],
  CASE 
    WHEN s.otherWormingProductsDetailRemembered = 0 THEN 'I don''t know/can''t remember'
  END [Q6.2: Worming Product Detail: Can't remember Desc], 
  -- Q6.2.1: The treatment(s) was/were…
  pvttpt_worm.[1] [Q6.2.1: To treat an existing problem],
  pvttpt_worm.[2] [Q6.2.1: To prevent any problems],
  -- Q6.3: During the last six months, the number of times that "Toby" has been administered flea control products is…
  s.treatmentAdministeredFrequencyId_fleas [Q6.3: Flea Treatment Frequency (Last 6 Months) ID],
  taf_flea.treatmentAdministeredFrequencyName [Q6.3: Flea Treatment Frequency (Last 6 Months) Desc],
  s.otherTreatmentAdministeredFrequencyName_fleas [Q6.3: Flea Treatment Frequency (Last 6 Months): Other (Please Specify)],
  -- Q6.4 The flea control product(s) that "Toby" has been administered is(/are) (if you have used more than one flea control product please let us know the timeframe/frequency that you used each product for)…
  s.otherFleasProductsDetail[Q6.4: Flea Control Product Detail],
  s.otherFleasProductsDetailRemembered [Q6.4: Flea Product Detail: Can't remember ID],
  CASE 
    WHEN s.otherFleasProductsDetailRemembered = 0 THEN 'I don''t know/can''t remember'
  END [Q6.4: Flea Product Detail: Can't remember Desc],
  -- Q6.4.1: The treatment(s) was/were…
  pvttpt_fleas.[1] [Q6.4.1: To treat an existing problem],
  pvttpt_fleas.[2] [Q6.4.1: To prevent any problems],
  -- Q6.5: During the last six months, the number of times that "Toby" has been administered tick control products (separately or combined with flea control products) is…
  s.treatmentAdministeredFrequencyId_ticks [Q6.5: Tick Treatment Frequency (Last 6 Months) ID],
  taf_tick.treatmentAdministeredFrequencyName [Q6.5: Tick Treatment Frequency (Last 6 Months) Desc],
  s.otherTreatmentAdministeredFrequencyName_ticks [Q6.5: Tick Treatment Frequency (Last 6 Months): Other (Please Specify)],
  -- Q6.6: The tick control product(s) that "Toby" has been administered is(/are) (if you have used more than one flea control product please let us know the timeframe/frequency that you used each product for)…
  s.otherTicksProductsDetail [Q6.6 Tick Control Product Detail],
  s.otherTicksProductsDetailRemembered [Q6.6: Tick Product Detail: Can't remember ID],
  CASE 
    WHEN s.otherTicksProductsDetailRemembered = 0 THEN 'I don''t know/can''t remember'
  END [Q6.6: Tick Product Detail: Can't remember Desc],
  -- Q6.6.1: The treatment(s) was/were…
  pvttpt_ticks.[1] [Q6.6.1: To treat an existing problem],
  pvttpt_ticks.[2] [Q6.6.1: To prevent any problems],
  -- Q7: "Toby" was most recently vaccinated…
  s.mostRecentlyVaccinatedId [Q7: Most Recently Vaccinated ID],
  lv.lastVaccDateName [Q7: Most Recently Vaccinated Desc],
  -- Q7.1: "Toby" has not been vaccinated (at all or within the last 12 months) because…
  s.notVaccinatedReasonId [Q7.1: Reason Not Vaccinated (Last 12 Months) ID],
  rnv.notVaccinatedReasonName [Q7.1: Reason Not Vaccinated (Last 12 Months) Desc],
  s.otherNotVaccinatedReason [Q7.1: Reason Not Vaccinated (Last 12 Months): Other (Please Specify)],
  -- Q8: I am happy to upload a photo/scan of "Toby's" vaccination card…
  s.ableToScanVaccRecords [Q8: Able to Scan Vaccination Card ID],
  scvc.ableToScanVaccCardTypeName [Q8: Able to Scan Vaccination Card Desc],
  -- Q8a: ***if yes then option for upload needs to be put on dashboard***
  -- Q9: "Toby"'s last vaccination was for…
  pvtvreas.[1] [Q9: I don't know/can't remember],
  pvtvreas.[2] [Q9: Canine Distemper],
  pvtvreas.[3] [Q9: Hepatitis],
  pvtvreas.[4] [Q9: Parvovirus],
  pvtvreas.[5] [Q9: Leptospirosis],
  pvtvreas.[6] [Q9: Rabies],
  pvtvreas.[7] [Q9: Kennel cough (KC/Bordetella bronchiseptica)],
  pvtvreas.[8] [Q9: Other(s) (please list all) ID],
  s.otherVaccReasonName [Q9: Other(s) (please list all) Desc],
  -- Q10: During the two days following "Toby"'s most recent vaccination, "Toby"…
  pvtlastvacrct.[1] [Q10: Was only vaccinated today or yesterday],
  pvtlastvacrct.[2] [Q10: Seemed as normal with no ill effects],
  pvtlastvacrct.[3] [Q10: Was off his/her food],
  pvtlastvacrct.[4] [Q10: Developed a lump or swelling on the vaccination site],
  pvtlastvacrct.[5] [Q10: Showed a general skin reaction (for example irritation or hair loss)],
  pvtlastvacrct.[6] [Q10: Seemed lethargic or "off colour"],
  pvtlastvacrct.[7] [Q10: Had a change of behaviour],
  pvtlastvacrct.[8] [Q10: Had vomiting or diarrhoea],
  pvtlastvacrct.[9] [Q10: Had an other adverse response (please specify) ID],
  s.otherReactionToVaccinationType [Q10: Had an other adverse response (please specify) Desc],
  -- Q11: Please provide more details if you are happy to do so.
  s.otherRecentVaccinationDetails [Q11: Adverse Response Detail],
  -- Q12: After which of these vaccines, did "Toby" have a reaction…
  pvtlastvaccrctto.[1] [Q12: The canine distemper/parvovirus/canine hepatitis booster],
  pvtlastvaccrctto.[2] [Q12: Leptospirosis],
  pvtlastvaccrctto.[3] [Q12: Rabies],
  pvtlastvaccrctto.[4] [Q12: Kennel cough],
  pvtlastvaccrctto.[5] [Q12: I don't know/can't remember],
  pvtlastvaccrctto.[6] [Q12: Other (please specify) ID],
  s.otherVaccReactionName [Q12: Other (please specify) Desc],
  -- Q13: In the last six months, "Toby" has had...
  pvthp.[1] [Q13: No health problems],
  pvthp.[2] [Q13: A lack of appetite],
  pvthp.[3] [Q13: A cough or sneeze],
  pvthp.[4] [Q13: An ear problem (for example scratching ear more than usual)],
  pvthp.[5] [Q13: A skin problem (for example itching, lumps, swellings, rashes)],
  pvthp.[6] [Q13: An eye problem (for example conjunctivitis)],
  pvthp.[7] [Q13: A tooth/mouth problem (excluding loss of milk teeth)],
  pvthp.[8] [Q13: Intermittent lameness/limb problem (for example, 'bunny hopping' from time to time)],
  pvthp.[9] [Q13: Persistent lameness/limb problem],
  pvthp.[10] [Q13: Fracture or break in a leg(s)],
  pvthp.[11] [Q13: Dislocation of a joint],
  pvthp.[12] [Q13: A cut or wound],
  pvthp.[13] [Q13: Another small injury],
  pvthp.[14] [Q13: An injury caused by catching/carrying/picking up/playing with a stick],
  pvthp.[15] [Q13: A period of being lethargic/quieter than usual/not him/herself],
  pvthp.[16] [Q13: One or more instances of collapsing whilst gently walking],
  pvthp.[17] [Q13: One or more instances of collapsing whilst exercising/playing],
  pvthp.[18] [Q13: One or more instances when he/she has seemed to temporarily stop breathing whilst asleep],
  pvthp.[19] [Q13: Vomiting/sickness],
  pvthp.[20] [Q13: Difficulty swallowing and/or keeping food down/choking/gagging/regurgitating food],
  pvthp.[21] [Q13: A dog bite],
  pvthp.[22] [Q13: One or more instances of noisy breathing (for example snoring/snorting/wheezing)],
  pvthp.[23] [Q13: One or more instances of heavy/laboured breathing whilst exercising/playing],
  pvthp.[24] [Q13: One or more instances of heavy/laboured breathing whilst gently walking],
  pvthp.[25] [Q13: Fleas],
  pvthp.[26] [Q13: Worms],
  pvthp.[27] [Q13: Anal gland problems (rubbing bottom along ground)],
  pvthp.[28] [Q13: A problem with his/her tail (for example 'limber tail', 'cold tail', 'swimmers tail', stiff/droopy/limp tail)],
  pvthp.[29] [Q13: Other injuries or illness (please give full details) ID],
  s.otherHealthProblemType [Q13: Other injuries or illness (please give full details) Desc],
  -- Q20 I notice that "Toby" has flatulence/gas/farts/passes wind...
  s.frequencyOfFartsId [Q20: Fart Frequency ID],
  fof.frequencyOfFartsName [Q20: Fart Frequency Desc],
  -- Q21 I notice that "Toby" has constipation...
  s.frequencyOfConstipationId [Q21: Constipation Frequency ID],
  foc.frequencyOfConstipationName [Q21: Constipation Frequency Desc],
  -- Q22 I notice that "Toby" has diarrhoea...
  s.frequencyOfDiarrhoeaId [Q22: Diarrhoea Frequencey ID],
  fod.frequencyOfDiarrhoeaName [Q22: Diarrhoea Frequencey Desc],
  -- Q23 "Toby" has other tummy/diet-related problems that I am aware of….
  s.otherDietProblemsId [Q23: Other Dietary Problems ID],
  odp.otherDietProblemsName [Q23: Other Dietary Problems Desc],
  -- Q23a Please provide further information about these tummy/diet-related problems….
  s.otherTummy [Q23a: Other Dietary Problems Detail],
  -- Q23.1.a During the last six months, have you seen any ticks on "Toby"?
  s.noticedTicksId [Q23.1.a: Noticed Ticks In Past 6 Months ID],
  CASE 
    WHEN s.noticedTicksId = 1 THEN 'No'
    WHEN s.noticedTicksId = 2 THEN 'Yes'
    WHEN s.noticedTicksId = 3 THEN 'I don''t know/can''t remember'
  END [Q23.1.a: Noticed Ticks In Past 6 Months Desc],
  -- Q24 Within the last six months, "Toby" has had his/her anal glands squeezed/expressed/emptied…
  s.analGlandTreatmentFrequencyId [Q24: Frequency Anal Glands Emptied (Last 6 Months) ID],
  agtf.analGlandTreatmentFrequencyName [Q24: Frequency Anal Glands Emptied (Last 6 Months) Desc],
  -- Q25 "Toby"'s anal glands were squeezed/expressed /emptied by…
  pvtagtt.[1] [Q25: A vet/vet nurse],
  pvtagtt.[2] [Q25: Another canine professional (for example dog groomer)],
  pvtagtt.[3] [Q25: By a household member (if not a vet/vet nurse/canine professional)],
  pvtagtt.[4] [Q25: Other (please specify) ID],
  s.otherAnalGlandTreatmentTypeName [Q25: Other (please specify) Desc],
  -- Q26 On a scale of 0 to 5 "Toby"'s eyesight seems to be…
  s.eyesightScaleId [Q26: Eyesight Level ID],
  es.eyesightScaleName [Q26: Eyesight Level Desc],
  -- Q26.1 I think that "Toby"'s eyesight is not excellent because…
  pvtepr.[1] [Q26.1: My vet informed me],
  pvtepr.[2] [Q26.1: He/she bumps into things sometimes],
  pvtepr.[3] [Q26.1: He/she doesn't easily spot me when off lead on a walk],
  pvtepr.[4] [Q26.1: He/she struggles to see treats/toys],
  pvtepr.[5] [Q26.1: He/she struggles with negotiating steps/obstacles],
  pvtepr.[6] [Q26.1: Other (please specify) ID],
  s.otherEyesightProblemReasonName [Q26.1: Other (please specify) Desc],
  -- Q27 On a scale of 0 to 5 "Toby"'s hearing seems to be…
  s.hearingScaleId [Q27 Hearing Level ID],
  hs.hearingScaleName [Q27 Hearing Level Desc],
  -- Q27.1 I think that "Toby"'s hearing is not excellent because…
  pvthpr.[1] [Q27.1: My vet informed me],
  pvthpr.[2] [Q27.1: He/she is easily startled],
  pvthpr.[3] [Q27.1: He/she has poor recall],
  pvthpr.[4] [Q27.1: He/she barks excessively],
  pvthpr.[5] [Q27.1: He/she is difficult to wake up],
  pvthpr.[6] [Q27.1: He/she does not react to sounds, when I would expect him/her to react],
  pvthpr.[7] [Q27.1: He/she struggles with negotiating steps/obstacles],
  pvthpr.[8] [Q27.1: Other (please specify) ID],
  s.otherHearingProblemReasonName [Q27.1: Other (please specify) Desc],
  -- Q39.5 Please use the space below to tell us any information about possible adverse effects (side effects) that "Toby" has experienced when administered medication (if possible ,please specify which medication and "Toby's" reaction)
  s.possibleMedicationAdverseEffectsDetail [Q39.5 Adverse Effect to Medication Detail],
  -- Q40 Within the last six months, "Toby" has been given herbal and/or homeopathic medication(s) that were prescribed by a vet and/or bought at a veterinary practice…
  s.homeopathicPrescriptionFrequencyId [Q40: Recieved Prescription Homeopathic Medication in Last 6 Months ID],
  CASE
    WHEN s.homeopathicPrescriptionFrequencyId = 1 THEN 'Yes'
    WHEN s.homeopathicPrescriptionFrequencyId = 2 THEN 'No'
    WHEN s.homeopathicPrescriptionFrequencyId = 3 THEN 'I don''t know/can''t remember'
    WHEN s.homeopathicPrescriptionFrequencyId = 4 THEN 'I would rather not say'
  END [Q40: Recieved Prescription Homeopathic Medication in Last 6 Months Desc],
  -- Q40.1 If you are willing, please use the space below to tell us which herbal and/or homeopathic medication(s) from your vet/veterinary practice you gave "Toby" and the reason(s) for using this(/these) for him/her
  s.homeopathicPrescriptionDetails [Q40.1 Prescription Homeopathic Medication Details],
  -- Q41 Within the last six months, "Toby" has been given herbal and/or homeopathic medication(s) that were NOT prescribed by a vet or bought at a veterinary practice…
  s.homeopathicNonPrescriptionFrequencyId [Q41: Recieved Non-Prescription Homeopathic Medication in Last 6 Months ID],
  CASE
    WHEN s.homeopathicNonPrescriptionFrequencyId = 1 THEN 'Yes'
    WHEN s.homeopathicNonPrescriptionFrequencyId = 2 THEN 'No'
    WHEN s.homeopathicNonPrescriptionFrequencyId = 3 THEN 'I don''t know/can''t remember'
    WHEN s.homeopathicNonPrescriptionFrequencyId = 4 THEN 'I would rather not say'
  END [Q41: Recieved Non-Prescription Homeopathic Medication in Last 6 Months Desc],
  -- Q41.1 If you are willing, please use the space below to tell us which herbal and/or homeopathic medication(s) you gave "Toby" and the reason(s) for using this(/these) for him/her
  s.homeopathicNonPrescriptionDetails [Q41.1 Non-Prescription Homeopathic Medication Details],
  -- Q224: I have noticed "Toby" having an unusual episode or funny turn (please see this list of examples of what we consider as examples of 'unusual episodes or funny turns')…
  s.unusualEpisodesNoticedId [Q224: Noticed Unusual Episode ID],
  CASE
    WHEN s.unusualEpisodesNoticedId = '1' THEN 'Yes'
    WHEN s.unusualEpisodesNoticedId = '2' THEN 'No'
    WHEN s.unusualEpisodesNoticedId = '3' THEN 'Unsure'
  END [Q224: Noticed Unusual Episode Desc],
  -- Q224a: During the unusual episode or funny turn,"Toby"was noted to...
  pvtuead.[1] [Q224a: Fall over or collapse for no apparent reason],
  pvtuead.[2] [Q224a: Become unconscious],
  pvtuead.[3] [Q224a: Be difficult to wake],
  pvtuead.[4] [Q224a: Have a floppy/limp body],
  pvtuead.[5] [Q224a: Have a stiff body],
  pvtuead.[6] [Q224a: Have running or paddling movements while lying down],
  pvtuead.[7] [Q224a: Have twitching around the face],
  pvtuead.[8] [Q224a: Have repeated blinking],
  pvtuead.[9] [Q224a: Have repeated head shaking],
  pvtuead.[10] [Q224a: Have twitching of leg(s) while awake],
  pvtuead.[11] [Q224a: Have twitching of leg(s) while asleep],
  pvtuead.[12] [Q224a: Have excessive drooling unrelated to food],
  pvtuead.[13] [Q224a: Snap or bite at the air (as if chasing flies)],
  pvtuead.[14] [Q224a: Appear to fixate on, or stare at, something that is not there; follow or chase something that does not seem to be there],
  pvtuead.[15] [Q224a: Run away from something that was not there],
  pvtuead.[16] [Q224a: Look 'zoned out' or in a trance],
  pvtuead.[17] [Q224a: Hide away or go off for no apparent reason],
  pvtuead.[18] [Q224a: Not respond to my voice],
  pvtuead.[19] [Q224a: Not be able to look me in the eye when spoken to],
  pvtuead.[20] [Q224a: Vomit],
  pvtuead.[21] [Q224a: Wee/urinate],
  pvtuead.[22] [Q224a: Poo/defaecate],
  pvtuead.[23] [Q224a: None of the above],
  pvtuead.[24] [Q224a: Other (please specify)],
  s.otherUnusualEpisodeActionDuring [Q224a: Other (please specify)],
  -- Q225: The first time "Toby" had an unusual episode/funny turn, he/she was aged…
  s.unusualEpisodeAgeAt [Q225: First Unusual Episode Age ID],
  ueage.unusualEpisodeAgeAtName [Q225: First Unusual Episode Age Desc],
  -- Q225.1: The last time "Toby" had an unusual episode/funny turn, he/she was aged…
  s.lastUnusualEpisodeAgeAt [Q225.1: Last Unusual Episode Age ID],
  lastueage.unusualEpisodeAgeAtName [Q225.1: Last Unusual Episode Age Desc],
  -- Q225.2: Have you previously provided us with information about "Toby"'s unusual episode(s)/funny turn(s)?
  s.previousInfoUnusualEpisodesId [Q225.2: Previously Provided Unusual Turns Information ID],
  piue.previousInfoUnusualEpisodesName [Q225.2: Previously Provided Unusual Turns Information Desc],
  -- Q225.3: The number of unusual episodes/funny turns that "Toby" has had during the last three months is…
  s.numberUnusualEpisodes [Q225.3: Total Number of Unusual Episodes in Last 3 Months],
  -- Q226: In total, "Toby" has had an unusual episode/funny turn…
  s.unusualEpisodeFrequency [Q226: Total Unusual Episode ID],
  uef.unusualEpisodeFrequencyName [Q226: Total Unusual Episode Desc],
  -- Q227: In general, "Toby's" unusual episodes or funny turns last…
  s.unusualEpisodeLength [Q227: Unusual Episode Length ID], 
  uel.unusualEpisodeLengthName [Q227: Unusual Episode Length Desc],
  -- Q228: "Toby" has had more than one unusual episode or funny turn in a 24 hour period...
  s.unusualEpisodeInLast24Hrs [Q228: Has Had Unusual Turn In Last 24 Hours ID],
  uel24h.unusualEpisodeInLast24HrsName [Q228: Has Had Unusual Turn In Last 24 Hours Desc], 
  -- Q229: Before "Toby's" last unusual episode or funny turn, I think he/she was…
  pvtuewd.[1] [Q229: Resting (but not asleep)],
  pvtuewd.[2] [Q229: Asleep],
  pvtuewd.[3] [Q229: Playing],
  pvtuewd.[4] [Q229: On a walk],
  pvtuewd.[5] [Q229: Running about],
  pvtuewd.[6] [Q229: Eating/Drinking],
  pvtuewd.[7] [Q229: Other (please specify) ID],
  s.otherUnusualEpisodeWasDoing [Q229: Other (please specify) Desc],
  -- Q330: Before "Toby's" last unusual episode or funny turn, I think he/she was...
  pvtuemb.[1] [Q330: Relaxed],
  pvtuemb.[2] [Q330: Tired],
  pvtuemb.[3] [Q330: Stressed],
  pvtuemb.[4] [Q330: Excited],
  pvtuemb.[5] [Q330: Frustrated],
  pvtuemb.[6] [Q330: Worried/anxious],
  pvtuemb.[7] [Q330: Scared],
  pvtuemb.[8] [Q330: I don't know],
  pvtuemb.[9] [Q330: Other (please specify) ID],
  s.otherUnusualEpisodeMoodBefore [Q330: Other (please specify) Desc],
  -- Q331: After having an unusual episode or funny turn, "Toby" is usually…
  pvtuea.[1] [Q331: Wobbly and unable to walk properly],
  pvtuea.[2] [Q331: Disorientated],
  pvtuea.[3] [Q331: Staring into space],
  pvtuea.[4] [Q331: Acting like he/she is blind or can't see very well (for example bumps into things)],
  pvtuea.[5] [Q331: Sleepy],
  pvtuea.[6] [Q331: Behaving like he/she does not recognise me or family members],
  pvtuea.[7] [Q331: Fearful/scared (for example hiding, whimpering)],
  pvtuea.[8] [Q331: Aggressive towards household members (for example growling, snarling, trying to bite)], 
  pvtuea.[9] [Q331: Restless/pacing around the house],
  pvtuea.[10] [Q331: Sniffing at things around the house],
  pvtuea.[11] [Q331: Hungry],
  pvtuea.[12] [Q331: Thirsty],
  pvtuea.[13] [Q331: Clingy/wants more attention than normal],
  pvtuea.[14] [Q331: Normal - none of these signs],
  -- Q332: "Toby's" unusual episodes/funny turns always look the same…
  s.unusualEpisodeAllSame [Q332: Unusual Episode Always Same ID],
  CASE
    WHEN s.unusualEpisodeAllSame = 0 THEN 'No'
    WHEN s.unusualEpisodeAllSame = 1 THEN 'Yes'
  END [Q332: Unusual Episode Always Same Desc],
  -- Q333: I took "Toby" to the vet because of his/her unusual episode(s)/funny turn(s)...
  s.unusualEpisodeVetVisit [Q333: Unusual Episode Vet Visit ID],
  uevv.unusualEpisodeVetVisitName [Q333: Unusual Episode Vet Visit Desc],
  -- Q334: "Toby" has had the following tests carried out…
  /*---Neurological examination---*/
  pvtuet1.[1] [Q334 (Neurological examination): Test not carried out],
  pvtuet1.[2] [Q334 (Neurological examination): Yes - results normal],
  pvtuet1.[3] [Q334 (Neurological examination): Yes - results abnormal],
  pvtuet1.[4] [Q334 (Neurological examination): yes - don't know/not sure about results],
  pvtuet1.[5] [Q334 (Neurological examination): Not sure if test was carried out],
  /*---Blood test(s) - a blood sample was collected by a vet---*/
  pvtuet2.[1] [Q334 (Blood test(s)): Test not carried out],
  pvtuet2.[2] [Q334 (Blood test(s)): Yes - results normal],
  pvtuet2.[3] [Q334 (Blood test(s)): Yes - results abnormal],
  pvtuet2.[4] [Q334 (Blood test(s)): yes - don't know/not sure about results],
  pvtuet2.[5] [Q334 (Blood test(s)): Not sure if test was carried out],
  /*---Urine test(s) - a urine sample was collected by a vet---*/
  pvtuet3.[1] [Q334 (Urine test(s)): Test not carried out],
  pvtuet3.[2] [Q334 (Urine test(s)): Yes - results normal],
  pvtuet3.[3] [Q334 (Urine test(s)): Yes - results abnormal],
  pvtuet3.[4] [Q334 (Urine test(s)): yes - don't know/not sure about results],
  pvtuet3.[5] [Q334 (Urine test(s)): Not sure if test was carried out],
  /*---MRI scan - a brain scan using an MRI machine was carried out by a vet---*/ 
  pvtuet4.[1] [Q334 (MRI scan): Test not carried out],
  pvtuet4.[2] [Q334 (MRI scan): Yes - results normal],
  pvtuet4.[3] [Q334 (MRI scan): Yes - results abnormal],
  pvtuet4.[4] [Q334 (MRI scan): yes - don't know/not sure about results],
  pvtuet4.[5] [Q334 (MRI scan): Not sure if test was carried out],
  /*---CT scan - a brain scan using a CT machine was carried out by a vet---*/
  pvtuet5.[1] [Q334 (CT scan): Test not carried out],
  pvtuet5.[2] [Q334 (CT scan): Yes - results normal],
  pvtuet5.[3] [Q334 (CT scan): Yes - results abnormal],
  pvtuet5.[4] [Q334 (CT scan): yes - don't know/not sure about results],
  pvtuet5.[5] [Q334 (CT scan): Not sure if test was carried out],
  /*---Lumbar puncture/cerebrospinal fluid analysis - a sample of the fluid that surrounds the brain and spinal cord was collected by a vet---*/
  pvtuet6.[1] [Q334 (Lumbar puncture/cerebrospinal fluid analysis): Test not carried out],
  pvtuet6.[2] [Q334 (Lumbar puncture/cerebrospinal fluid analysis): Yes - results normal],
  pvtuet6.[3] [Q334 (Lumbar puncture/cerebrospinal fluid analysis): Yes - results abnormal],
  pvtuet6.[4] [Q334 (Lumbar puncture/cerebrospinal fluid analysis): yes - don't know/not sure about results],
  pvtuet6.[5] [Q334 (Lumbar puncture/cerebrospinal fluid analysis): Not sure if test was carried out],
  /*---Ultrasound - a scan of the head using a probe to look at the shape of the skull was carried out by a vet---*/
  pvtuet7.[1] [Q334 (Ultrasound): Test not carried out],
  pvtuet7.[2] [Q334 (Ultrasound): Yes - results normal],
  pvtuet7.[3] [Q334 (Ultrasound): Yes - results abnormal],
  pvtuet7.[4] [Q334 (Ultrasound): yes - don't know/not sure about results],
  pvtuet7.[5] [Q334 (Ultrasound): Not sure if test was carried out],
  /*---Other test(s) - please specify---*/
  s.otherUnusualEpisodeTestsDetail,
  pvtuet8.[1] [Q334 (Other test(s) - please specify): Test not carried out],
  pvtuet8.[2] [Q334 (Other test(s) - please specify): Yes - results normal],
  pvtuet8.[3] [Q334 (Other test(s) - please specify): Yes - results abnormal],
  pvtuet8.[4] [Q334 (Other test(s) - please specify): yes - don't know/not sure about results],
  pvtuet8.[5] [Q334 (Other test(s) - please specify): Not sure if test was carried out],
  -- Q335: "Toby" has received a diagnosis for these unusual episodes/funny turns from a vet…
  s.unusualEpisodeDiagnosis [Q335: Unusual Episode Diagnosis ID],
  CASE
    WHEN s.unusualEpisodeDiagnosis = 0 THEN 'No'
    WHEN s.unusualEpisodeDiagnosis = 1 THEN 'Yes'
  END [Q335: Unusual Episode Diagnosis Desc],
  -- Q336: The vet diagnosed "Toby" with…
  s.unusualEpisodeDiagnosisType [Q336: Vet Diagnosed Toby With ID],
  uedt.unusualEpisodeDiagnosisTypeName [Q336: Vet Diagnosed Toby With Desc],
  s.otherUnusualEpisodeDiagnosisType [Q336: Vet Diagnosed Toby With: Other (Please Specify)],
  -- Q337: The vet referred "Toby" to see a specialist veterinary neurologist...
  s.unusualEpisodeReferralToSpecialist [Q337: Refered To Specialist ID],
  CASE
    WHEN s.unusualEpisodeReferralToSpecialist = 1 THEN 'Yes'
    WHEN s.unusualEpisodeReferralToSpecialist = 0 THEN 'No'
  END [Q337: Refered To Specialist Desc],
  -- Q338: Please use this box to provide further information about "Toby"'s health/illnesses/injuries/medication that has not been covered elsewhere in this section…
  s.otherHealthIllnesInjury [Q338: Further Information]
from survey5years s

-- Q1: In the last six months, I have taken "Toby" to a veterinary practice…
left join referenceVetVisitPrev6MthType VetVisL6m
  on VetVisL6m.vetVisitPrev6MthTypeId = s.vetVisitPrev6MthType

-- Q2: The vet...
Left join 
	(Select 
		va.survey5YearsId ID,
		vetActionTypeName [Action Type],
		cast(va.vetActionTypeId as varchar) as 'Action'

	   from survey5Years_referenceVetActionType va

	inner join  referenceVetActionType3 refva

		on refva.vetActionTypeId = va.vetActionTypeId
	) va
	PIVOT
	
	(min([Action Type]) For Action
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtva on pvtva.ID = s.survey5YearsID
  
-- Q6.1: During the last six months, "Toby" has been administered worming products…
left join referenceWormingFrequency wf
  on wf.wormingFrequencyId = s.wormingFrequencyId
  
-- Q6.2.1: The treatment(s) was/were…
Left join 
	(Select 
		tpt_worm.survey5YearsId ID,
		treatmentProblemTypeName [Treatment Type],
		cast(tpt_worm.treatmentProblemTypeId as varchar) as 'Treatment'

	   from survey5Years_referenceTreatmentProblemType_worming tpt_worm

	inner join  referenceTreatmentProblemType reftpt_worm

		on reftpt_worm.treatmentProblemTypeId = tpt_worm.treatmentProblemTypeId
	) tpt_worm
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2])
	) 
	pvttpt_worm on pvttpt_worm.ID = s.survey5YearsID
  
-- Q6.3: During the last six months, the number of times that "Toby" has been administered flea control products is… 
left join referenceTreatmentAdministeredFrequency taf_flea
  on taf_flea.treatmentAdministeredFrequencyId = s.treatmentAdministeredFrequencyId_fleas
  
-- Q6.4.1: The treatment(s) was/were…
Left join 
	(Select 
		tpt_fleas.survey5YearsId ID,
		treatmentProblemTypeName [Treatment Type],
		cast(tpt_fleas.treatmentProblemTypeId as varchar) as 'Treatment'

	   from survey5Years_referenceTreatmentProblemType_fleas tpt_fleas

	inner join  referenceTreatmentProblemType reftpt_fleas

		on reftpt_fleas.treatmentProblemTypeId = tpt_fleas.treatmentProblemTypeId
	) tpt_fleas
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2])
	) 
	pvttpt_fleas on pvttpt_fleas.ID = s.survey5YearsID
  
-- Q6.5: During the last six months, the number of times that "Toby" has been administered tick control products (separately or combined with flea control products) is…
left join referenceTreatmentAdministeredFrequency taf_tick
  on taf_tick.treatmentAdministeredFrequencyId = s.treatmentAdministeredFrequencyId_ticks
  
-- Q6.6.1: The treatment(s) was/were…
Left join 
	(Select 
		tpt_ticks.survey5YearsId ID,
		treatmentProblemTypeName [Treatment Type],
		cast(tpt_ticks.treatmentProblemTypeId as varchar) as 'Treatment'

	   from survey5Years_referenceTreatmentProblemType_ticks tpt_ticks

	inner join  referenceTreatmentProblemType reftpt_ticks

		on reftpt_ticks.treatmentProblemTypeId = tpt_ticks.treatmentProblemTypeId
	) tpt_ticks
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2])
	) 
	pvttpt_ticks on pvttpt_ticks.ID = s.survey5YearsID
  
-- Q7: "Toby" was most recently vaccinated…
left join referenceLastVaccDate2Years lv
  on lv.lastVaccDateId = s.mostRecentlyVaccinatedId
  
-- Q7.1: "Toby" has not been vaccinated (at all or within the last 12 months) because…
left join referenceNotVaccinatedReason2Years rnv
  on rnv.notVaccinatedReasonId = s.notVaccinatedReasonId
  
-- Q8: I am happy to upload a photo/scan of "Toby's" vaccination card…
left join referenceAbleToScanVaccCardType scvc
  on scvc.ableToScanVaccCardTypeId = s.ableToScanVaccRecords
  
-- Q9: "Toby"'s last vaccination was for…
Left join 
	(Select 
		vreas.survey5YearsId ID,
		lastVaccReasonName [Reason Type],
		cast(vreas.lastVaccReasonId as varchar) as 'Reason'

	   from survey5Years_referenceLastVaccReason vreas

	inner join  referenceLastVaccReason refvreas

		on refvreas.lastVaccReasonId = vreas.lastVaccReasonId
	) vreas
	PIVOT
	
	(min([Reason Type]) For Reason
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtvreas on pvtvreas.ID = s.survey5YearsID
  
-- Q10: During the two days following "Toby"'s most recent vaccination, "Toby"…
Left join 
	(Select 
		lastvacrct.survey5YearsId ID,
		reactionToVaccinationTypeName [Reaction Type],
		cast(lastvacrct.reactionToVaccinationTypeId as varchar) as 'Reaction'

	   from survey5Years_referenceReactionToVaccinationType lastvacrct

	inner join  referenceReactionToVaccinationType reflastvacrct

		on reflastvacrct.reactionToVaccinationTypeId = lastvacrct.reactionToVaccinationTypeId
	) lastvacrct
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9])
	) 
	pvtlastvacrct on pvtlastvacrct.ID = s.survey5YearsID
  
-- Q12: AfteR which of these vaccines, did "Toby" have a reaction…
Left join 
	(Select 
		lastvaccrctto.survey5YearsId ID,
		lastVaccReactionName [Vacc Type],
		cast(lastvaccrctto.lastVaccReactionId as varchar) as 'Vacc'

	   from survey5Years_referenceLastVaccReaction lastvaccrctto

	inner join  referenceLastVaccReaction reflastvaccrctto

		on lastvaccrctto.lastVaccReactionId = reflastvaccrctto.lastVaccReactionId
	) lastvaccrctto
	PIVOT
	
	(min([Vacc Type]) For Vacc
		IN ([1], [2], [3], [4], [5], [6])
	) 
	pvtlastvaccrctto on pvtlastvaccrctto.ID = s.survey5YearsID
  
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
	PIVOT
	
	(min([Problem Type]) For Problem
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25], [26], [27], [28], [29])
	) 
	pvthp on pvthp.ID = s.survey5YearsID
  
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
  
  on pvtsd.ID = s.survey5YearsID and  pvtsd.HID = pvthp.ID
 

-- Q20 I notice that "Toby" has flatulence/gas/farts/passes wind...
left join referenceFrequencyOfFarts fof
  on fof.frequencyOfFartsId = s.frequencyOfFartsId
  
-- Q21 I notice that "Toby" has constipation...
left join referenceFrequencyOfConstipation foc
  on foc.frequencyOfConstipationId = s.frequencyOfConstipationId
  
-- Q22 I notice that "Toby" has diarrhoea...
left join referenceFrequencyOfDiarrhoea fod
  on fod.frequencyOfDiarrhoeaId = s.frequencyOfDiarrhoeaId
  
-- Q23 "Toby" has other tummy/diet-related problems that I am aware of….
left join referenceOtherDietProblems odp
  on odp.otherDietProblemsId = s.otherDietProblemsId
  
-- Q24 Within the last six months, "Toby" has had his/her anal glands squeezed/expressed/emptied…
left join referenceAnalGlandTreatmentFrequency agtf
  on agtf.analGlandTreatmentFrequencyId = s.analGlandTreatmentFrequencyId
  
-- Q25 "Toby"'s anal glands were squeezed/expressed /emptied by…
Left join 
	(Select 
		agtt.survey5YearsId ID,
		analGlandTreatmentTypeName [Treatment Type],
		cast(agtt.analGlandTreatmentTypeId as varchar) as 'Treatment'

	   from survey5Years_referenceAnalGlandTreatmentType agtt

	inner join  referenceAnalGlandTreatmentType refagtt

		on agtt.analGlandTreatmentTypeId = refagtt.analGlandTreatmentTypeId
	) agtt
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2], [3], [4])
	) 
	pvtagtt on pvtagtt.ID = s.survey5YearsID  
  
-- Q26 On a scale of 0 to 5 "Toby"'s eyesight seems to be…
left join referenceEyesightScale es
  on es.eyesightScaleId = s.eyesightScaleId
  
-- Q26.1 I think that "Toby"'s eyesight is not excellent because…
Left join 
	(Select 
		epr.survey5YearsId ID,
		eyesightProblemReasonName [Problem Type],
		cast(epr.eyesightProblemReasonId as varchar) as 'Problem'

	   from survey5Years_referenceEyesightProblemReason epr

	inner join  referenceEyesightProblemReason refepr

		on epr.eyesightProblemReasonId = refepr.eyesightProblemReasonId
	) epr
	PIVOT
	
	(min([Problem Type]) For Problem
		IN ([1], [2], [3], [4], [5], [6])
	) 
	pvtepr on pvtepr.ID = s.survey5YearsID  
  
-- Q27 On a scale of 0 to 5 "Toby"'s hearing seems to be…
left join referenceHearingScale hs
  on hs.hearingScaleId = s.hearingScaleId
  
-- Q27.1 I think that "Toby"'s hearing is not excellent because…
Left join 
	(Select 
		hpr.survey5YearsId ID,
		hearingProblemReasonName [Problem Type],
		cast(hpr.hearingProblemReasonId as varchar) as 'Problem'

	   from survey5Years_referenceHearingProblemReason hpr

	inner join  referenceHearingProblemReason refhpr

		on hpr.hearingProblemReasonId = refhpr.hearingProblemReasonId
	) hpr
	PIVOT
	
	(min([Problem Type]) For Problem
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
  )
  pvthpr on pvthpr.ID = s.survey5YearsID  
  
--Q224a: During the unusual episode or funny turn,"Toby"was noted to...
Left join 
	(Select 
		uead.survey5YearsId ID,
		unusualEpisodeActionDuringName [Action Type],
		cast(uead.unusualEpisodeActionDuringId as varchar) as 'Action'

	   from survey5Years_referenceUnusualEpisodeActionDuring uead

	inner join  referenceUnusualEpisodeActionDuring refuead

		on uead.unusualEpisodeActionDuringId = refuead.unusualEpisodeActionDuringId
	) uead
	PIVOT
	
	(min([Action Type]) For Action
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24])
	) 
	pvtuead on pvtuead.ID = s.survey5YearsID  
  
-- Q225: The first time "Toby" had an unusual episode/funny turn, he/she was aged…
left join referenceUnusualEpisodeAgeAt5 ueage
  on ueage.unusualEpisodeAgeAtId = s.unusualEpisodeAgeAt
 
-- Q225.1: The last time "Toby" had an unusual episode/funny turn, he/she was aged…
left join referenceUnusualEpisodeAgeAt5 lastueage
  on lastueage.unusualEpisodeAgeAtId = s.lastUnusualEpisodeAgeAt
  
-- Q225.2: Have you previously provided us with information about "Toby"'s unusual episode(s)/funny turn(s)?
left join referencePreviousInfoUnusualEpisodes piue
  on piue.previousInfoUnusualEpisodesId = s.previousInfoUnusualEpisodesId
  
-- Q226: In total, "Toby" has had an unusual episode/funny turn…
left join referenceUnusualEpisodeFrequency uef
  on uef.unusualEpisodeFrequencyId = s.unusualEpisodeFrequency
  
-- Q227: In general, "Toby's" unusual episodes or funny turns last…
left join referenceUnusualEpisodeLength uel
  on uel.unusualEpisodeLengthId = s.unusualEpisodeLength
  
-- Q228: "Toby" has had more than one unusual episode or funny turn in a 24 hour period...
left join referenceUnusualEpisodeInLast24Hrs uel24h
  on uel24h.unusualEpisodeInLast24HrsId = s.unusualEpisodeInLast24Hrs
  
-- Q229: Before "Toby's" last unusual episode or funny turn, I think he/she was…
Left join 
	(Select 
		uewd.survey5YearsId ID,
		unusualEpisodeWasDoingName [Action Type],
		cast(uewd.unusualEpisodeWasDoingId as varchar) as 'Action'

	   from survey5Years_referenceUnusualEpisodeWasDoing uewd

	inner join  referenceUnusualEpisodeWasDoing refuewd

		on uewd.unusualEpisodeWasDoingId = refuewd.unusualEpisodeWasDoingId
	) uewd
	PIVOT
	
	(min([Action Type]) For Action
		IN ([1], [2], [3], [4], [5], [6], [7])
  )
  pvtuewd on pvtuewd.ID = s.survey5YearsID  
  
-- Q330: Before "Toby's" last unusual episode or funny turn, I think he/she was...
Left join 
	(Select 
		uemb.survey5YearsId ID,
		unusualEpisodeMoodBeforeName [Mood Type],
		cast(uemb.unusualEpisodeMoodBeforeId as varchar) as 'Mood'

	   from survey5Years_referenceUnusualEpisodeMoodBefore uemb

	inner join  referenceUnusualEpisodeMoodBefore refuemb

		on uemb.unusualEpisodeMoodBeforeId = refuemb.unusualEpisodeMoodBeforeId
	) uemb
	PIVOT
	
	(min([Mood Type]) For Mood
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9])
  )
  pvtuemb on pvtuemb.ID = s.survey5YearsID 
  
-- Q331: After having an unusual episode or funny turn, "Toby" is usually…
Left join 
	(Select 
		uea.survey5YearsId ID,
		unusualEpisodeAfterName [Action Type],
		cast(uea.unusualEpisodeAfterId as varchar) as 'Action'

	   from survey5Years_referenceUnusualEpisodeAfter uea

	inner join  referenceUnusualEpisodeAfter refuea

		on uea.unusualEpisodeAfterId = refuea.unusualEpisodeAfterId
	) uea
	PIVOT
	
	(min([Action Type]) For Action
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14])
  )
  pvtuea on pvtuea.ID = s.survey5YearsID 
  
-- Q333: I took "Toby" to the vet because of his/her unusual episode(s)/funny turn(s)...
left join referenceUnusualEpisodeVetVisit uevv
  on uevv.unusualEpisodeVetVisitId = s.unusualEpisodeVetVisit
  
-- Q334: "Toby" has had the following tests carried out…
/*---Neurological examination---*/
Left join 
	(Select 
		uet.survey5YearsId ID,
		UnusualEpisodeTestResultTypeName [Treatment Type],
		cast(uet.UnusualEpisodeTestResultTypeId as varchar) as 'Treatment'

	   from survey5Years_referenceUnusualEpisodeTests uet

	inner join  referenceUnusualEpisodeTestResultType refuetr

		on refuetr.UnusualEpisodeTestResultTypeId = uet.UnusualEpisodeTestResultTypeId
    
  where uet.UnusualEpisodeTestsId = 1
  
	) uet
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2], [3], [4], [5])
  )
  pvtuet1 on pvtuet1.ID = s.survey5YearsID 
/*---Blood test(s) - a blood sample was collected by a vet---*/
Left join 
	(Select 
		uet.survey5YearsId ID,
		UnusualEpisodeTestResultTypeName [Treatment Type],
		cast(uet.UnusualEpisodeTestResultTypeId as varchar) as 'Treatment'

	   from survey5Years_referenceUnusualEpisodeTests uet

	inner join  referenceUnusualEpisodeTestResultType refuetr

		on refuetr.UnusualEpisodeTestResultTypeId = uet.UnusualEpisodeTestResultTypeId
    
  where uet.UnusualEpisodeTestsId = 2
  
	) uet
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2], [3], [4], [5])
  )
  pvtuet2 on pvtuet2.ID = s.survey5YearsID 
/*---Urine test(s) - a urine sample was collected by a vet---*/
Left join 
	(Select 
		uet.survey5YearsId ID,
		UnusualEpisodeTestResultTypeName [Treatment Type],
		cast(uet.UnusualEpisodeTestResultTypeId as varchar) as 'Treatment'

	   from survey5Years_referenceUnusualEpisodeTests uet

	inner join  referenceUnusualEpisodeTestResultType refuetr

		on refuetr.UnusualEpisodeTestResultTypeId = uet.UnusualEpisodeTestResultTypeId
    
  where uet.UnusualEpisodeTestsId = 3
  
	) uet
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2], [3], [4], [5])
  )
  pvtuet3 on pvtuet3.ID = s.survey5YearsID 
/*---MRI scan - a brain scan using an MRI machine was carried out by a vet---*/
Left join 
	(Select 
		uet.survey5YearsId ID,
		UnusualEpisodeTestResultTypeName [Treatment Type],
		cast(uet.UnusualEpisodeTestResultTypeId as varchar) as 'Treatment'

	   from survey5Years_referenceUnusualEpisodeTests uet

	inner join  referenceUnusualEpisodeTestResultType refuetr

		on refuetr.UnusualEpisodeTestResultTypeId = uet.UnusualEpisodeTestResultTypeId
    
  where uet.UnusualEpisodeTestsId = 4
  
	) uet
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2], [3], [4], [5])
  )
  pvtuet4 on pvtuet4.ID = s.survey5YearsID 
/*---CT scan - a brain scan using a CT machine was carried out by a vet---*/
Left join 
	(Select 
		uet.survey5YearsId ID,
		UnusualEpisodeTestResultTypeName [Treatment Type],
		cast(uet.UnusualEpisodeTestResultTypeId as varchar) as 'Treatment'

	   from survey5Years_referenceUnusualEpisodeTests uet

	inner join  referenceUnusualEpisodeTestResultType refuetr

		on refuetr.UnusualEpisodeTestResultTypeId = uet.UnusualEpisodeTestResultTypeId
    
  where uet.UnusualEpisodeTestsId = 5
  
	) uet
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2], [3], [4], [5])
  )
  pvtuet5 on pvtuet5.ID = s.survey5YearsID 
/*---Lumbar puncture/cerebrospinal fluid analysis - a sample of the fluid that surrounds the brain and spinal cord was collected by a vet---*/
Left join 
	(Select 
		uet.survey5YearsId ID,
		UnusualEpisodeTestResultTypeName [Treatment Type],
		cast(uet.UnusualEpisodeTestResultTypeId as varchar) as 'Treatment'

	   from survey5Years_referenceUnusualEpisodeTests uet

	inner join  referenceUnusualEpisodeTestResultType refuetr

		on refuetr.UnusualEpisodeTestResultTypeId = uet.UnusualEpisodeTestResultTypeId
    
  where uet.UnusualEpisodeTestsId = 6
  
	) uet
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2], [3], [4], [5])
  )
  pvtuet6 on pvtuet6.ID = s.survey5YearsID 
/*---Ultrasound - a scan of the head using a probe to look at the shape of the skull was carried out by a vet---*/
Left join 
	(Select 
		uet.survey5YearsId ID,
		UnusualEpisodeTestResultTypeName [Treatment Type],
		cast(uet.UnusualEpisodeTestResultTypeId as varchar) as 'Treatment'

	   from survey5Years_referenceUnusualEpisodeTests uet

	inner join  referenceUnusualEpisodeTestResultType refuetr

		on refuetr.UnusualEpisodeTestResultTypeId = uet.UnusualEpisodeTestResultTypeId
    
  where uet.UnusualEpisodeTestsId = 7
  
	) uet
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2], [3], [4], [5])
  )
  pvtuet7 on pvtuet7.ID = s.survey5YearsID 
/*---Other test(s) - please specify---*/
 Left join 
	(Select 
		uet.survey5YearsId ID,
		UnusualEpisodeTestResultTypeName [Treatment Type],
		cast(uet.UnusualEpisodeTestResultTypeId as varchar) as 'Treatment'

	   from survey5Years_referenceUnusualEpisodeTests uet

	inner join  referenceUnusualEpisodeTestResultType refuetr

		on refuetr.UnusualEpisodeTestResultTypeId = uet.UnusualEpisodeTestResultTypeId
    
  where uet.UnusualEpisodeTestsId = 8
  
	) uet
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2], [3], [4], [5])
  )
  pvtuet8 on pvtuet8.ID = s.survey5YearsID 
  
-- Q336: The vet diagnosed "Toby" with…
left join referenceUnusualEpisodeDiagnosisType uedt
  on uedt.unusualEpisodeDiagnosisTypeId = s.unusualEpisodeDiagnosisType
  

  
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