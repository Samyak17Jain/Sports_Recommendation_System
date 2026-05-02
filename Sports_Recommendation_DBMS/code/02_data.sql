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
