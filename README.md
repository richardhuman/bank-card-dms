# Bank Card Distribution Management System
Bank-Card-DMS

## TODO:
* user invites
* AR sessions

## Introduction
A webapp to manage the distribution of new, un-assigned bank cards
to customers via a distribution network of sales agents. 

Some features of this system:
* Bank cards all have unique numbers.
* Bank cards are collected into bundlers of varying sizes. 
* Bundles are also uniquely identified and have a barcode or QR code with the number.
* Campaigns are run with multiple bundles are loaded for that campaign.  
* A back office team loads a tranche of bundles onto the system.
* Bundles are then assigned to sales agents.
* Sales agents are are structured hierarchically.
* Sales agents sell bank cards from the bundle to the customers.
* Sales agents can transfer bundles between each other. They can also transfer partially filled ones.
* Track all "transactions" - assigning a bundle, transferring a bundle, registering sales against a bundle  
* Reporting:
  * Breakdown of cards sold and remaining per top level sales agent per tranche.
  * Drill down to lower level agents.  
  
* Next features:
  * Bundles can be composed of other bundles.
  * Recognise the individual bank cards in the system and link to customers.
  

## UX functions

### Back office

* Manage campaign (CRUD)
* Load bundles for a campaign
* Assign bundles to sales agents 
* Manage sales agents (users)

### Sales agent module
* Manage sub agents (users) - add sub agents
