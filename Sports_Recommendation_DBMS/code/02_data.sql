-- ============================================================
-- Sports Recommendation System
-- UCS310 - Database Management System
-- Thapar Institute of Engineering and Technology
-- Submitted by: Samyak Jain (1024170400), Sangam Sangwan (1024170388)
-- Batch: 2Q34  |  Instructor: Ms. Gayatri Saxena
-- ============================================================
-- FILE: 02_data.sql
-- PURPOSE: DML - Insert sample data for 6 users and 8 sports
-- CHANGES:  Added User 6 (Priya Nair) — deliberately unmatchable to test
--           the stored procedure's fallback message path.
--           Profile: very low free time (0.5 hrs), High stamina required
--           but Low stamina, team sport preferred — no sport satisfies all.
-- ============================================================

-- ─── USERS ───────────────────────────────────────────────────
INSERT INTO users (user_id, name, age, gender) VALUES (1, 'Aarav Sharma', 19, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (2, 'Diya Verma',   20, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (3, 'Kabir Mehta',  21, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (4, 'Ananya Gupta', 18, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (5, 'Rohan Singh',  22, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (7, 'Arjun Patel', 23, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (8, 'Sneha Reddy', 21, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (9, 'Vikram Joshi', 24, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (10, 'Meera Iyer', 20, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (11, 'Rahul Kapoor', 22, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (12, 'Pooja Sharma', 19, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (13, 'Karan Malhotra', 25, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (14, 'Neha Agarwal', 18, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (15, 'Aditya Verma', 21, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (16, 'Ishita Singh', 23, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (17, 'Aman Gupta', 18, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (18, 'Riya Mehta', 19, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (19, 'Sahil Khan', 20, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (20, 'Anjali Desai', 21, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (21, 'Nikhil Jain', 22, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (22, 'Kavya Nair', 23, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (23, 'Rohit Yadav', 24, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (24, 'Simran Kaur', 20, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (25, 'Deepak Sharma', 21, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (26, 'Priyanka Das', 22, 'Female');

INSERT INTO users (user_id, name, age, gender) VALUES (27, 'Varun Bansal', 23, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (28, 'Nisha Verma', 19, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (29, 'Akash Singh', 20, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (30, 'Pallavi Gupta', 21, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (31, 'Tarun Arora', 22, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (32, 'Shreya Kapoor', 23, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (33, 'Mohit Saini', 24, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (34, 'Aditi Mishra', 18, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (35, 'Yash Thakur', 21, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (36, 'Tanvi Joshi', 22, 'Female');

INSERT INTO users (user_id, name, age, gender) VALUES (37, 'Harsh Vardhan', 23, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (38, 'Isha Arora', 20, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (39, 'Manish Pandey', 21, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (40, 'Ritika Singh', 22, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (41, 'Kunal Choudhary', 24, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (42, 'Sanya Malhotra', 19, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (43, 'Abhishek Roy', 20, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (44, 'Pooja Sethi', 21, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (45, 'Gaurav Saxena', 22, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (46, 'Neha Bhatt', 23, 'Female');

INSERT INTO users (user_id, name, age, gender) VALUES (47, 'Siddharth Jain', 24, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (48, 'Aarushi Gupta', 18, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (49, 'Prateek Agarwal', 19, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (50, 'Komal Yadav', 20, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (51, 'Ramesh Kumar', 25, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (52, 'Seema Sharma', 22, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (53, 'Ajay Verma', 23, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (54, 'Jyoti Mishra', 21, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (55, 'Naveen Reddy', 24, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (56, 'Bhavna Nair', 20, 'Female');

INSERT INTO users (user_id, name, age, gender) VALUES (57, 'Sunil Patel', 22, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (58, 'Divya Iyer', 23, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (59, 'Lokesh Singh', 21, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (60, 'Preeti Das', 19, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (61, 'Vikas Gupta', 24, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (62, 'Ankita Sharma', 20, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (63, 'Ravi Kumar', 23, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (64, 'Megha Jain', 21, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (65, 'Anil Yadav', 25, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (66, 'Swati Kapoor', 22, 'Female');

INSERT INTO users (user_id, name, age, gender) VALUES (67, 'Suresh Singh', 24, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (68, 'Kritika Mehta', 18, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (69, 'Rajesh Verma', 23, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (70, 'Nandini Gupta', 20, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (71, 'Arvind Kumar', 22, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (72, 'Payal Sharma', 21, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (73, 'Hemant Joshi', 24, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (74, 'Sakshi Singh', 19, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (75, 'Pankaj Yadav', 23, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (76, 'Ruchi Agarwal', 22, 'Female');

INSERT INTO users (user_id, name, age, gender) VALUES (77, 'Devendra Kumar', 25, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (78, 'Shalini Verma', 21, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (79, 'Ashish Gupta', 24, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (80, 'Monika Sharma', 20, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (81, 'Kapil Jain', 23, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (82, 'Pooja Yadav', 22, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (83, 'Rohit Kumar', 24, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (84, 'Neelam Singh', 19, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (85, 'Gopal Sharma', 23, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (86, 'Anita Verma', 21, 'Female');

INSERT INTO users (user_id, name, age, gender) VALUES (87, 'Mahesh Yadav', 25, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (88, 'Kiran Gupta', 20, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (89, 'Vinay Kumar', 24, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (90, 'Rekha Sharma', 22, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (91, 'Deepak Singh', 23, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (92, 'Suman Verma', 21, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (93, 'Rakesh Gupta', 25, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (94, 'Alka Yadav', 20, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (95, 'Prakash Kumar', 24, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (96, 'Geeta Sharma', 22, 'Female');

INSERT INTO users (user_id, name, age, gender) VALUES (97, 'Dinesh Singh', 23, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (98, 'Kusum Verma', 21, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (99, 'Sanjay Gupta', 25, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (100, 'Lata Yadav', 20, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (101, 'Mukesh Kumar', 24, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (102, 'Sarita Sharma', 22, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (103, 'Ravi Verma', 23, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (104, 'Sunita Gupta', 21, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (105, 'Anand Yadav', 25, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (106, 'Pinky Sharma', 20, 'Female');

INSERT INTO users (user_id, name, age, gender) VALUES (107, 'Ajit Kumar', 24, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (108, 'Reena Verma', 22, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (109, 'Manoj Gupta', 23, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (110, 'Kavita Yadav', 21, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (111, 'Naresh Kumar', 25, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (112, 'Babita Sharma', 20, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (113, 'Suresh Verma', 24, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (114, 'Kamla Gupta', 22, 'Female');
INSERT INTO users (user_id, name, age, gender) VALUES (115, 'Ramesh Yadav', 23, 'Male');
INSERT INTO users (user_id, name, age, gender) VALUES (116, 'Meena Kumar', 21, 'Female');
-- User 6: deliberately unmatchable — only 0.5 free hours (below all sports'
-- min_time_required_hrs of 1), so no sport can be recommended. This confirms
-- the stored procedure's "No sports matched" fallback branch executes correctly.
INSERT INTO users (user_id, name, age, gender) VALUES (6, 'Priya Nair',   17, 'Female');


-- ─── PHYSICAL TRAITS ─────────────────────────────────────────
-- user_id | height_cm | weight_kg | stamina_level | flexibility_level
INSERT INTO physical_traits (trait_id, user_id, height_cm, weight_kg, stamina_level, flexibility_level)
VALUES (1, 1, 175, 68, 'High',   'Medium');
INSERT INTO physical_traits (trait_id, user_id, height_cm, weight_kg, stamina_level, flexibility_level)
VALUES (2, 2, 162, 54, 'Medium', 'High');
INSERT INTO physical_traits (trait_id, user_id, height_cm, weight_kg, stamina_level, flexibility_level)
VALUES (3, 3, 180, 82, 'High',   'Low');
INSERT INTO physical_traits (trait_id, user_id, height_cm, weight_kg, stamina_level, flexibility_level)
VALUES (4, 4, 158, 50, 'Low',    'High');
INSERT INTO physical_traits (trait_id, user_id, height_cm, weight_kg, stamina_level, flexibility_level)
VALUES (5, 5, 172, 74, 'Medium', 'Medium');
-- Priya: normal physical traits — the blocker is purely free_time_hours = 0.5
INSERT INTO physical_traits (trait_id, user_id, height_cm, weight_kg, stamina_level, flexibility_level)
VALUES (6, 6, 160, 52, 'Medium', 'Medium');

-- ─── LIFESTYLE ────────────────────────────────────────────────
-- user_id | activity_level | free_time_hours | health_issue
INSERT INTO lifestyle (lifestyle_id, user_id, activity_level, free_time_hours, health_issue)
VALUES (1, 1, 'Active',   2,   'None');
INSERT INTO lifestyle (lifestyle_id, user_id, activity_level, free_time_hours, health_issue)
VALUES (2, 2, 'Moderate', 1,   'None');
INSERT INTO lifestyle (lifestyle_id, user_id, activity_level, free_time_hours, health_issue)
VALUES (3, 3, 'Active',   3,   'Knee Pain');
INSERT INTO lifestyle (lifestyle_id, user_id, activity_level, free_time_hours, health_issue)
VALUES (4, 4, 'Low',      1,   'Asthma');
INSERT INTO lifestyle (lifestyle_id, user_id, activity_level, free_time_hours, health_issue)
VALUES (5, 5, 'Moderate', 2,   'None');
-- Priya: only 0.5 free hours — below every sport's min_time_required_hrs (1+)
INSERT INTO lifestyle (lifestyle_id, user_id, activity_level, free_time_hours, health_issue)
VALUES (6, 6, 'Low',      0.5, 'None');

-- ─── INTERESTS ────────────────────────────────────────────────
-- user_id | prefers_indoor | prefers_team | competitiveness
INSERT INTO interests (interest_id, user_id, prefers_indoor, prefers_team, competitiveness)
VALUES (1, 1, 'No',  'Yes', 'High');
INSERT INTO interests (interest_id, user_id, prefers_indoor, prefers_team, competitiveness)
VALUES (2, 2, 'Yes', 'No',  'Medium');
INSERT INTO interests (interest_id, user_id, prefers_indoor, prefers_team, competitiveness)
VALUES (3, 3, 'No',  'Yes', 'High');
INSERT INTO interests (interest_id, user_id, prefers_indoor, prefers_team, competitiveness)
VALUES (4, 4, 'Yes', 'No',  'Low');
INSERT INTO interests (interest_id, user_id, prefers_indoor, prefers_team, competitiveness)
VALUES (5, 5, 'No',  'No',  'Medium');
INSERT INTO interests (interest_id, user_id, prefers_indoor, prefers_team, competitiveness)
VALUES (6, 6, 'Yes', 'No',  'Low');

-- ─── SPORTS CATALOGUE ─────────────────────────────────────────
-- sport_id | sport_name | type | req_stamina | team | min_wt | max_wt | min_hrs | low_impact | min_age | max_age | equipment
INSERT INTO sports (sport_id, sport_name, sport_type, required_stamina, is_team_sport,
                    min_weight_kg, max_kg_weight, min_time_required_hrs,
                    low_impact, min_age, max_age, equipment_required)
VALUES (1, 'Football',     'Outdoor', 'High',   'Yes', 50, 90,  2, 'No',  15, 30, 'Football Kit');

INSERT INTO sports (sport_id, sport_name, sport_type, required_stamina, is_team_sport,
                    min_weight_kg, max_kg_weight, min_time_required_hrs,
                    low_impact, min_age, max_age, equipment_required)
VALUES (2, 'Badminton',    'Indoor',  'Medium', 'No',  40, 85,  1, 'Yes', 12, 40, 'Racket');

INSERT INTO sports (sport_id, sport_name, sport_type, required_stamina, is_team_sport,
                    min_weight_kg, max_kg_weight, min_time_required_hrs,
                    low_impact, min_age, max_age, equipment_required)
VALUES (3, 'Basketball',   'Indoor',  'High',   'Yes', 50, 95,  2, 'No',  15, 28, 'Basketball Shoes');

INSERT INTO sports (sport_id, sport_name, sport_type, required_stamina, is_team_sport,
                    min_weight_kg, max_kg_weight, min_time_required_hrs,
                    low_impact, min_age, max_age, equipment_required)
VALUES (4, 'Swimming',     'Indoor',  'Medium', 'No',  35, 100, 1, 'Yes', 10, 45, 'Swimwear');

INSERT INTO sports (sport_id, sport_name, sport_type, required_stamina, is_team_sport,
                    min_weight_kg, max_kg_weight, min_time_required_hrs,
                    low_impact, min_age, max_age, equipment_required)
VALUES (5, 'Yoga',         'Indoor',  'Low',    'No',  35, 110, 1, 'Yes', 12, 60, 'Yoga Mat');

INSERT INTO sports (sport_id, sport_name, sport_type, required_stamina, is_team_sport,
                    min_weight_kg, max_kg_weight, min_time_required_hrs,
                    low_impact, min_age, max_age, equipment_required)
VALUES (6, 'Table Tennis', 'Indoor',  'Low',    'No',  35, 90,  1, 'Yes', 12, 50, 'Table Tennis Paddle');

INSERT INTO sports (sport_id, sport_name, sport_type, required_stamina, is_team_sport,
                    min_weight_kg, max_kg_weight, min_time_required_hrs,
                    low_impact, min_age, max_age, equipment_required)
VALUES (7, 'Volleyball',   'Outdoor', 'Medium', 'Yes', 45, 90,  2, 'No',  15, 30, 'Volleyball');

INSERT INTO sports (sport_id, sport_name, sport_type, required_stamina, is_team_sport,
                    min_weight_kg, max_kg_weight, min_time_required_hrs,
                    low_impact, min_age, max_age, equipment_required)
VALUES (8, 'Cycling',      'Outdoor', 'Medium', 'No',  40, 95,  1, 'Yes', 14, 45, 'Bicycle');

COMMIT;
