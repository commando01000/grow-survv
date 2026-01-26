CREATE TABLE Division(
DivisionID int primary key identity(1,1),
CompanyID int foreign key references Company(CompanyID),
NameEn nvarchar(500),
NameAr nvarchar(500)
)

CREATE TABLE Area(
AreaID int primary key identity(1,1),
NameEn nvarchar(500),
NameAr nvarchar(500)
)

CREATE TABLE Gender(
GenderID int primary key identity(1,1),
NameEn nvarchar(500),
NameAr nvarchar(500)
)

CREATE TABLE Branch(
BranchID int primary key identity(1,1),
CompanyID int foreign key references Company(CompanyID),
NameEn nvarchar(500),
NameAr nvarchar(500)
)

GO

ALTER TABLE Survey
ADD IsDivisionMandatory bit,
	IsDepartmentMandatory bit,
	IsAreaMandatory bit,
	IsBranchMandatory bit,
	IsGradeMandatory bit,
	IsLevelMandatory bit,
	IsJobTitleMandatory bit,
	IsGenderMandatory bit,
	IsAgeMandatory bit,
	IsDurationMandatory bit,
	IsRecentPromotionDateMandatory bit

ALTER TABLE SurveyMember
ADD DivionID int foreign key references Division(DivisionID),
	DepartmentID int foreign key references Department(DepartmentID),
	AreaID int foreign key references Area(AreaID),
	BranchID int foreign key references Branch(BranchID),
	Grade nvarchar(500),
	Level nvarchar(500),
	JobTitle nvarchar(500),
	GenderID int foreign key references Gender(GenderID),
	Age int,
	Duration int,
	RecentPromotionDate datetime

ALTER TABLE SurveyMemberAnswer
ADD QuestionID int foreign key references Question(QuestionID),
	AnswerText nvarchar(MAX)
