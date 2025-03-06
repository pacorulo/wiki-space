# Introduction to Robotic Process Automation (RPA) and UiPath

## RPA (Robot Process Automation)
3 Biggest software/vendors in 2020 (from Udemy `Robotic Process Automation (RPA) introduction for managers/directors and employees` free course that didn't teach about rpa but was helpful to get some insights and get some good point about the full process including architects, QA, etc.), although nowadays some webs don't have `Blue Prism` on the third position some others still put the top three as these ones below:
1. [UiPath](https://www.uipath.com/)
2. [Automation Anywhere](https://www.automationanywhere.com/la)
3. [Blue Prism](https://www.blueprism.com/es/)

### Typical Company Profile
- 25 employees minimum
- At least 5 in the operation department
- 35 years employee age average
- Adapt to change

### RPA Project Lifecycle
1. Analysis
    - Requirements (Suitable for robot)
        - Is it mature enough?
        - Repeat over time?
        - Human dependency? (if the process fails or gets to a point where the robot can decide by itself, then a human interventions will resolve it and the full RPA process will resume after issue is resolved by this human intervention)
        - Rule based decisions?
    - Inventory of the processes (example: sending emails to customers + inserting invoices in system + protect documents)
    - Measuring the cost (time needed per each section of the inventory of the processes)
    - Selecting the ones with most impact
    - Estimations (time will be needed to create and implement the RPA process, as for example, if it will free up 200h/week, then it means $$$$$ money)
    - Documenting and data analysis (screenshots, videos, any document type)
2. Implementation
3. Help && Support

The roadmap can also be considered from these steps below:
1. Prepare RPA
2. Solution Design
3. Buid RPA
4. Test RPA
5. Stabilize RPA
6. Constant Improvement

### Building an automation team
Feasible for big companies ( 1K+ employees)
1. Hire ab RPA Architect
    - Participate in client meetings: gather requirements, suggest process improvements
    - Estimate project: time, effort
    - Document owner: create PDD, SDD
    - Establish team guidelines: best practices, team guidelines
    - Facilitate team communication: tools, rules
    - Create project architecture: dependencies, manage risk, deployment strategy
2. Bussiness Analyst
3. Quality Enbgineer
4. Project Managers, Executives & Managers
5. RPA Developers
6. RPA Developer
    - Develope according to the specifications
    - Quality assurance
    - Maintain the project
Optional:
7. Data Scientists
8. MAchine Learning Engineers
9. Developers

### Best Practices
- Build a POC of the process
  - Show to the SME/Process Owners
  - Grab additional feedback
  - Improve the process
  - Prepare the technical team that will implement
- Avoid complex decisions

**Technical pitfalls**
    - Choosing a solution that requires intensive programming
    - Not relying on RPA marketplaces and other readily available tools
    - Choosing a solution that did not demonstrate scalability
    - Not taking maintenance needs into account
    - Imp-lementing in house with non trained people

### PDD (Process Design Document)
Before the Analysis phases we need to create this document, which will contain (at least below points):
- Sequence of steps performed as part of the business process
- Conditions/Prerequisites
- Rules of the process prior to automation
- Number of hours before
- How they are envisioned to work after automating it
- Etc.

An example of the points contained in an PDD doc can be:
1. Introduction  
     - Purpose of the document  
     - Objectives  
     - Process Key contacts  
     - Minimum Pre-requisites for automation  
2. AS IS Process Description  
    - Process Overview  
    - Applications used in the process  
    - AS IS Detailed process map  
    - Additional sources of process documentation  
3. TO BE Process Description  
    - TO BE Detailed Process Map  
       - Change/Improvement details  
       - Areas already automated  
    - In Scope for RPA  
    - Out of Scope for RPA  
    - Business Exception Handling  
        - Known Exceptions
        - Unknown Exceptions  
    - Application Error and Exceptions  
        - Known Errors of Exceptions  
        - Unknown Errors and Exceptions  
4. Other Requirements and Observations  
5. Document Approval (list of people and charges that need to approve it)  

### DSD/SDS (Developer Specification Document/Solution Developer Document)
It is more technical document (subcomponents, workflows, sequences, exceptions, libraries,...) and is created by the RPA Solution Architect
1. Document Overview
2. Automated Master Project details
3. Runtime Guide
    - Runtime diagram [Architectural structure of the Master Project]
    - List of Packages
    - Master Project Runtime details
4. Project details
    - Project Name
      - Workflow(s) specific to (Project Name)
5. Other Details
    - Future Improvements
    - Debugging tips
    - Other Remarks
6. Post UAT specifications
7. Glossary

## ROBOTS
Can be attender or unattended.
- Attended
    - Multiple users in the same computer
    - User sessions are isolated
    - Access running applications
    - Interact with user input
> Note that as long as you see what the robot is doing, it means you are running inside the same session that the user that is working with that robot (in case, obviously, you weren't that one)

- Unattended
    - Cannot be started directly by a human
    - it is managed by the orchestrator (the human login into the orchestrator)
    - we cannot see what the robot is doing
    - using the orchestrator we can start more than one process (trigger more than one process)

### UiPath roadmap
Courses:
1. UiPath Developer Foundation Diploma (_FREE_)
2. UiPath Certified RPA Associate (PAID)
3. UiPath Advanced Diploma (_FREE_)
4. UiPath Certified Advanced RPA Developer (UiARD) (PAID)
