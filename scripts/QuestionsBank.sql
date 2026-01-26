CREATE TABLE BankCategory(
BankCategoryID int primary key identity(1,1),
ArName nvarchar(100),
EnName nvarchar(100),
)

Go

CREATE TABLE BankQuestion(
BankQuestionID int primary key identity(1,1),
BankQuestionTypeID int foreign key references QuestionType(QuestionTypeID),
BankCategoryID int foreign key references BankCategory(BankCategoryID),
ArTitle nvarchar(500),
EnTitle nvarchar(500),
IsMandatory bit,
Weight decimal(18,2),
)

GO

CREATE TABLE BankQuestionAnswer(
BankQuestionAnswerID int primary key identity(1,1),
BankQuestionID int foreign key references BankQuestion(BankQuestionID),
ArName nvarchar(500),
EnName nvarchar(500),
Weight decimal(18,2)
)