CREATE TABLE SupportTicket
(
SupportTicketID int primary key identity(1,1),
UserID uniqueidentifier foreign key references aspnet_Users(UserId),
TicketTitle nvarchar(500),
TicketDate datetime,
IsClosed bit,
IsDeleted bit
)

GO

CREATE TABLE TicketMessage
(
TicketMessageID int primary key identity(1,1),
SupportTicketID int foreign key references SupportTicket(SupportTicketID),
UserID uniqueidentifier foreign key references aspnet_Users(UserId),
FromAdmin bit,
MessageContent nvarchar(MAX),
MessageDate datetime,
IsRead bit,
IsDeleted bit
)

