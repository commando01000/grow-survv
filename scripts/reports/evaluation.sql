
If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEvaluationByCon' and
		        xtype = 'p')
Drop Procedure GetEvaluationByCon 
go
Create PROCEDURE GetEvaluationByCon @SurveyID int
as

declare @membersCount int =0
select @membersCount = count(distinct sm.MemberID) from SurveyMember Sm 
inner join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID



select count(SMA.AnswerID) AnswersCount , a.Weight AnswerWeight, q.Weight QWeight, gw.Weight govWeight , (count(SMA.AnswerID)* 1.0/@membersCount ) * a.Weight * gw.Weight Evaluation,
 A.AnswerID, A.ArName, A.EnName, 
 Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
 G.CountryID demoID , G.EnName demoEnName, G.ArName demoArName

from Answer A 
inner join Question Q on Q.QuestionID = a.QuestionID 
inner join SurveyMemberAnswer SMA on A.AnswerID = SMA.AnswerID and SMA.QuestionID = Q.QuestionID 
left join SurveyMember SM on SMA.SurveyMemberID = Sm.MemberID
left join Country G on SM.CountryID = G.CountryID 
left join CountryWeight GW on GW.CountryID = G.CountryID and GW.SurveyID = Q.SurveyID
where Q.SurveyID = @SurveyID

group by A.AnswerID, A.ArName, A.EnName, 
Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
q.QuestionOrder,a.Weight, q.Weight,gw.Weight,
G.CountryID , G.EnName , G.ArName 
order by q.QuestionOrder 

Go

If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEvaluationByGov' and
		        xtype = 'p')
Drop Procedure GetEvaluationByGov 
go
Create PROCEDURE GetEvaluationByGov @SurveyID int
as

declare @membersCount int =0
select @membersCount = count(distinct sm.MemberID) from SurveyMember Sm 
inner join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID



select count(SMA.AnswerID) AnswersCount , a.Weight AnswerWeight, q.Weight QWeight, gw.Weight govWeight , (count(SMA.AnswerID)* 1.0/@membersCount ) * a.Weight * gw.Weight Evaluation,
 A.AnswerID, A.ArName, A.EnName, 
 Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
 G.GovernrateID demoID , G.EnName demoEnName, G.ArName demoArName

from Answer A 
inner join Question Q on Q.QuestionID = a.QuestionID 
inner join SurveyMemberAnswer SMA on A.AnswerID = SMA.AnswerID and SMA.QuestionID = Q.QuestionID 
left join SurveyMember SM on SMA.SurveyMemberID = Sm.MemberID
left join Governrate G on SM.GovernrateID = G.GovernrateID 
left join GovernrateWeight GW on GW.GovernrateID = G.GovernrateID and GW.SurveyID = Q.SurveyID
where Q.SurveyID = @SurveyID

group by A.AnswerID, A.ArName, A.EnName, 
Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
q.QuestionOrder,a.Weight, q.Weight,gw.Weight,
G.GovernrateID , G.EnName , G.ArName 
order by q.QuestionOrder 

Go



If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEvaluationByBranch' and
		        xtype = 'p')
Drop Procedure GetEvaluationByBranch 
go
Create PROCEDURE GetEvaluationByBranch @SurveyID int
as

declare @membersCount int =0
select @membersCount = count(distinct sm.MemberID) from SurveyMember Sm 
inner join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID


select count(SMA.AnswerID) AnswersCount , a.Weight AnswerWeight, q.Weight QWeight, gw.Weight govWeight , (count(SMA.AnswerID)* 1.0/@membersCount ) * a.Weight * gw.Weight Evaluation,
 A.AnswerID, A.ArName, A.EnName, 
 Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
 G.BranchID demoID , G.NameEn demoEnName, G.NameAr demoArName

from Answer A 
inner join Question Q on Q.QuestionID = a.QuestionID 
inner join SurveyMemberAnswer SMA on A.AnswerID = SMA.AnswerID and SMA.QuestionID = Q.QuestionID 
left join SurveyMember SM on SMA.SurveyMemberID = Sm.MemberID
left join Branch G on SM.BranchID = G.BranchID 
left join BranchWeight GW on GW.BranchID = G.BranchID and GW.SurveyID = Q.SurveyID
where Q.SurveyID = @SurveyID

group by A.AnswerID, A.ArName, A.EnName, 
Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
q.QuestionOrder,a.Weight, q.Weight,gw.Weight,
G.BranchID , G.NameEn , G.NameAr 
order by q.QuestionOrder 

Go


If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEvaluationByArea' and
		        xtype = 'p')
Drop Procedure GetEvaluationByArea 
go
Create PROCEDURE GetEvaluationByArea @SurveyID int
as

declare @membersCount int =0
select @membersCount = count(distinct sm.MemberID) from SurveyMember Sm 
inner join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID



select count(SMA.AnswerID) AnswersCount , a.Weight AnswerWeight, q.Weight QWeight, gw.Weight govWeight , (count(SMA.AnswerID)* 1.0/@membersCount ) * a.Weight * gw.Weight Evaluation,
 A.AnswerID, A.ArName, A.EnName, 
 Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
 G.AreaID demoID , G.NameEn demoEnName, G.NameAr demoArName

from Answer A 
inner join Question Q on Q.QuestionID = a.QuestionID 
inner join SurveyMemberAnswer SMA on A.AnswerID = SMA.AnswerID and SMA.QuestionID = Q.QuestionID 
left join SurveyMember SM on SMA.SurveyMemberID = Sm.MemberID
left join Area G on SM.AreaID = G.AreaID 
left join AreaWeight GW on GW.AreaID = G.AreaID and GW.SurveyID = Q.SurveyID
where Q.SurveyID = @SurveyID

group by A.AnswerID, A.ArName, A.EnName, 
Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
q.QuestionOrder,a.Weight, q.Weight,gw.Weight,
G.AreaID , G.NameEn , G.NameAr 
order by q.QuestionOrder 

Go


If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEvaluationByDepartment' and
		        xtype = 'p')
Drop Procedure GetEvaluationByDepartment 
go
Create PROCEDURE GetEvaluationByDepartment @SurveyID int
as

declare @membersCount int =0
select @membersCount = count(distinct sm.MemberID) from SurveyMember Sm 
inner join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID



select count(SMA.AnswerID) AnswersCount , a.Weight AnswerWeight, q.Weight QWeight, gw.Weight govWeight , (count(SMA.AnswerID)* 1.0/@membersCount ) * a.Weight * gw.Weight Evaluation,
 A.AnswerID, A.ArName, A.EnName, 
 Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
 G.DepartmentID demoID , G.EnName demoEnName, G.ArName demoArName

from Answer A 
inner join Question Q on Q.QuestionID = a.QuestionID 
inner join SurveyMemberAnswer SMA on A.AnswerID = SMA.AnswerID and SMA.QuestionID = Q.QuestionID 
left join SurveyMember SM on SMA.SurveyMemberID = Sm.MemberID
left join Department G on SM.DepartmentID = G.DepartmentID 
left join DepartmentWeight GW on GW.DepartmentID = G.DepartmentID and GW.SurveyID = Q.SurveyID
where Q.SurveyID = @SurveyID

group by A.AnswerID, A.ArName, A.EnName, 
Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
q.QuestionOrder,a.Weight, q.Weight,gw.Weight,
G.DepartmentID , G.EnName , G.ArName 
order by q.QuestionOrder 

Go




If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEvaluationByDivision' and
		        xtype = 'p')
Drop Procedure GetEvaluationByDivision 
go
Create PROCEDURE GetEvaluationByDivision @SurveyID int
as

declare @membersCount int =0
select @membersCount = count(distinct sm.MemberID) from SurveyMember Sm 
inner join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID



select count(SMA.AnswerID) AnswersCount , a.Weight AnswerWeight, q.Weight QWeight, gw.Weight govWeight , (count(SMA.AnswerID)* 1.0/@membersCount ) * a.Weight * gw.Weight Evaluation,
 A.AnswerID, A.ArName, A.EnName, 
 Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
 G.DivisionID demoID , G.NameEn demoEnName, G.NameAr demoArName

from Answer A 
inner join Question Q on Q.QuestionID = a.QuestionID 
inner join SurveyMemberAnswer SMA on A.AnswerID = SMA.AnswerID and SMA.QuestionID = Q.QuestionID 
left join SurveyMember SM on SMA.SurveyMemberID = Sm.MemberID
left join Division G on SM.DivionID = G.DivisionID 
left join DivisionWeight GW on GW.DivisionID = G.DivisionID and GW.SurveyID = Q.SurveyID
where Q.SurveyID = @SurveyID

group by A.AnswerID, A.ArName, A.EnName, 
Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
q.QuestionOrder,a.Weight, q.Weight,gw.Weight,
G.DivisionID , G.NameEn , G.NameAr 
order by q.QuestionOrder 

Go



If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEvaluationByAgegroup' and
		        xtype = 'p')
Drop Procedure GetEvaluationByAgegroup 
go
Create PROCEDURE GetEvaluationByAgegroup @SurveyID int
as

declare @membersCount int =0
select @membersCount = count(distinct sm.MemberID) from SurveyMember Sm 
inner join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID



select count(SMA.AnswerID) AnswersCount , a.Weight AnswerWeight, q.Weight QWeight, gw.Weight govWeight , (count(SMA.AnswerID)* 1.0/@membersCount ) * a.Weight * gw.Weight Evaluation,
 A.AnswerID, A.ArName, A.EnName, 
 Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
 G.AgegroupID demoID , G.EnDisplayName demoEnName, G.ArDisplayName demoArName

from Answer A 
inner join Question Q on Q.QuestionID = a.QuestionID 
inner join SurveyMemberAnswer SMA on A.AnswerID = SMA.AnswerID and SMA.QuestionID = Q.QuestionID 
left join SurveyMember SM on SMA.SurveyMemberID = Sm.MemberID
left join Agegroup G on SM.AgeGroupID = G.AgegroupID 
left join AgegroupWeight GW on GW.AgegroupID = G.AgegroupID and GW.SurveyID = Q.SurveyID
where Q.SurveyID = @SurveyID

group by A.AnswerID, A.ArName, A.EnName, 
Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
q.QuestionOrder,a.Weight, q.Weight,gw.Weight,
G.AgegroupID , G.EnDisplayName , G.ArDisplayName 
order by q.QuestionOrder 

Go



If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEvaluation_General' and
		        xtype = 'p')
Drop Procedure GetEvaluation_General 
go
Create PROCEDURE GetEvaluation_General @SurveyID int
as

declare @membersCount int =0
select @membersCount = count(distinct sm.MemberID) from SurveyMember Sm 
inner join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID



select count(SMA.AnswerID) AnswersCount , a.Weight AnswerWeight, q.Weight QWeight, 1 govWeight , (count(SMA.AnswerID)* 1.0/@membersCount ) * a.Weight Evaluation,
 A.AnswerID, A.ArName, A.EnName, 
 Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
 null demoID , null demoEnName, null demoArName

from Answer A 
inner join Question Q on Q.QuestionID = a.QuestionID 
inner join SurveyMemberAnswer SMA on A.AnswerID = SMA.AnswerID and SMA.QuestionID = Q.QuestionID 
left join SurveyMember SM on SMA.SurveyMemberID = Sm.MemberID
where Q.SurveyID = @SurveyID

group by A.AnswerID, A.ArName, A.EnName, 
Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
q.QuestionOrder,a.Weight, q.Weight
order by q.QuestionOrder 

Go



If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEvaluationByLevel' and
		        xtype = 'p')
Drop Procedure GetEvaluationByLevel 
go
Create PROCEDURE GetEvaluationByLevel @SurveyID int
as

declare @membersCount int =0
select @membersCount = count(distinct sm.MemberID) from SurveyMember Sm 
inner join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID



select count(SMA.AnswerID) AnswersCount , a.Weight AnswerWeight, q.Weight QWeight, gw.Weight govWeight , (count(SMA.AnswerID)* 1.0/@membersCount ) * a.Weight * gw.Weight Evaluation,
 A.AnswerID, A.ArName, A.EnName, 
 Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
 G.LevelID demoID , G.EnName demoEnName, G.ArName demoArName

from Answer A 
inner join Question Q on Q.QuestionID = a.QuestionID 
inner join SurveyMemberAnswer SMA on A.AnswerID = SMA.AnswerID and SMA.QuestionID = Q.QuestionID 
left join SurveyMember SM on SMA.SurveyMemberID = Sm.MemberID
left join Level G on SM.LevelID = G.LevelID 
left join levelWeight GW on GW.levelID = G.levelID and GW.SurveyID = Q.SurveyID
where Q.SurveyID = @SurveyID

group by A.AnswerID, A.ArName, A.EnName, 
Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
q.QuestionOrder,a.Weight, q.Weight,gw.Weight,
G.LevelID , G.EnName , G.ArName
order by q.QuestionOrder 

Go


If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEvaluationByJobTitle' and
		        xtype = 'p')
Drop Procedure GetEvaluationByJobTitle 
go
Create PROCEDURE GetEvaluationByJobTitle @SurveyID int
as

declare @membersCount int =0
select @membersCount = count(distinct sm.MemberID) from SurveyMember Sm 
inner join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID



select count(SMA.AnswerID) AnswersCount , a.Weight AnswerWeight, q.Weight QWeight, gw.Weight govWeight , (count(SMA.AnswerID)* 1.0/@membersCount ) * a.Weight * gw.Weight Evaluation,
 A.AnswerID, A.ArName, A.EnName, 
 Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
 G.JobTitleID demoID , G.EnName demoEnName, G.ArName demoArName

from Answer A 
inner join Question Q on Q.QuestionID = a.QuestionID 
inner join SurveyMemberAnswer SMA on A.AnswerID = SMA.AnswerID and SMA.QuestionID = Q.QuestionID 
left join SurveyMember SM on SMA.SurveyMemberID = Sm.MemberID
left join JobTitle G on SM.JobTitleID = G.JobTitleID 
left join JobTitleWeight GW on GW.JobTitleID = G.JobTitleID and GW.SurveyID = Q.SurveyID
where Q.SurveyID = @SurveyID

group by A.AnswerID, A.ArName, A.EnName, 
Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
q.QuestionOrder,a.Weight, q.Weight,gw.Weight,
G.JobTitleID , G.EnName , G.ArName
order by q.QuestionOrder 

Go


If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEvaluationByGrade' and
		        xtype = 'p')
Drop Procedure GetEvaluationByGrade 
go
Create PROCEDURE GetEvaluationByGrade @SurveyID int
as

declare @membersCount int =0
select @membersCount = count(distinct sm.MemberID) from SurveyMember Sm 
inner join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID



select count(SMA.AnswerID) AnswersCount , a.Weight AnswerWeight, q.Weight QWeight, gw.Weight govWeight , (count(SMA.AnswerID)* 1.0/@membersCount ) * a.Weight * gw.Weight Evaluation,
 A.AnswerID, A.ArName, A.EnName, 
 Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
 G.GradeID demoID , G.EnName demoEnName, G.ArName demoArName

from Answer A 
inner join Question Q on Q.QuestionID = a.QuestionID 
inner join SurveyMemberAnswer SMA on A.AnswerID = SMA.AnswerID and SMA.QuestionID = Q.QuestionID 
left join SurveyMember SM on SMA.SurveyMemberID = Sm.MemberID
left join grade G on SM.GradeID = G.GradeID 
left join GradeWeight GW on GW.GradeID = G.GradeID and GW.SurveyID = Q.SurveyID
where Q.SurveyID = @SurveyID

group by A.AnswerID, A.ArName, A.EnName, 
Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
q.QuestionOrder,a.Weight, q.Weight,gw.Weight,
G.GradeID , G.EnName , G.ArName
order by q.QuestionOrder 

Go


If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEvaluationByGender' and
		        xtype = 'p')
Drop Procedure GetEvaluationByGender 
go
Create PROCEDURE GetEvaluationByGender @SurveyID int
as

declare @membersCount int =0
select @membersCount = count(distinct sm.MemberID) from SurveyMember Sm 
inner join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID



select count(SMA.AnswerID) AnswersCount , a.Weight AnswerWeight, q.Weight QWeight, gw.Weight govWeight , (count(SMA.AnswerID)* 1.0/@membersCount ) * a.Weight * gw.Weight Evaluation,
 A.AnswerID, A.ArName, A.EnName, 
 Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
 G.GenderID demoID , G.NameEn demoEnName, G.NameAr demoArName

from Answer A 
inner join Question Q on Q.QuestionID = a.QuestionID 
inner join SurveyMemberAnswer SMA on A.AnswerID = SMA.AnswerID and SMA.QuestionID = Q.QuestionID 
left join SurveyMember SM on SMA.SurveyMemberID = Sm.MemberID
left join Gender G on SM.GenderID = G.GenderID 
left join GenderWeight GW on GW.GenderID = G.GenderID and GW.SurveyID = Q.SurveyID
where Q.SurveyID = @SurveyID

group by A.AnswerID, A.ArName, A.EnName, 
Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,
q.QuestionOrder,a.Weight, q.Weight,gw.Weight,
G.GenderID , G.NameEn , G.NameAr
order by q.QuestionOrder 

Go