
If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetStatisticsBySurveyIDWithGrouping' and
		        xtype = 'p')
Drop Procedure GetStatisticsBySurveyIDWithGrouping 
go
Create PROCEDURE GetStatisticsBySurveyIDWithGrouping @SurveyID int
as
declare @membersCount int =0
select @membersCount = count(sm.MemberID) from SurveyMember Sm where surveyID = @SurveyID

select count(SMA.AnswerID) AnswersCount ,round((count(SMA.AnswerID)*1.0/@membersCount)*100,2) AnsPercentage,  A.AnswerID, A.ArName, A.EnName, Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID 
,G.GovernrateID , G.EnName GovEnName, G.ArName GovArName
,Ar.AreaID, Ar.NameEn AreaEnName, Ar.NameAr AreaArName
,B.BranchID , B.NameEn BranchEnName, B.NameAr BranchArName
,Ag.AgeGroupID , AG.EnDisplayName AgeEnName, Ag.ArDisplayName AgeArName
,Di.DivisionID , Di.NameEn DivEnName, Di.NameEn DivArName
,De.DepartmentID , de.EnName DepEnName, De.ArName DepArName
,Ge.GenderID , Ge.NameEn GenderEnName, Ge.NameAr GenderArName
,gr.GradeID , gr.EnName GradeEnName, Gr.ArName GradeArName
,l.LevelID , l.EnName LevelEnName, l.ArName LevelArName
,j.JobTitleID , j.EnName jobEnName, j.ArName jobArName

from Answer A 
inner join Question Q on Q.QuestionID = a.QuestionID 
left join SurveyMemberAnswer SMA on A.AnswerID = SMA.AnswerID and SMA.QuestionID = Q.QuestionID 
left join SurveyMember SM on SMA.SurveyMemberID = Sm.MemberID
left join Governrate G on SM.GovernrateID = G.GovernrateID 
left join Area Ar on Sm.AreaID = Ar.AreaID 
left join Branch B on Sm.BranchID = B.BranchID 
left join AgeGroup AG on Sm.AgeGroupID = ag.AgeGroupID 
left join Division Di on sm.DivionID = di.DivisionID
left join Department De on sm.DepartmentID = de.DepartmentID 
left join Gender Ge on sm.GenderID = ge.GenderID 
left join grade gr on sm.GradeID = gr.GradeID 
left join Level l on sm.LevelID = l.LevelID 
left join JobTitle j on sm.JobTitleID =j.JobTitleID 
where Q.SurveyID = @SurveyID

group by A.AnswerID, A.ArName, A.EnName, Q.QuestionID, Q.ArTitle , Q.EnTitle  , SMA.AnswerText, SMA.QuestionID ,q.QuestionOrder,
G.GovernrateID , G.EnName , G.ArName 
,Ar.AreaID, Ar.NameEn , Ar.NameAr 
,B.BranchID , B.NameEn , B.NameAr 
,Ag.AgeGroupID , AG.EnDisplayName , Ag.ArDisplayName 
,Di.DivisionID , Di.NameEn , Di.NameEn 
,De.DepartmentID , de.EnName , De.ArName 
,Ge.GenderID , Ge.NameEn , Ge.NameAr 
,gr.GradeID , gr.EnName , Gr.ArName 
,l.LevelID , l.EnName , l.ArName 
,j.JobTitleID , j.EnName , j.ArName 
order by q.QuestionOrder 