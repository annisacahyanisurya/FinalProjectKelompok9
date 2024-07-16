BEGIN TRANSACTION

INSERT INTO regions VALUES
('Europe'),('America'),('Asia'),('Middle East and Africa')

INSERT INTO roles VALUES
('Super Admin'), ('Admin'), ('Manager'), ('Employee')

INSERT INTO permissions VALUES 
('Add Employee'),('Edit Employee'),('Delete Employee'),('Detail Employee'),
('Add Job'),('Edit Job'),('Delete Job'),
('Add Department'),('Edit Department'),('Delete Department'),
('Add Location'),('Edit Location'),('Delete Location'),
('Add Country'),('Edit Country'),('Delete Country'),
('Add Region'),('Edit Region'),('Delete Region'),
('Add Role'),('Edit Role'),('Delete Role'),
('Add Permission'),('Edit Permission'),('Delete Permission'),
('Edit Profile'), ('Change Password')

INSERT INTO role_permissions VALUES 
(1, 1),(1, 2),(1, 3),(1, 4),(1, 5),(1, 6),(1, 7),(1, 8),(1, 9),(1, 10),(1, 11),(1, 12),(1, 13),(1, 14),(1, 15),
(1, 17),(1, 18),(1, 19),(1, 20),(1, 21),(1, 22),(1, 23),(1, 24),(1, 25),
(2, 1),(2, 2),(2, 3),(2, 4),(2, 5),(2, 6),(2, 7),(2, 8),(2, 9),(2, 10),(2, 11),(2, 12),(2, 13),(2, 14),(2, 15),
(2, 17),(2, 18),(2, 20),(2, 21),
(3, 2),(3, 4),(3, 26),(3, 27),
(4, 26),(4,27)

COMMIT;
