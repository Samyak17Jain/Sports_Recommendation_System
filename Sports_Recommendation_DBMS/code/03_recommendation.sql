-- ============================================================
-- Sports Recommendation System
-- UCS310 - Database Management System
-- Thapar Institute of Engineering and Technology
-- Submitted by: Samyak Jain (1024170400), Sangam Sangwan (1024170388)
-- Batch: 2Q34  |  Instructor: Ms. Gayatri Saxena
-- ============================================================
-- FILE: 03_recommendation.sql
-- PURPOSE: SQL VIEW + PL/SQL Stored Procedure for sport recommendations
-- CHANGES:  (1) Added prefers_indoor → sport_type matching in the VIEW
--               (Yes → Indoor, No → Outdoor) to fix the missing logic bug.
--           (2) Demo now includes User 6 (Priya Nair) to exercise the
--               "No sports matched" fallback branch of the procedure.
-- ============================================================

-- ─── SPORT RECOMMENDATION VIEW ───────────────────────────────
-- Encapsulates all multi-criteria matching logic.
-- Matching rules applied via JOIN conditions:
--   1. User weight falls within sport's [min_weight_kg, max_kg_weight]
--   2. User age falls within sport's [min_age, max_age]
--   3. User free_time_hours >= sport's min_time_required_hrs
--   4. User stamina level (mapped Low=1, Medium=2, High=3)
--      >= sport's required stamina level (same mapping)
--   5. User's team preference (prefers_team) matches sport's is_team_sport
--   6. User's indoor preference (prefers_indoor) matches sport's sport_type
--      'Yes' → 'Indoor',  'No' → 'Outdoor'
--   7. If user has a health issue, only low-impact sports are recommended

CREATE OR REPLACE VIEW sport_recommendation_view AS
SELECT
    u.user_id,
    u.name,
    s.sport_id,
    s.sport_name,
    s.sport_type,
    s.equipment_required
FROM users u
JOIN physical_traits pt
    ON  pt.user_id = u.user_id
JOIN lifestyle l
    ON  l.user_id  = u.user_id
JOIN interests i
    ON  i.user_id  = u.user_id
JOIN sports s
    ON  pt.weight_kg BETWEEN s.min_weight_kg AND s.max_kg_weight
    AND u.age        BETWEEN s.min_age        AND s.max_age
    AND l.free_time_hours >= s.min_time_required_hrs
    -- Stamina level comparison using get_stamina_score() function
    -- (defined in 04_advanced.sql — run that file first)
    AND get_stamina_score(pt.stamina_level) >= get_stamina_score(s.required_stamina)
    -- Team preference must match exactly
    AND i.prefers_team = s.is_team_sport
    -- Indoor preference must match sport type
    -- 'Yes' (prefers indoor) → sport_type must be 'Indoor'
    -- 'No'  (prefers outdoor) → sport_type must be 'Outdoor'
    AND (
        (i.prefers_indoor = 'Yes' AND s.sport_type = 'Indoor')
        OR
        (i.prefers_indoor = 'No'  AND s.sport_type = 'Outdoor')
    )
    -- Users with health issues may only play low-impact sports
    AND (
        l.health_issue = 'None'
        OR s.low_impact = 'Yes'
    );


-- ─── STORED PROCEDURE: recommend_sports_for_user ─────────────
-- Accepts a user ID and prints all matched sports to DBMS_OUTPUT.
-- Uses an implicit FOR cursor over the view.
-- Prints a fallback message if no sport matches the user.
--
-- Usage:
--   SET SERVEROUTPUT ON;
--   EXEC recommend_sports_for_user(1);

CREATE OR REPLACE PROCEDURE recommend_sports_for_user (
    p_user_id IN NUMBER
) AS
    v_found NUMBER := 0;
BEGIN
    FOR rec IN (
        SELECT sport_name, sport_type, equipment_required
        FROM   sport_recommendation_view
        WHERE  user_id = p_user_id
        ORDER BY sport_name
    ) LOOP
        v_found := 1;
        DBMS_OUTPUT.PUT_LINE(
            'Recommended Sport: ' || rec.sport_name    ||
            ', Type: '            || rec.sport_type    ||
            ', Equipment: '       || rec.equipment_required
        );
    END LOOP;

    IF v_found = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No sports matched for user ID ' || p_user_id);
    END IF;
END;
/


-- ─── DEMO: Run recommendations for all 6 users ───────────────
-- Uncomment the lines below to test after running 01_schema.sql and 02_data.sql
-- User 6 (Priya Nair) has free_time_hours = 0.5, which is below every sport's
-- min_time_required_hrs, so she triggers the "No sports matched" fallback.

-- SET SERVEROUTPUT ON;
-- EXEC recommend_sports_for_user(1);  -- Aarav Sharma  (Active, Outdoor, Team, High stamina)
-- EXEC recommend_sports_for_user(2);  -- Diya Verma    (Moderate, Indoor, Solo, Medium stamina)
-- EXEC recommend_sports_for_user(3);  -- Kabir Mehta   (Active, Outdoor, Team, High stamina, Knee Pain)
-- EXEC recommend_sports_for_user(4);  -- Ananya Gupta  (Low, Indoor, Solo, Low stamina, Asthma)
-- EXEC recommend_sports_for_user(5);  -- Rohan Singh   (Moderate, Outdoor, Solo, Medium stamina)
-- EXEC recommend_sports_for_user(6);  -- Priya Nair    (No match — insufficient free time)

-- ─── ALTERNATIVE: Query the view directly ────────────────────
-- SELECT * FROM sport_recommendation_view ORDER BY user_id, sport_name;

-- ─── EXPECTED OUTPUT (for reference) ─────────────────────────
-- User 1 - Aarav Sharma:
--   Recommended Sport: Football, Type: Outdoor, Equipment: Football Kit
--   Recommended Sport: Volleyball, Type: Outdoor, Equipment: Volleyball
--
-- User 2 - Diya Verma:
--   Recommended Sport: Badminton, Type: Indoor, Equipment: Racket
--   Recommended Sport: Swimming, Type: Indoor, Equipment: Swimwear
--   Recommended Sport: Table Tennis, Type: Indoor, Equipment: Table Tennis Paddle
--
-- User 3 - Kabir Mehta (Knee Pain → low-impact only, but prefers Outdoor):
--   No sports matched for user ID 3
--   (Outdoor low-impact sports not in catalogue; Cycling is Outdoor+low_impact
--    but is_team_sport='No' and Kabir prefers team — no match)
--
-- User 4 - Ananya Gupta (Asthma → low-impact only, Indoor, Solo):
--   Recommended Sport: Table Tennis, Type: Indoor, Equipment: Table Tennis Paddle
--   Recommended Sport: Yoga, Type: Indoor, Equipment: Yoga Mat
--   Recommended Sport: Swimming, Type: Indoor, Equipment: Swimwear
--
-- User 5 - Rohan Singh:
--   Recommended Sport: Cycling, Type: Outdoor, Equipment: Bicycle
--
-- User 6 - Priya Nair (unmatchable — free_time_hours = 0.5):
--   No sports matched for user ID 6
