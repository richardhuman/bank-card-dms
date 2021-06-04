# Bank Card Distribution Management System
Bank-Card-DMS

## Introduction
A webapp to manage the distribution of new, un-assigned bank cards
to customers via a distribution network of sales agents. 

Some features of this system:
* Bank cards all have unique numbers.
* Bank cards are collected into bundlers of varying sizes. Bundles can be composed of other bundles.
* Bundles are also uniquely identified and have a barcode or QR code with the number.
* A back office team loads a tranche of bundles onto the system.
* Bundles are then assigned to sales agents.
* Sales agents are are structured hierarchically.
* Sales agents sell bank cards from the bundle to the customers.
* Sales agents can transfer bundles between each other. They can also transfer partially filled ones.
* Reporting:
  * Breakdown of cards sold and remaining per top level sales agent per tranche.
  * Drill down to lower level agents.  