-- This is probably the first documentation ever created for this project!

-- Add shop_locations and shop_types

DELETE FROM shop_locations;
INSERT INTO shop_locations (shop_location_id, date_established, active) VALUES 
  ("Positive Spin", "2005-11-09",1), 
  ("Plan B", "2000-01-01", 1), 
  ("Third Hand", "2003-01-01", 1), 
  ("Austin Yellow Bike Project", "1997-01-01", 1);

-- Mechanic Operation Shop is a special type of shop for shop_log.php

DELETE FROM shop_types;
INSERT INTO shop_types (shop_type_id, list_order) VALUES 
  ("Open Shop", 1),
  ("Bike Education", 4), 
  ("Volunteer Only", 2), 
  ("Meeting", 3 ),
  ("Mechanic Operation Shop", 5);

-- Add shop user roles to shop_user_roles
-- sales == 1 if you want a role to be able to do sales
-- volunteer == 1 if you want to keep track of volunteer hours
-- paid == 1 if you want staff/employee and stats
--
-- list_shop_user_roles(form name, select default) .. this function determines
-- where item in pulldown list will be the default which currently is "Personal"

DELETE FROM shop_user_roles;
INSERT INTO shop_user_roles (
  shop_user_role_id, hours_rank, volunteer, sales, paid
) VALUES 
  ("Coordinator",0,0,1,0), 
  ("Personal",0,0,0,0), 
  ("Volunteer",0,1,0,0), 
  ("Greeter",0,0,1,0);

-- Add some projects to projects

DELETE FROM projects;
INSERT INTO projects (project_id, date_established, active, public) VALUES 
  ("","",1,1), 
  ("Bike Building", "2014-12-13", 1, 1), 
  ("Computers", "2014-12-13", 1, 1), 
  ("Inventory", "2014-12-13", 1, 1), 
  ("Organization", "2014-12-13", 1, 1), 
  ("Website", "2014-12-13", 1, 1),
  ("Toy Give-Away", "2014-12-13", 1, 1);

-- (not a requirement) Add some people to contacts
-- easy solution - 
--  select GROUP_CONCAT(COLUMN_NAME) from information_schema.COLUMNS where TABLE_NAME='contacts'
-- Then take that output and find the values ..
-- SELECT CONCAT_WS('","', col1, col2, ..., coln) FROM my_table;

DELETE FROM shop_hours;
DELETE FROM contacts;
ALTER TABLE contacts AUTO_INCREMENT = 1;
INSERT INTO contacts (
  contact_id, first_name, middle_initial, last_name, email, phone, address1, 
  address2, city, state, country, receive_newsletter, date_created, 
  invited_newsletter, DOB, pass, zip, hidden, location_name, location_type
) VALUES 
  (1,"Jonathan","","Rosenbaum","info@positivespin.org","","","","Morgantown","WV","","1","2014-12-12 18:19:35",0,"2005-11-09","test","26501","0","",NULL);

-- Set-up transaction types
-- This is object orienteed like :)
-- Storage period may be changed in transaction_log.php (defaults to 14)
-- fieldname_date -> the text field for the day the transaction transpires
-- fieldname_soldby -> the text field for the sales person (see shop_user_roles
-- table) who performs the sale (show_soldby)
-- community_bike -> allows a Quantity to be chosen
--
-- Recordset1 logic:
-- description_with_locations
-- if show_soldto_location & community_bike is set it "did" prevent 
-- the description from showing in the list (behavior altered), however 
-- "Quantity Bikes: sold_to" shows, but not description
-- this behavior is changed when community_bike is off in which case
-- "location_name Donation" is shown assuming there is a location_name
--
-- when show_soldto_location is checked for .. there is an option in 
-- transaction_log to show current shop users, 
-- but it is commented out in the code
-- show_soldto and show_soldby don't do anything 
-- obviously this was setup to keep track of donations and locations by YBP  
--
-- Transaction Types to add to make Metrics work properly:
--  "Metrics - Completed Mechanic Operation Bike" (quantity must be 1)
--  "Metrics - Completed Mechanic Operation Wheel" 
--  "Metrics - New Parts on a Completed Bike"
--  "Sale - Used Parts"
--  "Sale - New Parts"
--  "Sale - Complete Bikes"
--  Note:  "Sale - Used Parts" is the default select value
 
DELETE FROM transaction_types;
INSERT INTO transaction_types 
  (transaction_type_id, rank, active, community_bike, show_transaction_id, 
  show_type, show_startdate, show_amount, show_description, show_soldto, 
  show_soldby, fieldname_date, fieldname_soldby, message_transaction_id, 
  fieldname_soldto, show_soldto_location, fieldname_description, 
  accounting_group
) VALUES 
  ("DIY Bike", 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"), 
  ("Bicycles", 2, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"), 
  ("Non-inventory Parts", 3, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"), 
  ("Trade-ups/Ins", 4, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"), 
  ("Helmets", 5, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"), 
  ("Donations", 6, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"), 
  ("Memberships", 7, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"), 
  ("Inventory Parts", 8, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"), 
  ("Cargo Related", 9, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"), 
  ("Car Racks", 10, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"), 
  ("DIY Repairs", 11, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"),
  ("Accounts Receivable Invoice", 12, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"), 
  ("Accounts Receivable Payment", 13, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"), 
  ("Deposit", 14, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"),
  ("Metrics - Completed Mechanic Operation Bike", 15, 1, 0, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"),
  ("Metrics - Completed Mechanic Operation Wheel", 16, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"),
  ("Metrics - New Parts on a Completed Bike", 17, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"),
  ("Sale - Used Parts", 18, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"),
  ("Sale - New Parts", 19, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"),
  ("Sale - Complete Bike", 20, 1, 0, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group");

-- transaction_log - add paid or not
-- transaction_id, date_startstorage, date,transaction_type, amount,
-- description, sold_to, sold_by, quantity, shop_id, paid
ALTER TABLE transaction_log ADD paid tinyint(1) NOT NULL DEFAULT '0';



