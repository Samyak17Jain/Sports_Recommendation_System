-- ============================================================
-- Sports Recommendation System
-- UCS310 - Database Management System
-- Thapar Institute of Engineering and Technology
-- Submitted by: Samyak Jain (1024170400), Sangam Sangwan (1024170388)
-- Batch: 2Q34  |  Instructor: Ms. Gayatri Saxena
-- ============================================================
-- FILE: 04_advanced.sql
-- PURPOSE: Advanced PL/SQL constructs + Analytical SQL queries
--          Covers: Function, Trigger, Explicit Cursor, Exception
--                  Handling, Subqueries, Aggregates, GROUP BY/HAVING
-- ============================================================


-- ════════════════════════════════════════════════════════════
-- SECTION 1: FUNCTION — get_stamina_score
-- ════════════════════════════════════════════════════════════
-- Converts a stamina label ('Low' | 'Medium' | 'High') into a
-- numeric score (1 / 2 / 3). Used both in the VIEW and to keep
-- comparison logic DRY across the schema.
--
-- Usage:  SELECT get_stamina_score('High') FROM dual;  -- returns 3

CREATE OR REPLACE FUNCTION get_stamina_score (
    p_level IN VARCHAR2
) RETURN NUMBER
IS
BEGIN
    RETURN CASE UPPER(p_level)
               WHEN 'LOW'    THEN 1
               WHEN 'MEDIUM' THEN 2
               WHEN 'HIGH'   THEN 3
               ELSE 0
           END;
END get_stamina_score;
/


-- ════════════════════════════════════════════════════════════
-- SECTION 2: TRIGGER — trg_validate_user_age
-- ════════════════════════════════════════════════════════════
-- Fires BEFORE INSERT OR UPDATE on USERS.
-- Raises an application error if age is outside the allowed
-- range (5–100), providing a meaningful message over a raw
-- CHECK constraint violation.

CREATE OR REPLACE TRIGGER trg_validate_user_age
BEFORE INSERT OR UPDATE ON users
FOR EACH ROW
BEGIN
    IF :NEW.age < 5 OR :NEW.age > 100 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Invalid age ' || :NEW.age ||
            ' for user "' || :NEW.name ||
            '". Age must be between 5 and 100.'
        );
    END IF;
END;
/

-- ─── Trigger test ────────────────────────────────────────────
-- The INSERT below should raise ORA-20001.
-- Uncomment to verify:
-- INSERT INTO users (name, age, gender) VALUES ('Ghost', 3, 'Male');


-- ════════════════════════════════════════════════════════════
-- SECTION 3: STORED PROCEDURE (v2) — recommend_sports_explicit
-- ════════════════════════════════════════════════════════════
-- Rewrite of recommend_sports_for_user using:
--   • An EXPLICIT named cursor (vs implicit FOR loop)
--   • Proper OPEN / FETCH / CLOSE lifecycle
--   • EXCEPTION block with NO_DATA_FOUND and OTHERS handlers
--
-- Usage:
--   SET SERVEROUTPUT ON;
--   EXEC recommend_sports_explicit(1);

CREATE OR REPLACE PROCEDURE recommend_sports_explicit (
    p_user_id IN NUMBER
) AS
    -- ── Explicit cursor declaration ──────────────────────────
    CURSOR c_sports IS
        SELECT sport_name, sport_type, equipment_required
        FROM   sport_recommendation_view
        WHERE  user_id = p_user_id
        ORDER BY sport_name;

    -- ── Local variables ──────────────────────────────────────
    v_rec    c_sports%ROWTYPE;
    v_found  BOOLEAN := FALSE;
    v_name   users.name%TYPE;

BEGIN
    -- Fetch user name for display (raises NO_DATA_FOUND if bad ID)
    SELECT name INTO v_name
    FROM   users
    WHERE  user_id = p_user_id;

    DBMS_OUTPUT.PUT_LINE('=== Recommendations for: ' || v_name || ' (ID ' || p_user_id || ') ===');

    -- ── Open, fetch, close ───────────────────────────────────
    OPEN c_sports;
    LOOP
        FETCH c_sports INTO v_rec;
        EXIT WHEN c_sports%NOTFOUND;

        v_found := TRUE;
        DBMS_OUTPUT.PUT_LINE(
            '  ► ' || v_rec.sport_name    ||
            ' ['   || v_rec.sport_type    || ']' ||
            ' | Equipment: ' || v_rec.equipment_required
        );
    END LOOP;
    CLOSE c_sports;

    IF NOT v_found THEN
        DBMS_OUTPUT.PUT_LINE('  No sports matched for this user profile.');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: No user found with ID ' || p_user_id);
    WHEN OTHERS THEN
        IF c_sports%ISOPEN THEN
            CLOSE c_sports;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
        RAISE;
END recommend_sports_explicit;
/


-- ════════════════════════════════════════════════════════════
-- SECTION 4: ANALYTICAL SQL QUERIES
-- ════════════════════════════════════════════════════════════

-- ── Query 1: COUNT of matched sports per user (Aggregate + JOIN) ──
-- Shows how many sports each user qualifies for.
SELECT
    u.user_id,
    u.name,
    COUNT(s.sport_id)  AS matched_sport_count
FROM users u
LEFT JOIN sport_recommendation_view s
    ON s.user_id = u.user_id
GROUP BY u.user_id, u.name
ORDER BY matched_sport_count DESC;


-- ── Query 2: Sports matched by MORE than 1 user (GROUP BY + HAVING) ──
-- Identifies popular sports that suit multiple user profiles.
SELECT
    s.sport_name,
    s.sport_type,
    COUNT(r.user_id)  AS eligible_user_count
FROM sports s
LEFT JOIN sport_recommendation_view r
    ON r.sport_id = s.sport_id
GROUP BY s.sport_name, s.sport_type
HAVING COUNT(r.user_id) > 1
ORDER BY eligible_user_count DESC;


-- ── Query 3: Users eligible for MORE sports than average (Subquery) ──
-- Finds power users whose profile matches a broader range of sports.
SELECT
    u.user_id,
    u.name,
    COUNT(r.sport_id) AS sport_count
FROM users u
JOIN sport_recommendation_view r
    ON r.user_id = u.user_id
GROUP BY u.user_id, u.name
HAVING COUNT(r.sport_id) > (
    SELECT AVG(cnt)
    FROM (
        SELECT COUNT(sport_id) AS cnt
        FROM   sport_recommendation_view
        GROUP BY user_id
    )
)
ORDER BY sport_count DESC;


-- ── Query 4: Average weight of users eligible for each sport (Aggregate) ──
-- Useful for understanding the physical profile of users per sport.
SELECT
    r.sport_name,
    ROUND(AVG(pt.weight_kg), 1)  AS avg_user_weight_kg,
    ROUND(AVG(u.age), 1)         AS avg_user_age,
    COUNT(r.user_id)             AS eligible_users
FROM sport_recommendation_view r
JOIN physical_traits pt
    ON pt.user_id = r.user_id
JOIN users u
    ON u.user_id  = r.user_id
GROUP BY r.sport_name
ORDER BY eligible_users DESC;


-- ── Query 5: Users with health issues and their matched sports ──
-- Verifies the low-impact filter is working correctly.
SELECT
    u.name,
    l.health_issue,
    r.sport_name,
    r.sport_type
FROM users u
JOIN lifestyle l
    ON l.user_id = u.user_id
JOIN sport_recommendation_view r
    ON r.user_id = u.user_id
WHERE l.health_issue <> 'None'
ORDER BY u.name, r.sport_name;


-- ── Query 6: UPDATE & DELETE examples (DML coverage) ──────────
-- Update Rohan Singh's free time to 3 hours
UPDATE lifestyle
SET    free_time_hours = 3
WHERE  user_id = (SELECT user_id FROM users WHERE name = 'Rohan Singh');

-- Remove the test/unmatchable user (Priya Nair) after demonstration
-- (Uncomment to execute)
-- DELETE FROM interests        WHERE user_id = 6;
-- DELETE FROM lifestyle        WHERE user_id = 6;
-- DELETE FROM physical_traits  WHERE user_id = 6;
-- DELETE FROM users            WHERE user_id = 6;

COMMIT;


-- ── Query 7: SAVEPOINT + ROLLBACK example ─────────────────────
-- Demonstrates transaction control beyond simple COMMIT.
SAVEPOINT before_test_insert;

INSERT INTO users (user_id, name, age, gender)
VALUES (99, 'Test User', 25, 'Male');

-- Verify it is visible in the current transaction
SELECT name FROM users WHERE user_id = 99;

-- Roll back — test insert is discarded
ROLLBACK TO SAVEPOINT before_test_insert;

-- Confirm rollback: this should return no rows
-- SELECT name FROM users WHERE user_id = 99;
