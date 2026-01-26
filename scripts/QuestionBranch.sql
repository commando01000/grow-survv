
If Exists (select Name 
		   from sysobjects 
		   where name = 'QuestionBranch' and
		        xtype = 'U')
Drop Table QuestionBranch
Go
Create Table QuestionBranch
(
	QuestionBranchID int not null
			identity(1,1)
			Primary Key,	
	SurveyID int foreign key references survey(SurveyID),
	EnName Nvarchar(150), 
	ArName Nvarchar(150), 	
)
Go  

Alter table question  
Add QuestionBranchID int foreign key references QuestionBranch(QuestionBranchID)
GO
