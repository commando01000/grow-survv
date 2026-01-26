Create Table QuestionCategory (
CategoryID int primary key identity(1,1),
ArName nvarchar(100),
EnName nvarchar(100)
)

GO

Alter Table Question
Add Weight int,
	QuestionCatergoryID int foreign key references QuestionCategory(CategoryID)

GO

Create Table SurveyMemberAnswer(
SurveyMemberAnwerID int primary key identity(1,1),
SurveyMemberID int foreign key references SurveyMember(MemberID),
AnswerID int foreign key references Answer(AnswerID)
)