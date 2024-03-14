create table Client(
CID Number(5) constraint c1 Primary Key,
CName Varchar(25) constraint c2 Not Null,
CPhone Varchar(10) constraint c3 Not Null,
CEmail Varchar(30) constraint c4 Not Null,
CType Varchar(20),
constraint c5 Unique(CEmail),
constraint c6 Unique(CPhone));

create table Project(
ProjectID Number(5) constraint p1 Primary Key,
PName Varchar2(25) constraint p2 Not Null,
PDescription Varchar2(100),
PLocation Varchar2(50),
PType Varchar2(20),
PBudget Number(10),
PStatus Varchar(12) Default 'Not Started' constraint p3 Check(PStatus in('Not
Started','In Progress','Done')),
SDate Date,
EDate Date,
ExpenseID Number(5) constraint p4 References Expenses(EID),
ClientID Number(5) constraint p5 references client(CID));

create table Task(
TID Number(5) constraint t1 Primary key,
TName Varchar2(25) constraint t2 Not Null,
TDescription Varchar2(100),
SDate Date,
EDate Date,
TStatus Varchar(12) Default 'Not Started' constraint t3 Check(TStatus in('Not Started','In
Progress','Done')),
ProjectID Number(5) constraint t4 references project(projectID));

create table Document(
DID Number(5) constraint d1 Primary Key,
DName Varchar2(25) constraint d2 Not Null,
File_Type Varchar2(10),
Uploade_Date Date,
PID Number(5) constraint d3 references Project(ProjectID));
create table Task_Dependency(
TID_1 Number(5) constraint td1 references Task(TID),
Depend_on_TID Number(5) constraint td2 references Task(TID),
constraint td3 Primary Key(TID_1,Depend_on_TID));

create table Expenses(
EID Number(5) constraint e1 Primary Key,
Amount Number(10) constraint e2 Check(Amount>0),
EStatus Varchar2(15) Default 'Not Paid' constraint e3 Check(EStatus in('Paid','Fully
Paid','Fraction Paid','Not Paid')),
Pay_Method Varchar2(10) constraint e4 Check(Pay_Method in
('Cash','Credit','Depit','Check','Apple Pay')),
Currency Varchar2(15),
Tax_Rate Number(3),
EDate Date);

create table Communication_log(
LogID Number(5) constraint cl1 Primary Key,
CType Varchar2(20),
CTimeStamp Date constraint cl2 Not Null,
CDescription Varchar2(100));

create table Task_CommunicationLog(
LogID Number(5) constraint tcl1 references Communication_log(LogID),
TID Number(5) constraint tcl2 references Task(TID),
constraint tcl3 Primary Key(LogID));

create table Resources(
RID Number(5) constraint r1 Primary Key,
RName Varchar2(25) constraint r2 Not Null,
Quantity Number(6) constraint r3 Not Null,
Category Varchar2(25),
EID Number(5) constraint r4 References Expenses(EID));
create table Material(
RID Number(5) constraint m1 References Resources(RID),
Strength Number(4),
constraint m2 Primary Key(RID));

create table Material_Requirements(
Storage_Req Varchar2(100),
RID Number(5) constraint mr1 References Material(RID),
constraint mr2 Primary Key(RID,Storage_Req));
create table Equipment(
RID Number(5) constraint eq1 references Resources(RID),
Model Varchar2(25),
Company_Name Varchar2(25),
Country Varchar2(25),
constraint eq2 Primary Key(RID));

create table Utilizes(
TID Number(5) constraint u1 References Task(TID),
RID Number(5) constraint u2 References Resources(RID),
constraint u3 Primary Key(TID,RID));

create table Team_Member(
MID Number(5) constraint tm1 Primary Key,
FName Varchar2(20) constraint tm2 Not Null,
LName Varchar2(20) constraint tm3 Not Null,
MEmail Varchar2(30) constraint tm4 Not Null,
MPhone Varchar2(10) constraint tm5 Not Null,
MRole Varchar2(25) constraint tm6 Not Null,
Salary Varchar2(10) constraint tm7 Check(Salary in(‘Fixed’,’Hourly’)),
Hours Varchar2(10) constraint tm8 Check(Hours in(‘Part-Time’,’Full-Time’)),
Company Varchar2(25),
EID Number(5) constraint tm9 References Expenses(EID),
constraint tm10 Unique(MEmail),
constraint tm11 Unique(MPhone));

create table Receipt(
DID Number(5) constraint rct1 References Document(DID),
EID Number(5) constraint rct2 References Expenses(EID),
constraint rct3 Primary Key(DID));

create table TimeSheet(
DID Number(5) constraint ts1 References Document(DID),
TDescription Varchar2(100),
MID Number(5) constraint ts2 References Team_Member(MID),
constraint ts3 Primary Key(DID));

create table Works_on(
TID Number(5) constraint wrk1 References Task(TID),
MID Number(5) constraint wrk2 References Team_Member(MID),
constraint wrk3 Primary Key(TID,MID));
