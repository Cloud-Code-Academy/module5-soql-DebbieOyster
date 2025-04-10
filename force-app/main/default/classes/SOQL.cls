/**
 * The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
 * It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
 *
 * This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
 * a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
 * records, and manage data volume using the LIMIT keyword.
 *
 * Topics covered in this class include:
 * - Understanding the structure of a SOQL query.
 * - Crafting basic SELECT statements in SOQL.
 * - Applying filters using the WHERE clause in SOQL.
 * - Fetching related records using Relationship queries.
 * - Controlling the amount of data retrieved using the LIMIT keyword.
 *
 * Users of this class can expect to gain a solid understanding of SOQL in Apex and
 * be prepared to handle data retrieval tasks in Salesforce development.
 *
 * @author Your Name
 */

public with sharing class SOQL {
	/**
	 * Question 1
	 * Update/Uncomment the template code to create a method
	 * Returns all leads from Salesforce Org
	 * @return List of all leads with Id, LastName, Company, Phone, Email
	 * Update the corresponding test class and testGetAllLeads method to cover this method
	 */
	public static List<Lead> testGetAllLeads () {
	//  The body of the method
		List<Lead> leads = [SELECT Id, LastName, Company, Phone, Email FROM Lead];
		if (leads.isEmpty()) {
			return new List<Lead>(); 
		}
		return leads;
	}

	/*
	 * Question 2
	 * Update/Uncomment the template code to create a method
	 * Returns all contacts with first name of John.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByFirstName method to cover this method
	 */
	public static List<Contact> johnContacts () {
	  //The body of the method
		return [SELECT Id, Name FROM Contact WHERE FirstName = 'John'];		
		
	}

	
	 /* Question 3
	 * Update/Uncomment the template code to create a method
	 * Returns the Contact Id for all contacts with last name of Smith or Jones
	 * @return A list of Contact Ids.
	 * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
	 */
	public static List<Id> smithJones () {
	//  The body of the method
	List<Contact> contacts = [Select Id, Name From Contact WHERE LastName IN ('Smith', 'Jones')];
		//List of Contact Ids
		List<Id> contactIds = new List<Id>();
		//Loop Contacts and add to List
		for(Contact c : contacts) {
			contactIds.add(c.Id);
		}
		return contactIds;
	}

	/**
	 * Question 4
	 * Update/Uncomment the template code to create a method
	 * Returns List of closed won opportunities for a specific Account.
	 * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Opportunities with important opportunities fields
	 * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
	 */
	public static List<Opportunity> oppClosedWon(String accountId) {
		
		List <Opportunity> wonOpps =  [SELECT Id, Name, Amount, StageName, AccountId, CloseDate 
				FROM Opportunity 
				WHERE StageName = 'Closed Won' 
				AND AccountId = :accountId];
		return wonOpps;
	}

	/**
	 * Question 5
	 * Update/Uncomment the template code to create a method
	 * Returns the total count of Account records.
	 * @return The Integer count of Account records.
	 * Update the corresponding test class and testGetAccountCount method to cover this method
	 */
	public static Integer totalAccounts () {
	  // query Accounts and put in a list
	  Integer count = [SELECT COUNT() FROM Account];
			
		//return total number of accounts
		return count;
		
	}

	/**
	 * Question 6
	 * Update/Uncomment the template code to create a method
	 * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
	 * @return A map of Task Ids to Task records.
	 * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
	 */
	public static Map<Id, Task> taskMap() {
	//  The body of the method
	// Date Range
	Date todaysDate = Date.today();
	Date todayPlusSeven = todaysDate.addDays(7);
	// Query Tasks Due in the next 7 Days
	List<Task> tasksDueNextSevenDays = [SELECT Id, Subject, ActivityDate FROM Task WHERE ActivityDate <= :todayPlusSeven AND ActivityDate >= :todaysDate];
		// Loop through tasksDueNextSevenDays and add them to the map
		Map<Id, Task> taskMap = new Map<Id, Task>();
		for(Task t: tasksDueNextSevenDays) {
			taskMap.put(t.Id, t);
		}
		return taskMap;
	}

	/**
	 * Question 7
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Contacts that have a example.com domain in their Email.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
	 */
	public static List<Contact> exampleEmailContacts() {
	//  The body of the method
	// Query Contacts with example.com in their Email. Add to List
	List<Contact> contacts = [SELECT Id, Name, Email FROM Contact WHERE Email Like '%example.com%'];
		// if the contacts list is empty return a blank list (handle null pointer exception)
		if(contacts.isEmpty()) {
			return new List<Contact>();
		}
		//Loop the contacts and add them to a list
		List<Contact> contactIds = new List<Contact>();
		for(Contact c: contacts) {
			contactIds.add(c);
		}
		return contactIds;
	}

	/**
	 * Question 8
	 * Retrieves all Opportunities that have a specific keyword in their Name.
	 * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
	 * @param keyword The keyword to search for in the Opportunity Name.
	 * @return A list of Opportunity records.
	 */
	public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
		// Keyword Empty Check
		if(keyword == null) {
			return new List<Opportunity>();
		}
		//Query Opportunities Like Keyword In Name	
		List<Opportunity> opportunitiesKeyword = [	
		SELECT Id, Name, StageName, Amount, CloseDate
		FROM Opportunity
		WHERE Name LIKE :('%' + keyword + '%') 
		];

		return opportunitiesKeyword; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 9
	 * Retrieves all Cases that Case Origin is not Web or Email or Blank
	 * @return A list of Case records.
	 */
	public static List<Case> getFilterCaseOrigins() {
		//Query Cases
		List<Case> cases = [
		SELECT Id, Origin 
		FROM Case 
		WHERE Origin != 'Web' AND Origin != 'Email' AND Origin != ''];

		return cases; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 10
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
	 * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
	 * @param leadSource The Lead Source to search for.
	 * @param keyword The keyword to search for in the Lead Title.
	 * @return A list of Lead records.
	 * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
	 */
	public static List<Lead> getLeads (String leadSource, String keyword) {
	//  The body of the method
	
	//Query Leads Contains Lead Source OR Contains Keyword
		List<Lead> leads = [
			SELECT Id, FirstName, LastName,Company,Phone,Email, LeadSource, Title 
			FROM Lead 
			WHERE LeadSource = :leadSource
			OR Title LIKE :('%' + keyword + '%')
			];
		
			return leads;
	}

	/**
	 * Question 11
	 * Returns the names of all Contacts associated with an Account.
	 * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Contact LastName.
	 */
	public static List<String> getContactNamesByAccount(Id accountId) {
		// Create a list to hold the Contact LastNames
		List<String> contactLastNames = new List<String>();
		// Query the Contacts
		List<Contact> contacts = [
			SELECT Id, LastName
			FROM Contact
			WHERE AccountId = :accountId
			];
		
		// Loop through each Contact and add the LastName to the list
		for (Contact c : contacts) {
			contactLastNames.add(c.LastName);
		}
		
		// Return the list of Contact LastNames
		return contactLastNames; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 12
	 * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
	 * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
	 * @param stage The Stage value to filter Opportunities.
	 * @return The total revenue.
	 */
	public static Decimal getTotalRevenueByStage(String stage) {
		// Use AggregateQuery to get the total revenue
		AggregateResult revenue = [
			SELECT SUM(Amount) totalRevenue
			FROM Opportunity
			WHERE StageName = :'Closed Won'
			OR Amount > 10000
		];
		// Return the total revenue
		return (Decimal)revenue.get('totalRevenue'); // Replace null with the variable you used to store the result
	}

	/**
	 * Question 13
	 * Retrieves the first 10 Accounts ordered by Name.
	 * @return A list of the first 10 Accounts ordered by Name.
	 */
	public static List<Account> getFirstTenAccounts() {
		// Query the first 10 accounts by name
		List<Account> accounts = [
			SELECT Id, Name
			FROM Account
			ORDER BY Name
			LIMIT 10
		];
		return accounts; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 14
	 * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 */
	public static List<Opportunity> getHighValueOpportunities() {
		// Query Opportunities amt > 100,000 order by CloseDate limit 5
		List<Opportunity> opportunities = [
			SELECT Id, Name, CloseDate, Amount
			FROM Opportunity
			WHERE Amount > 100000
			ORDER BY CloseDate
			LIMIT 5
		];
		return opportunities; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 15
	 * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
	 * @return A list of Contacts
	 */
	public static List<Contact> getBirthdateContacts() {
		List<Contact> contactBirthdays = [
			SELECT Id, Name, Birthdate
			FROM Contact
			ORDER BY Birthdate DESC
			LIMIT 3
		];
		return contactBirthdays; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 16
	 * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
	 * @return A list of Cases
	 */
		public static List<Case> getCasesWithStatus() {
			List<Case> cases = [
				SELECT Id, CreatedDate, Status
				FROM Case
				WHERE Status = 'Open'
				ORDER BY CreatedDate
				LIMIT 10 OFFSET 5
				
			];
			return cases; // Replace null with the variable you used to store the result
		}

	/**
	 * Question 17
	 * Returns Set of Case Ids for a specific Account.
	 * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A set of Case Ids.
	 */
	public static Set<Id> getCaseIdsByAccount(Id accountId) {
		// Create a set to hold the Case Ids
		Set<Id> caseIds = new Set<Id>();
		// Query the Cases
		List<Case> cases = [
			SELECT Id
			FROM Case
			WHERE AccountId = :accountId
		];
		// Loop through each Case and add the Id to the set
		for (Case c: cases) {
			caseIds.add(c.Id);
		}

		return caseIds; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 18
	 * Return Map of Account Ids to Account Names Not in a specific Country.
	 * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
	 * @param country The country to filter Accounts.
	 * @return A map of Account Ids to Account Names.
	 */
	public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
		// Create a map to hold the Account Ids to Account Names
		Map<Id, String> accountIdsToNames = new Map<Id, String>();

		// Query the Accounts
		List<Account> accounts = [
			SELECT Id, Name
			FROM Account
			WHERE BillingCountry != :country
		];
		// Loop through each Account and add the Id and Name to the map'
		for (Account a : accounts) {
			accountIdsToNames.put(a.Id, a.Name);
		}
		
		return accountIdsToNames; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 19
	 * Retrieves the Account Name for a given Contact.
	 * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
	 * @param contactId The Id of the Contact.
	 * @return The Account Name of the Contact.
	 */
	public static String getAccountNameForContact(String contactId) {
		//Query Contact
		Contact contact = [
			SELECT Account.Name
			FROM Contact
			WHERE Id = :contactId
		];
		// Replace null with the variable you used to store the result
		if (contact.Account != null) {
			return contact.Account.Name;
		} else{
			return null;
		}
		
	}

	/**
	 * Question 20
	 * Returns single Account that has related opportunities in the same query
	 * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
	 * @param accountId The ID of the Account.
	 * @return An Account record with related Opportunities.
	 */
	public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
		// Query the Account and get all related Opps - Opp Query within Account Query
		Account account = [
		SELECT Id, Name, 
			(SELECT Id, Name FROM Opportunities)
		FROM Account
		WHERE Id = :accountId
		];
		return account; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 21
	 * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
	 * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
	 * @param Account Id
	 * @return List of contacts with the same Mailing State as the Account Billing State
	 */
	public static List<Contact> getAccountsWithContactsByState(Id accountId) {
		// Query the Account
		Account account = [
			SELECT Id, Name, BillingState
			FROM Account
			WHERE Id = :accountId
		];
		// Store the Account's BillingState
		String accountBillingState = account.BillingState;
		// Query the Contacts
		List<Contact> contacts = [
			SELECT Id, Name, MailingState
			FROM Contact
			WHERE MailingState = :accountBillingState
		];
		return contacts; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 22
	 * Extracts email domains from the leads, then finds Accounts with matching website domains
	 * If Lead Email = test@test.com return account with website = www.test.com
	 * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
	 * @param A set of Lead Ids.
	 * @return A list of Accounts with matching email domains.
	 */
	public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
		// Query the Leads and Check if the email is not null
		List<Lead> leads = [
			SELECT Id, Email
			FROM Lead
			WHERE Id IN :leadIds
				AND Email != null
		];
		
		// Create a set of email domains from the Leads
		Set<String> websiteDomains = new Set<String>();
		
		// Loop through each Lead
		for(Lead l : leads) {
			if (l.Email.contains('@')) {
			
			// Get the email from the Lead
			String domain = l.Email.substringAfter('@').toLowerCase();
			
			// Add the email domain to the set
			websiteDomains.add('www.' + domain);	
			}
		
		}
		
		// Query the Accounts
		List<Account> matchingAccounts = new List<Account>();
		if(!websiteDomains.isEmpty()) {
			matchingAccounts = [
			SELECT Id, Name, Website
			FROM Account
			WHERE Website IN :websiteDomains
		];
		}
		return matchingAccounts; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 23
	 * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
	 * Adds a randomized number between 1 to 3 to the quantity of each line item.
	 * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
	 * @param Original Opportunity Id
	 * @param List of cloned Opportunity Ids
	 */
	public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
		// Query the original Opportunity Line Items
		List<OpportunityLineItem> originalOLIs = [
			SELECT Id, Quantity, Description, OpportunityId, 
				UnitPrice, PricebookEntryId
			FROM OpportunityLineItem
			WHERE OpportunityId = :origOppId
		];

		// Create a list to hold the new line items			
		List<OpportunityLineItem> newOLIs = new List<OpportunityLineItem>();

		// Generate a random number between 1 and 3
		Integer randomNumber = Integer.valueOf((Math.random() * 3));

		// Loop through each cloned Opportunity Id
		for(Id oppId : cloneOppIds) { 
			// Loop through each original line item
			for(OpportunityLineItem oLI : originalOLIs) { 
				// Clone the original line item and add the random number to the quantity
				OpportunityLineItem newOli = new OpportunityLineItem(); 
				newOli.opportunityId = oppId;	
				newOli.Quantity =oLI.Quantity + randomNumber;
				newOli.UnitPrice = oLI.UnitPrice;
				newOli.PricebookEntryId = oLI.PricebookEntryId;
				newOli.Description = oLI.Description;
				
				newOLIs.add(newOli);
			}
		}

	// Insert the new line items
	insert newOLIs;
}	

	/**
	 * Question 24
	 * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
	 * @return A list of filtered Opportunity
	 */
	public static List<Opportunity> getOpportunityDetailsForClosedWon() {
		List<Opportunity> filteredOpps = [
			SELECT Id, Name, Account.Name, AccountId, Owner.Name
			FROM Opportunity
			WHERE StageName = 'Closed Won'
		];
		return filteredOpps; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 25
	 * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to the Contact on the associated Account with the alphabetically first first name.
	 * Example: if there are two Contacts on the Account, "Billy" and "Abby," the 'Primary_Contact__c' will be set to "Abby."
	 */
	public static void setPrimaryContact() {
		//Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
		List<Opportunity> closedWonOpps = getOpportunityDetailsForClosedWon();
		// Create a set of Account Ids from the Opportunities
		Set<Id> accountIds = new Set<Id>();
		for (Opportunity opp : closedWonOpps) {
			if (opp.AccountId != null) {
				accountIds.add(opp.AccountId);
			} 	
		}
		// Create Map
		Map<Id, Contact> accountToContactMap = new Map<Id, Contact>();
		// Query the Contacts
		List<Contact> contacts = [
			SELECT Id, AccountId, FirstName
			FROM Contact
			WHERE AccountID IN :accountIds
			ORDER BY FirstName
		];
		// Loop through each Contact and add the Account Id and Contact to the map
		for(Contact c : contacts) {
			if(!accountToContactMap.containsKey(c.AccountId)) {
					accountToContactMap.put(c.AccountId, c);
				} 
		}
		// Create List Opps to update
		List<Opportunity> oppsToUpdate = new List<Opportunity>();
		// Loop through each Opportunity
		for(Opportunity opp : closedWonOpps) {
			Contact primary =accountToContactMap.get(opp.AccountId);
			if(primary != null) {
				Opportunity updateOpp = new Opportunity();	
				updateOpp.Id = opp.Id;
				updateOpp.Primary_Contact__c = primary.Id;

				oppsToUpdate.add(updateOpp);
			}
		}
		// Update the Opportunity primary contact from accountToContactMap

		// Update the Opportunities
		if (!oppsToUpdate.isEmpty()){
			update oppsToUpdate;			
		}
	}
}
