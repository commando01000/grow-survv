ALTER TABLE QuestionCategory
ADD SureveyID int foreign key references Survey(SurveyID)

ALTER TABLE Question
ADD QuestionOrder int