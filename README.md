# 'TaskME' Task Management Application
TaskME is a task management and collaboration platform that helps individuals and teams organize projects, assign tasks, manage deadlines, and communicate, all in one place.

## Team
- Eric Tran — eric.tran06@sjsu.edu
- Indpaul Johl — indpaul.johl@sjsu.edu
- Tehkhum Sultanali — tehkhumhusein.sultanali@sjsu.edu

## File Location
All of our code is stored in /apache-tomcat-9.0.115/webapps/TaskME. Some files are also found within /WEB-INF.

## How to Run
1. Run "./startup.sh" after cd-ing into the /apache-tomcat-9.0.115/bin directory. 
2. Then paste the following link into the
browser: http://localhost:8080/TaskME/Home-Page.html

## Tech Stack
- **Frontend:** HTML5, CSS, JavaScript
- **Backend:** Java, JSP
- **Server:** Apache Tomcat 9.0.115
- **Database:** MySQL Server 8.0.45 (MySQL Workbench 8.0 CE)

## Features

### User Accounts
- Register with a name, email, and password
- Secure password hashing
- Login, logout, and session management
- Edit account details or permanently delete account

### Project Management
- Create projects with a name, description, and due date
- View all projects you own or have been invited to
- Edit or delete projects (Admins only)

### Role-Based Permissions
- **Admin** — Full control over everything. One can manage members, edit/delete projects, and tasks
- **Member** — Create, edit, and delete tasks and comments
- **Comment-Only** — Read access and commenting only

### Task Tracking
- Create tasks with a title, description, due date, and status
- Statuses: `Incomplete`, `In-Progress`, `Completed`
- Assign tasks to one or more team members
- Edit or delete tasks with proper permission checks

### Comments
- Add comments to any task
- Edit or delete your own comments
- Comments are displayed chronologically with the author and timestamp

### Labels & Attachments
- Tag tasks with color-coded labels for easy filtering
- Attach files or links directly to tasks

### Notifications
- Get notified when assigned to a task, mentioned in a comment, or approaching a deadline
- Mark notifications as read and unread

### Activity Log
- Full audit log of all actions taken within a project
- Tracks who did what and when across tasks, comments, and membership changes