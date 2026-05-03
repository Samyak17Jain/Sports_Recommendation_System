# Sports Recommendation System
### UCS310 – Database Management System | Thapar Institute of Engineering and Technology

**Submitted by:** Samyak Jain (1024170400) · Sangam Sangwan (1024170388)  
**Batch:** 2Q34 | **Instructor:** Ms. Gayatri Saxena | **Academic Year:** 2025–2026

---

## Overview

A backend-based sports recommendation engine built entirely in SQL and PL/SQL on **Oracle Database**. The system stores structured user profiles across normalised relational tables and generates personalised sport recommendations using multi-criteria matching — covering weight, age, stamina, available time, health conditions, and personal preferences.

No frontend or machine learning is used. All matching logic lives in the database layer via VIEWs, stored procedures, functions, and triggers.

---

## Project Structure

```
Sports_Recommendation_DBMS/
├── 01_schema.sql          — DDL: table definitions with CHECK constraints & foreign keys
├── 02_data.sql            — DML: sample data for 6 users and 8 sports
├── 03_recommendation.sql  — VIEW + implicit-cursor stored procedure
├── 04_advanced.sql        — Function, trigger, explicit cursor, analytics queries
├── ER_Diagram.svg         — Entity-Relationship diagram
├── DBMS_Report.docx       — Full project report
└── DBMS_Sport_Recommendation_Synopsis.pdf — Project synopsis
```

---

## Database Schema

Five normalised tables (up to 3NF):

| Table | Purpose |
|-------|---------|
| `USERS` | Basic demographics — name, age, gender |
| `PHYSICAL_TRAITS` | Height, weight, stamina level, flexibility |
| `LIFESTYLE` | Activity level, free time (hrs/session), health conditions |
| `INTERESTS` | Indoor/outdoor preference, team/solo, competitiveness |
| `SPORTS` | Sports catalogue with eligibility criteria per sport |

---

## Recommendation Logic

The system matches users to sports across **7 criteria**, all encoded in a single database VIEW (`sport_recommendation_view`):

| Criterion | Rule |
|-----------|------|
| Weight | `user.weight_kg` must fall within `[sport.min_weight_kg, sport.max_kg_weight]` |
| Age | `user.age` must fall within `[sport.min_age, sport.max_age]` |
| Time | `user.free_time_hours >= sport.min_time_required_hrs` |
| Stamina | `get_stamina_score(user)` ≥ `get_stamina_score(sport)` (Low=1, Medium=2, High=3) |
| Team pref | `user.prefers_team = sport.is_team_sport` |
| Indoor pref | `Yes` → Indoor sports only · `No` → Outdoor sports only |
| Health | If health issue exists → only `low_impact = 'Yes'` sports recommended |

---

## How to Run

**Prerequisite:** Oracle Database or [Oracle Live SQL](https://livesql.oracle.com)

Run the files **in order**:

```sql
-- Step 1: Create tables
@01_schema.sql

-- Step 2: Insert sample data
@02_data.sql

-- Step 3: Create the VIEW and recommendation procedure
@03_recommendation.sql

-- Step 4: Create function, trigger, explicit cursor procedure, and analytics queries
@04_advanced.sql
```

**Run recommendations for a user:**

```sql
SET SERVEROUTPUT ON;
EXEC recommend_sports_for_user(1);      -- Aarav Sharma
EXEC recommend_sports_explicit(2);      -- Diya Verma (explicit cursor version)
```

**Query the view directly:**

```sql
SELECT * FROM sport_recommendation_view ORDER BY user_id, sport_name;
```

---

## PL/SQL Features Implemented

| Feature | Location | Description |
|---------|----------|-------------|
| `get_stamina_score()` | `04_advanced.sql` | Function — maps stamina label to numeric score (1/2/3) |
| `trg_validate_user_age` | `04_advanced.sql` | BEFORE INSERT/UPDATE trigger — rejects age outside 5–100 |
| `recommend_sports_for_user` | `03_recommendation.sql` | Procedure with implicit FOR cursor |
| `recommend_sports_explicit` | `04_advanced.sql` | Procedure with explicit OPEN/FETCH/CLOSE cursor + exception handling |
| `SAVEPOINT` / `ROLLBACK` | `04_advanced.sql` | Transaction control demonstration |

---

## Sample Output

```
=== Recommendations for: Aarav Sharma (ID 1) ===
  ► Football [Outdoor] | Equipment: Football Kit
  ► Volleyball [Outdoor] | Equipment: Volleyball

=== Recommendations for: Diya Verma (ID 2) ===
  ► Badminton [Indoor] | Equipment: Racket
  ► Swimming [Indoor] | Equipment: Swimwear
  ► Table Tennis [Indoor] | Equipment: Table Tennis Paddle

=== Recommendations for: Priya Nair (ID 6) ===
  No sports matched for this user profile.
```

---

## Analytical Queries (04_advanced.sql)

- **Query 1** — Count of matched sports per user (aggregate + LEFT JOIN)
- **Query 2** — Sports matched by more than 1 user (GROUP BY + HAVING)
- **Query 3** — Users eligible for more sports than average (correlated subquery)
- **Query 4** — Average weight & age of users eligible per sport
- **Query 5** — Users with health conditions and their matched sports (low-impact filter verification)

---

## Sample Users

| User | Age | Stamina | Health | Preference | Expected Result |
|------|-----|---------|--------|------------|-----------------|
| Aarav Sharma | 19 | High | None | Outdoor, Team | Football, Volleyball |
| Diya Verma | 20 | Medium | None | Indoor, Solo | Badminton, Swimming, Table Tennis |
| Kabir Mehta | 21 | High | Knee Pain | Outdoor, Team | No match (no outdoor low-impact team sports) |
| Ananya Gupta | 18 | Low | Asthma | Indoor, Solo | Table Tennis, Yoga, Swimming |
| Rohan Singh | 22 | Medium | None | Outdoor, Solo | Cycling |
| Priya Nair | 17 | Medium | None | Indoor, Solo | No match (only 0.5 hrs free — below all sports' minimum) |

---

## Technologies

- **Database:** Oracle Database (Oracle Live SQL compatible)
- **Language:** SQL (DDL + DML) and PL/SQL
- **Concepts:** 3NF normalisation, JOINs, VIEWs, stored procedures, functions, triggers, explicit cursors, exception handling, transaction control, aggregate analytics
