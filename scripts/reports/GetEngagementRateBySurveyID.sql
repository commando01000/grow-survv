 --exec GetEngagementRateBySurveyIDForGovernrate 1027 
 --exec GetEngagementRateBySurveyIDForArea 1027 
 --exec GetEngagementRateBySurveyIDForBranch 1027 
 --exec GetEngagementRateBySurveyIDForDepartment 1027 
 --exec GetEngagementRateBySurveyIDForDivision 1027 
 --exec GetEngagementRateBySurveyIDForAgeGroup 1027 
 --exec GetEngagementRateBySurveyIDForGender 1027 
 --exec GetEngagementRateBySurveyIDForGrade 1027 
 --exec GetEngagementRateBySurveyIDForLevel 1027 
 --exec GetEngagementRateBySurveyIDForJobTitle 1027 
 --exec GetMembersCountBySurveyID 1027 
 
If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetMembersCountBySurveyID' and
		        xtype = 'p')
Drop Procedure GetMembersCountBySurveyID 
go
Create PROCEDURE GetMembersCountBySurveyID @SurveyID int
as
declare @membersCount int =0,
		@membersEnagaged int =0
select @membersCount = count(distinct sm.MemberID), 
	   @membersEnagaged = count(distinct sma.SurveyMemberID) from SurveyMember Sm 
	   left join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID
where surveyID = @SurveyID

select @membersCount-@membersEnagaged MembersNotRespond, @membersEnagaged MembersRespond

Go
--GetEngagementRateBySurveyIDForGovernrate 2049
If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEngagementRateBySurveyIDForGovernrate' and
		        xtype = 'p')
Drop Procedure GetEngagementRateBySurveyIDForGovernrate 
go
Create PROCEDURE GetEngagementRateBySurveyIDForGovernrate @SurveyID int
as


select count(distinct sm.MemberID) AllMembers, 	  
	   G.EnName
from Governrate G 
left join SurveyMember Sm on SM.GovernrateID = G.GovernrateID
left join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID and G.IsActive = 1
Group by G.EnName

go 

If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEngagementRateBySurveyIDForArea' and
		        xtype = 'p')
Drop Procedure GetEngagementRateBySurveyIDForArea 
go
Create PROCEDURE GetEngagementRateBySurveyIDForArea @SurveyID int
as	


select count(distinct sm.MemberID) AllMembers, 
	   Ar.NameEn
	   from Area Ar  
	   left join SurveyMember Sm on Sm.AreaID = Ar.AreaID 
left join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID

where surveyID = @SurveyID and Ar.IsActive = 1
Group by Ar.NameEn
go


If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEngagementRateBySurveyIDForBranch' and
		        xtype = 'p')
Drop Procedure GetEngagementRateBySurveyIDForBranch 
go
Create PROCEDURE GetEngagementRateBySurveyIDForBranch @SurveyID int
as


select count(distinct sm.MemberID) AllMembers, 
	   B.NameEn
	   from Branch B 
	   left join SurveyMember Sm on Sm.BranchID = B.BranchID 
left join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID

where surveyID = @SurveyID and B.IsActive = 1
group by B.NameEn
go


If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEngagementRateBySurveyIDForDepartment' and
		        xtype = 'p')
Drop Procedure GetEngagementRateBySurveyIDForDepartment 
go
Create PROCEDURE GetEngagementRateBySurveyIDForDepartment @SurveyID int
as


select count(distinct sm.MemberID) AllMembers, 	 
	   De.EnName
	   from Department De left join SurveyMember Sm on sm.DepartmentID = de.DepartmentID 
inner join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID and de.IsActive = 1
group by de.EnName
go


If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEngagementRateBySurveyIDForDivision' and
		        xtype = 'p')
Drop Procedure GetEngagementRateBySurveyIDForDivision 
go
Create PROCEDURE GetEngagementRateBySurveyIDForDivision @SurveyID int
as


select count(distinct sm.MemberID) AllMembers, 	   
	   di.NameEn
	   from Division Di left join SurveyMember Sm on sm.DivionID = di.DivisionID
inner join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID

--where surveyID = @SurveyID
group by di.NameEn
go


If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEngagementRateBySurveyIDForAgeGroup' and
		        xtype = 'p')
Drop Procedure GetEngagementRateBySurveyIDForAgeGroup 
go
Create PROCEDURE GetEngagementRateBySurveyIDForAgeGroup @SurveyID int
as


select count(distinct sm.MemberID) AllMembers, 
	   AG.EnDisplayName
	     from AgeGroup AG  left join SurveyMember Sm on Sm.AgeGroupID = ag.AgeGroupID
left join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID and AG.IsActive = 1
group by Ag.EnDisplayName
go

-- GetEngagementRateBySurveyIDForGender 1049
If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEngagementRateBySurveyIDForGender' and
		        xtype = 'p')
Drop Procedure GetEngagementRateBySurveyIDForGender 
go
Create PROCEDURE GetEngagementRateBySurveyIDForGender @SurveyID int
as


select count(distinct sm.MemberID) AllMembers, 
	   ge.NameEn
	   from Gender Ge left join SurveyMember Sm on sm.GenderID = ge.GenderID 
left join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID --and Ge.IsActive = 1
group by ge.NameEn
go


If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEngagementRateBySurveyIDForGrade' and
		        xtype = 'p')
Drop Procedure GetEngagementRateBySurveyIDForGrade 
go
Create PROCEDURE GetEngagementRateBySurveyIDForGrade @SurveyID int
as


select count(distinct sm.MemberID) AllMembers, 
	   gr.EnName
	   from grade gr left join SurveyMember Sm on sm.GradeID = gr.GradeID 
inner join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID and Gr.IsActive = 1
group by gr.EnName
go


If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEngagementRateBySurveyIDForLevel' and
		        xtype = 'p')
Drop Procedure GetEngagementRateBySurveyIDForLevel 
go
Create PROCEDURE GetEngagementRateBySurveyIDForLevel @SurveyID int
as


select count(distinct sm.MemberID) AllMembers, 
	   l.EnName  from Level l left join SurveyMember Sm on sm.LevelID = l.LevelID 
left join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID and l.IsActive = 1
group by l.EnName
go


If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetEngagementRateBySurveyIDForJobTitle' and
		        xtype = 'p')
Drop Procedure GetEngagementRateBySurveyIDForJobTitle 
go
Create PROCEDURE GetEngagementRateBySurveyIDForJobTitle @SurveyID int
as


select count(distinct sm.MemberID) AllMembers, 
	   j.EnName from JobTitle j left join SurveyMember Sm on sm.JobTitleID =j.JobTitleID 
left join SurveyMemberAnswer sma on sm.MemberID = sma.SurveyMemberID and sm.SurveyID = @SurveyID
where surveyID = @SurveyID and j.IsActive = 1
group by j.EnName
go