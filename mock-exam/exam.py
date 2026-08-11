#!/usr/bin/env python3
"""
42-Style Interactive Exam System for ISDA Mock SQL Examination (`isda-mock-exam`).
Sequentially unlocks 1 random question per topic across 7 levels (7 questions per exam run).
Question Bank: 126 total questions (18 questions per topic pool across 7 topics), including
original textbook questions from "Covering SQL/DS Release 2".
Topics: SELECT, WHERE, AGGREGATION, GROUP BY, JOIN, HAVING, SUBQUERY.
"""

import os
import sys
import json
import random
import subprocess
import csv
import io
import shutil
from pathlib import Path
from datetime import datetime

# Configuration
DB_NAME = os.getenv("DB_NAME", "isda-mock-exam")
DB_USER = os.getenv("DB_USER", "postgres")
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_PASSWORD = os.getenv("DB_PASSWORD", "postgrespassword")
DOCKER_CONTAINER = os.getenv("DOCKER_CONTAINER", "postgres_db")

# Terminal Color Codes
GREEN = "\033[92m"
RED = "\033[91m"
YELLOW = "\033[93m"
CYAN = "\033[96m"
MAGENTA = "\033[95m"
BOLD = "\033[1m"
RESET = "\033[0m"

TOPICS = [
    "SELECT",
    "WHERE",
    "AGGREGATION",
    "GROUP BY",
    "JOIN",
    "HAVING",
    "SUBQUERY"
]

TOPIC_POOLS = [
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 71, 72, 73, 74, 75, 106, 107, 108],             # Level 0: SELECT
    [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 76, 77, 78, 79, 80, 109, 110, 111],    # Level 1: WHERE
    [21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 81, 82, 83, 84, 85, 112, 113, 114],    # Level 2: AGGREGATION
    [31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 86, 87, 88, 89, 90, 115, 116, 117],    # Level 3: GROUP BY
    [41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 91, 92, 93, 94, 95, 118, 119, 120],    # Level 4: JOIN
    [51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 96, 97, 98, 99, 100, 121, 122, 123],   # Level 5: HAVING
    [61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 101, 102, 103, 104, 105, 124, 125, 126] # Level 6: SUBQUERY
]

base_dir = Path(__file__).resolve().parent
state_file = base_dir / ".exam_state.json"
current_q_file = base_dir / "CURRENT_QUESTION.md"
submission_file = base_dir / "submission.sql.txt"


def run_sql_query(sql_text: str):
    env = os.environ.copy()
    env["PGPASSWORD"] = DB_PASSWORD

    cmd_local = [
        "psql",
        "-h", DB_HOST,
        "-p", DB_PORT,
        "-U", DB_USER,
        "-d", DB_NAME,
        "-A",
        "-F", ",",
        "-q",
        "-c", sql_text
    ]

    try:
        res = subprocess.run(cmd_local, env=env, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, timeout=10)
        if res.returncode == 0:
            return parse_csv_output(res.stdout)
    except Exception:
        pass

    cmd_docker = [
        "docker", "exec", "-i", DOCKER_CONTAINER,
        "psql",
        "-U", DB_USER,
        "-d", DB_NAME,
        "-A",
        "-F", ",",
        "-q"
    ]
    try:
        res = subprocess.run(cmd_docker, input=sql_text, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, timeout=10)
        if res.returncode == 0:
            return parse_csv_output(res.stdout)
        else:
            return False, [], [], res.stderr.strip()
    except Exception as e:
        return False, [], [], str(e)


def parse_csv_output(csv_text: str):
    lines = csv_text.strip().splitlines()
    clean_lines = [line for line in lines if not (line.startswith("(") and line.endswith("rows)")) and not (line.startswith("(") and line.endswith("row)"))]
    
    if not clean_lines:
        return True, [], [], ""

    try:
        reader = list(csv.reader(io.StringIO("\n".join(clean_lines))))
        if not reader:
            return True, [], [], ""
        headers = reader[0]
        rows = [tuple(row) for row in reader[1:]]
        return True, headers, rows, ""
    except Exception as e:
        return False, [], [], f"Failed to parse query result: {e}"


def normalize_value(val: str) -> str:
    val = val.strip()
    try:
        f_val = float(val)
        return f"{f_val:.4f}".rstrip('0').rstrip('.')
    except ValueError:
        return val.lower()


def compare_results(student_headers, student_rows, solution_headers, solution_rows):
    if len(student_headers) != len(solution_headers):
        return False, f"Column count mismatch. Expected {len(solution_headers)} columns ({', '.join(solution_headers)}), got {len(student_headers)} columns."

    if len(student_rows) != len(solution_rows):
        return False, f"Row count mismatch. Expected {len(solution_rows)} rows, got {len(student_rows)} rows."

    norm_student = [[normalize_value(cell) for cell in row] for row in student_rows]
    norm_solution = [[normalize_value(cell) for cell in row] for row in solution_rows]

    if norm_student != norm_solution:
        sorted_student = sorted(norm_student)
        sorted_solution = sorted(norm_solution)
        if sorted_student == sorted_solution:
            return False, "Row content matches, but row ordering does NOT match the required ORDER BY clause."
        return False, f"Data mismatch.\nExpected first row: {solution_rows[0] if solution_rows else 'None'}\nActual first row:   {student_rows[0] if student_rows else 'None'}"

    return True, "Passed!"


def load_state():
    if state_file.exists():
        try:
            return json.loads(state_file.read_text())
        except Exception:
            pass
    return None


def save_state(state):
    state_file.write_text(json.dumps(state, indent=2))


def start_new_session():
    # Pick 1 random question for each of the 7 topics (Level 0 to 6) from its 18-question pool
    selected_qs = []
    for level in range(len(TOPICS)):
        pool = TOPIC_POOLS[level]
        q_num = random.choice(pool)
        selected_qs.append(f"{q_num:02d}" if q_num < 100 else f"{q_num}")

    state = {
        "session_id": datetime.now().strftime("%Y%m%d_%H%M%S"),
        "current_level": 0,
        "max_level": len(TOPICS) - 1,
        "selected_questions": selected_qs,
        "completed": False,
        "started_at": datetime.now().isoformat()
    }
    save_state(state)
    setup_current_question(state)
    return state


def setup_current_question(state):
    lvl = state["current_level"]
    q_id = state["selected_questions"][lvl]
    topic = TOPICS[lvl]

    # Source markdown question
    source_md = base_dir / "questions" / f"{q_id}.md"
    if source_md.exists():
        md_text = source_md.read_text()
        current_md = f"# [42 EXAM RUN] Level {lvl}: {topic}\n\n" + md_text
        current_q_file.write_text(current_md)

    # Initialize submission.sql.txt if empty or new level
    sub_text = f"-- [42 EXAM RUN] Level {lvl} ({topic}) - Question {q_id}\n-- Write your Standard ANSI SQL query solution below\n\n"
    submission_file.write_text(sub_text)


def grade_current():
    state = load_state()
    if not state or state.get("completed"):
        print(f"{YELLOW}No active 42 exam session found! Starting a new exam run...{RESET}")
        state = start_new_session()

    lvl = state["current_level"]
    q_id = state["selected_questions"][lvl]
    topic = TOPICS[lvl]

    print(f"\n{BOLD}{CYAN}====================================================={RESET}")
    print(f"{BOLD}{CYAN}      42 EXAM GRADER - LEVEL {lvl} [{topic}]            {RESET}")
    print(f"{BOLD}{CYAN}====================================================={RESET}")
    print(f"Target Database: {BOLD}{DB_NAME}{RESET}")
    print(f"Current Question: {BOLD}Question {q_id}{RESET}\n")

    # Read solution
    sol_file = base_dir / "solutions" / f"{q_id}.sql"
    if not sol_file.exists():
        print(f"{RED}[ERROR] Solution file {sol_file.name} missing.{RESET}")
        sys.exit(1)

    sol_sql = sol_file.read_text()
    sol_ok, sol_headers, sol_rows, sol_err = run_sql_query(sol_sql)
    if not sol_ok:
        print(f"{RED}[ERROR] DB Error on reference query: {sol_err}{RESET}")
        sys.exit(1)

    # Read student submission
    if not submission_file.exists():
        print(f"{RED}[ERROR] Submission file 'submission.sql.txt' not found.{RESET}")
        sys.exit(1)

    student_sql = submission_file.read_text().strip()
    sql_lines = [line.strip() for line in student_sql.splitlines() if line.strip() and not line.strip().startswith("--")]
    if not sql_lines:
        print(f"{YELLOW}[STATUS] submission.sql.txt is empty or unedited.{RESET}")
        print(f"Please read {BOLD}CURRENT_QUESTION.md{RESET} and write your query in {BOLD}submission.sql.txt{RESET}.")
        sys.exit(1)

    ans_ok, ans_headers, ans_rows, ans_err = run_sql_query(student_sql)
    if not ans_ok:
        print(f"{RED}{BOLD}[FAILURE] SQL Syntax / Execution Error:{RESET}\n{ans_err}")
        print(f"\n{YELLOW}Level {lvl} remains LOCKED. Fix submission.sql.txt and submit again.{RESET}\n")
        sys.exit(1)

    is_correct, msg = compare_results(ans_headers, ans_rows, sol_headers, sol_rows)

    if is_correct:
        print(f"{GREEN}{BOLD}>>>>>>>> SUCCESS! Level {lvl} [{topic}] PASSED! <<<<<<<<{RESET}\n")
        if lvl < state["max_level"]:
            state["current_level"] += 1
            save_state(state)
            setup_current_question(state)
            next_lvl = state["current_level"]
            next_topic = TOPICS[next_lvl]
            print(f"{BOLD}{MAGENTA}🔓 UNLOCKED Level {next_lvl} [{next_topic}]!{RESET}")
            print(f"Read updated problem details in {BOLD}CURRENT_QUESTION.md{RESET}.")
            print(f"Write your query in {BOLD}submission.sql.txt{RESET} and run 'make grade'!\n")
        else:
            state["completed"] = True
            save_state(state)
            print(f"{BOLD}{GREEN}====================================================={RESET}")
            print(f"{BOLD}{GREEN} 🎓 CONGRATULATIONS! YOU PASSED THE 42 SQL EXAM RUN! {RESET}")
            print(f"{BOLD}{GREEN} All {len(TOPICS)} Levels (SELECT to SUBQUERY) Successfully Cleared! {RESET}")
            print(f"{BOLD}{GREEN}====================================================={RESET}\n")
    else:
        print(f"{RED}{BOLD}[FAILURE] Test Failed for Level {lvl}:{RESET}")
        print(f"  └─ {YELLOW}{msg}{RESET}")
        print(f"\n{YELLOW}Level {lvl} remains LOCKED. Fix submission.sql.txt and submit again.{RESET}\n")
        sys.exit(1)


def show_status():
    state = load_state()
    if not state:
        print(f"{YELLOW}No active 42 exam session. Run 'make exam' to start!{RESET}")
        return

    print(f"\n{BOLD}{CYAN}====================================================={RESET}")
    print(f"{BOLD}{CYAN}         42 SQL EXAM SESSION STATUS                  {RESET}")
    print(f"{BOLD}{CYAN}====================================================={RESET}")
    print(f"Session ID: {state['session_id']}")
    print(f"Started At: {state['started_at']}")

    if state.get("completed"):
        print(f"\n{BOLD}{GREEN}Status: GRADUATED / COMPLETED ({len(TOPICS)} / {len(TOPICS)} Passed){RESET}\n")
        return

    curr = state["current_level"]
    print(f"\n{BOLD}Current Level:{RESET} Level {curr} [{TOPICS[curr]}]")
    print(f"{BOLD}Question ID:{RESET} Question {state['selected_questions'][curr]}")

    print(f"\n{BOLD}Progression Roadmap:{RESET}")
    for idx, t in enumerate(TOPICS):
        q_id = state['selected_questions'][idx]
        if idx < curr:
            print(f"  Level {idx} [{t}]: {GREEN}✓ PASSED (Q{q_id}){RESET}")
        elif idx == curr:
            print(f"  Level {idx} [{t}]: {YELLOW}▶ CURRENT / LOCKED (Q{q_id}){RESET}")
        else:
            print(f"  Level {idx} [{t}]: 🔒 LOCKED")

    print(f"\n{BOLD}Instructions:{RESET}")
    print(f"  1. Read question details in {BOLD}mock-exam/CURRENT_QUESTION.md{RESET}")
    print(f"  2. Write your standard ANSI SQL query in {BOLD}mock-exam/submission.sql.txt{RESET}")
    print(f"  3. Test and unlock next level by running {BOLD}make grade{RESET}\n")


def reset_session():
    if state_file.exists():
        state_file.unlink()
    if current_q_file.exists():
        current_q_file.unlink()
    if submission_file.exists():
        submission_file.unlink()
    print(f"{GREEN}Exam session reset successfully! Run 'make exam' to start a new 42 exam run.{RESET}")


def main():
    if len(sys.argv) > 1:
        arg = sys.argv[1].lower()
        if arg in ["--start", "-s", "start"]:
            start_new_session()
            show_status()
        elif arg in ["--submit", "-g", "grade", "--grade"]:
            grade_current()
        elif arg in ["--status", "status"]:
            show_status()
        elif arg in ["--reset", "reset"]:
            reset_session()
        else:
            grade_current()
    else:
        state = load_state()
        if not state or state.get("completed"):
            start_new_session()
        show_status()


if __name__ == "__main__":
    main()
