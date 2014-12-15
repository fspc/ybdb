-- This is probably the first documentation ever created for this project!

-- Add shop_locations and shop_types

DELETE FROM shop_locations;
INSERT INTO shop_locations (shop_location_id, date_established, active) VALUES ("Positive Spin", "2005-11-09",1), ("Plan B", "2000-01-01", 1), ("Third Hand", "2003-01-01", 1), ("Austin Yellow Bike Project", "1997-01-01", 1);

DELETE FROM shop_types;
INSERT INTO shop_types (shop_type_id, list_order) VALUES ("Open Shop", 1), ("Bike Education", 4), ("Volunteer Only", 2), ("Meeting", 3 );

-- Add shop user roles to shop_user_roles
-- sales == 1 if you want a role to be able to do sales
-- volunteer == 1 if you want to keep track of volunteer hours

DELETE FROM shop_user_roles;
INSERT INTO shop_user_roles (shop_user_role_id,hours_rank,volunteer,sales,paid) VALUES ("Coordinator",0,0,1,0), ("Personal",0,0,0,0), ("Volunteer",0,1,0,0), ("Greeter",0,0,1,0);

-- Add some projects to projects

DELETE FROM projects;
INSERT INTO projects (project_id, date_established, active, public) VALUES ("","",1,1), ("Bike Building", "2014-12-13", 1, 1), ("Computers", "2014-12-13", 1, 1), ("Inventory", "2014-12-13", 1, 1), ("Organization", "2014-12-13", 1, 1), ("Website", "2014-12-13", 1, 1);

-- (not a requirement) Add some people to contacts
-- easy solution - 
--  select GROUP_CONCAT(COLUMN_NAME) from information_schema.COLUMNS where TABLE_NAME='contacts'
-- Then take that output and find the values ..
-- SELECT CONCAT_WS('","', col1, col2, ..., coln) FROM my_table;

DELETE FROM shop_hours;
DELETE FROM contacts;
ALTER TABLE contacts AUTO_INCREMENT = 1;
INSERT INTO contacts (contact_id, first_name, middle_initial, last_name, email, phone, address1, address2, city, state, country, receive_newsletter, date_created, invited_newsletter, DOB, pass, zip, hidden, location_name, location_type) VALUES ( 1,"Jonathan","","Rosenbaum","info@positivespin.org","","","","Morgantown","WV","","1","2014-12-12 18:19:35",0,"2005-11-09","test","26501","0","",NULL);

-- Set-up transaction types
-- This is object orienteed like
-- Storage period may be changed in transaction_log.php (defaults to 42)
-- fieldname_date -> the text field for the day the transaction transpires
-- fieldname_soldby -> the text field for the sales person (see shop_user_roles
-- table) who performs the sale (show_soldby)
-- community_bike -> allows a Quantity to be chosen
--
-- bug? if show_soldto is set it prevents the description from showing 
-- in the list, however Quantity Bikes: sold_to show
 
DELETE FROM transaction_types;
INSERT INTO transaction_types (transaction_type_id, rank, active, community_bike, show_transaction_id, show_type, show_startdate, show_amount, show_description, show_soldto, show_soldby, fieldname_date, fieldname_soldby, message_transaction_id, fieldname_soldto, show_soldto_location, fieldname_description, accounting_group) VALUES ("DIY Bike", 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group"), ("Bike(s)", 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, "fieldname_date", "fieldname_soldby"," message_transaction_id", "fieldname_soldto", 1, "fieldname_description", "accounting_group");


