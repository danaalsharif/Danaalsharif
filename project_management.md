The architectural project management system is a comprehensive platform designed to
streamline project coordination and resource management. After analyzing an architectural
company's project process, several key insights and observations have been gathered,
providing a clear understanding of the intricacies and requirements of their workflow, and the
requirements are as follows:

An architectural project [PROJECT] is uniquely identified by a project ID (ProjectID). It is
characterized by a name (PName), a description (PDescription), and a location (PLocation).
Projects are classified by types (PType), with possible values including 'Residential,'
'Commercial,' 'Renovation,' or 'Construction.' To manage costs, the project is allocated a budget
(PBudget). Progress is monitored through the project status (PStatus), and scheduling is
facilitated using a start date (SDate) and an end date (EDate), from which the duration
(PDuration) is derived.
Every project has a client [CLIENT], which is uniquely identified by an id (ClientID).
Client details include a name (CName) and contact information, consisting of a phone number
(CPhone) and an email (CEmail). Our clients fall into distinct categories (CType) such as
residential, commercial, institutional, or governmental.
Within each project there are many tasks [TASK] that play a crucial role. A task is
uniquely identified by an id (TID), and comes with a set of essential characteristics--namely, a
task name (TName), a concise description (TDescription) for clear identification and context.
Tasks are also defined by their duration (TDuration), which is derived from a start date (SDATE)
and an end date (EDate). A status (TStatus) is set to track the progress of individual tasks,
offering values such as 'Pending-approval', 'In-progress', and 'Complete'. In certain cases, tasks
can be dependent on the completion of other tasks, meaning that one task cannot start or finish
until another task/s have reached a specific point.
Furthermore, communication logs [COMMUNICATION LOG] are essential for recording
and managing interactions related to project tasks. Each communication log is identified by a
unique id (LogID), and provides detailed information about the type of communication (CType),
a timestamp (CTimestamp) recording when the communication occurred, and a description
(CDescription) depicting the context and the content of the interaction. A task id (TaskID) is
used to track communication logs in connection with specific project tasks. These attributes
ensure efficient project coordination.
In architectural projects, tasks utilize different kinds of resources [RESOURCE]. A resource is
identified by a unique id (RID). Resources can be two different types which are materials (e.g.:
wood) and equipment (e.g.: heavy machinery or computerized tools to aid architects in their
projects), each with a name (RName), quantity (Quantity), and a category (Category).
Materials [MATERIAL] have unique properties like strength (Strength), and many storage
requirements (Storage Requirement). Similar to materials, equipment [EQUIPMENT] have
their own characteristics such as model (Model), manufacturer (Manufacturer) that consists of
the company name (Company) and country of manufacture (Country).
Each resource is associated with an expense [EXPENSE]. Expenses are uniquely
identified by an id (ExpenseID) and include important details such as the expense amount
(EAmount), payment status (EStatus) indicating whether the payment is pending, approved, or
paid, payment method (Payment Method), currency used (ECurrency), tax rate (ETax), and
the date of the expense (Exp-Date).
Moreover, each expense is linked to a client [CLIENT] using an id (ClientID),
establishing a clear connection between project expenses and client transactions. This
comprehensive expense tracking system ensures effective management of project costs,
payment statuses, and associated client transactions within the architectural project
management framework
Projects have multiple documents [DOCUMENT]. Each document is uniquely identified
by an id (DocumentID), and includes a name (DName), file type (FileType), and upload date
(UploadDate). Document types include but are not limited to: timesheets [TIMESHEET] and
receipt [RECEIPT].
Timesheet documents are characterized by a description (TDescription) and are directly
associated with team members. Each team member can contribute to multiple timesheets,
providing a comprehensive record of their work activities. In contrast, receipt documents are
linked to project expenses. Every expense in the system has an associated receipt, forming a
clear connection between project expenditures and the corresponding documentation.
Team members are identified by a unique id (MemberID) and have a name (MName)
comprising a first name (FName) and a last name (LName). Each member has contact
information (ContactInfo), including phone (MPhone) and email (MEmail), a designated role
(MRole), and a job description(JobDescription) containing details such as working hours
(MHours), company affiliation(Company), and salary (MSalary). Team members can contribute
to multiple tasks, have multiple expenses, and participate in multiple projects. This flexibility
allows for efficient collaboration and resource utilization within the project management
framework.
