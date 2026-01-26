--get all questions and answers ordered 
--get all questions and sub-questions 
-- no branches

--get all questions and answers ordered 
--get all questions and sub-questions 
-- with branches
-- GetMainBranchSurveyQuestions  5
If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetMainBranchSurveyQuestions' and
		        xtype = 'p')
Drop Procedure GetMainBranchSurveyQuestions 
go
Create PROCEDURE GetMainBranchSurveyQuestions @SurveyID int
as

select * from Question Q  
where SurveyID = @SurveyID and QuestionBranchID is null and ParentQuestionID is null
order by QuestionOrder
Go

-- GetBranchesBySurveyID 1027
If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetBranchesBySurveyID' and
		        xtype = 'p')
Drop Procedure GetBranchesBySurveyID 
go
Create PROCEDURE GetBranchesBySurveyID @SurveyID int
as
select B.*, A.AnswerID, A.QuestionID from Questionbranch B 
left join Answer A on A.NextBranchID = B.QuestionBranchID
where B.SurveyID = @SurveyID
union 
select null, 0, 'Main', '',null,null
Go

-- GetSurveyQuestionsByBranchID null
If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetSurveyQuestionsByBranchIDAndSurveyID' and
		        xtype = 'p')
Drop Procedure GetSurveyQuestionsByBranchIDAndSurveyID 
go
Create PROCEDURE GetSurveyQuestionsByBranchIDAndSurveyID @BranchID int, @SurveyID int 
as
if(@BranchID  = 0)
begin 
select Q.*, A.AnswerID, Q2.QuestionID PQuestionID from Question Q 
left join Answer A on A.NextQuestionID = Q.QuestionID
left join Question Q2 on A.QuestionID = Q2.QuestionID
where Q.SurveyID = @SurveyID and Q.QuestionBranchID is null and Q.ParentQuestionID is null
order by QuestionOrder
end 
else
begin
select Q.*, A.AnswerID, Q2.QuestionID PQuestionID from Question Q 
left join Answer A on A.NextQuestionID = Q.QuestionID
left join Question Q2 on A.QuestionID = Q2.QuestionID
where Q.SurveyID = @SurveyID and Q.QuestionBranchID = @BranchID and Q.ParentQuestionID is null
order by QuestionOrder
end
Go

If Exists (select Name 
		   from sysobjects 
		   where  name = 'GetSurveyQuestionsByBranchIDAndSurveyIDAndCategoryID' and
		        xtype = 'p')
Drop Procedure GetSurveyQuestionsByBranchIDAndSurveyIDAndCategoryID 
go
Create PROCEDURE GetSurveyQuestionsByBranchIDAndSurveyIDAndCategoryID @BranchID int, @SurveyID int, @CategoryID int 
as

select Q.*, A.AnswerID, Q2.QuestionID PQuestionID from Question Q 
left join Answer A on A.NextQuestionID = Q.QuestionID
left join Question Q2 on A.QuestionID = Q2.QuestionID
where Q.SurveyID = @SurveyID and (Q.QuestionBranchID = @BranchID or @BranchID = 0) and Q.ParentQuestionID is null and Q.QuestionCatergoryID = @CategoryID
order by QuestionOrder
Go
-- GetSurveyQuestionsByBranchIDAndSurveyIDAndCategoryID 0, 1027, 3019