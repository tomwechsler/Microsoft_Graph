# Get to know the Microsoft Graph PowerShell SDK better with the Graph Explorer.

Before we get started, what exactly are we talking about? Working with the Microsoft Graph PowerShell SDK can be a bit of a challenge. Installing the PowerShell module may still work, but then the first challenges arise. For example, which authorizations/scopes do I need to be able to complete the task? Delegated or application authorizations? Two questions that can very quickly (often negatively ;-) affect motivation.

In this tutorial we will take a closer look at the Graph Explorer. The Graph Explorer is a web application that allows you to interactively query the Microsoft Graph. The Graph Explorer is a great way to get to know the Microsoft Graph and the PowerShell SDK. In addition, the Graph Explorer is a great tool for troubleshooting and debugging.

## Prerequisites

- Microsoft 365 Developer Tenant
- Microsoft Graph PowerShell SDK
- Microsoft Graph Explorer

## Step by step

So that you can test the Microsoft Graph PowerShell SDK without risk, I recommend that you set up a free Microsoft 365 Developer Tenant. As just mentioned, this is free of charge and no credit card is required.
You can create a test environment using the following link:  
https://developer.microsoft.com/en-us/microsoft-365/dev-program

After you have created your test environment, you can install the Microsoft Graph PowerShell SDK. You can find the installation instructions here:  
[Link to the PowerShell File](../Installing_Microsoft_Graph_PowerShell_SDK.ps1)

After you have installed the Microsoft Graph PowerShell SDK, you can start the Graph Explorer. You can find the Graph Explorer here:
aka.ms/ge  
or  
https://developer.microsoft.com/en-us/graph/graph-explorer

<img src="/Learning_Tutorials/Images/ge_1.png" alt="The Graph Explorer">

> Note: You can set up a free Microsoft 365 Developer Tenant directly from Graph Explorer (if not already done).

**You can then log in.**  

<img src="/Learning_Tutorials/Images/ge_2.png" alt="log in">

**Now you must give your consent.**  

<img src="/Learning_Tutorials/Images/ge_3.png" alt="consent">

**Now we are registered!**  

<img src="/Learning_Tutorials/Images/ge_4.png" alt="registered">

**But what exactly happened in the background when we gave the consent (we remember the consent was not for the entire organization). We can find the answer in the Entra Admin Center.**  

<img src="/Learning_Tutorials/Images/ge_5.png" alt="In the Entra ID">

**We see the authorizations granted for the Graph Explorer Enterprise Application.**  

<img src="/Learning_Tutorials/Images/ge_6.png" alt="The permissions">

But now we come back to the actual topic. How can the Graph Explorer help us to get to know the Microsoft Graph PowerShell SDK better? Let's start with a simple example, listing the groups in our organization. Take a look at all the valuable information the Graph Explorer can provide us with (We can also see that we do not yet have the necessary authorizations.). We get information about the necessary permissions (always start with the fewest permissions - it doesn't always need all of them - as we'll see in a moment).

**The Graph Explorer shows us the necessary permissions.**  

<img src="/Learning_Tutorials/Images/ge_7.png" alt="The permissions">

**Only give your consent for one authorization and start the query again.**  

<img src="/Learning_Tutorials/Images/ge_8.png" alt="Run query again">

**The query was now successful.**  

<img src="/Learning_Tutorials/Images/ge_9.png" alt="The query">

> Note: By the way, at the arrow at the top - click on the symbol and you will receive information about this query.  

**Let us now apply all this knowledge directly. We can now apply what we have learned in Visual Studio Code.**  

<img src="/Learning_Tutorials/Images/ge_10.png" alt="In Visual Studio Code">

