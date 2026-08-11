#!/usr/bin/env python3
"""
Automated Grader for ISDA Mock SQL Examination (`isda-mock-exam`).
Evaluates student queries against ground-truth solution queries in `solutions/`.
Grades all 126 questions when invoked via `make grade-all`.
"""

import os
import sys
import subprocess
import csv
import io
from pathlib import Path

# Database credentials
DB_NAME = os.getenv("DB_NAME", "isda-mock-exam")
DB_USER = os.getenv("DB_USER", "postgres")
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_PASSWORD = os.getenv("DB_PASSWORD", "postgrespassword")
DOCKER_CONTAINER = os.getenv("DOCKER_CONTAINER", "postgres_db")

TOTAL_QUESTIONS = 126

# ANSI Colors
GREEN = "\033[92m"
RED = "\033[91m"
YELLOW = "\033[93m"
CYAN = "\033[96m"
BOLD = "\033[1m"
RESET = "\033[0m"

base_dir = Path(__file__).resolve().parent
answers_dir = base_dir / "answers"
solutions_dir = base_dir / "solutions"


def run_sql_query(sql_text: str):
    """Executes SQL against local psql first, falling back to Docker container execution."""
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
    """Parses CSV output into header list and row tuples."""
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
    """Normalizes numerical and string values for fuzzy equality."""
    val = val.strip()
    try:
        f_val = float(val)
        return f"{f_val:.4f}".rstrip('0').rstrip('.')
    except ValueError:
        return val.lower()


def compare_results(student_headers, student_rows, solution_headers, solution_rows):
    """Compares student output against solution output."""
    if len(student_headers) != len(solution_headers):
        return False, f"Column count mismatch. Expected {len(solution_headers)} ({', '.join(solution_headers)}), got {len(student_headers)} ({', '.join(student_headers)})"

    if len(student_rows) != len(solution_rows):
        return False, f"Row count mismatch. Expected {len(solution_rows)} rows, got {len(student_rows)} rows"

    norm_student = [[normalize_value(cell) for cell in row] for row in student_rows]
    norm_solution = [[normalize_value(cell) for cell in row] for row in solution_rows]

    if norm_student != norm_solution:
        sorted_student = sorted(norm_student)
        sorted_solution = sorted(norm_solution)
        if sorted_student == sorted_solution:
            return False, "Row content matches, but row ordering does NOT match required ORDER BY clause"
        return False, f"Data mismatch. Expected sample: {solution_rows[0] if solution_rows else '[]'}, Got: {student_rows[0] if student_rows else '[]'}"

    return True, "Passed!"


def get_topic_name(q_id: int) -> str:
    if 1 <= q_id <= 10 or 71 <= q_id <= 75 or 106 <= q_id <= 108:
        return "SELECT"
    elif 11 <= q_id <= 20 or 76 <= q_id <= 80 or 109 <= q_id <= 111:
        return "WHERE"
    elif 21 <= q_id <= 30 or 81 <= q_id <= 85 or 112 <= q_id <= 114:
        return "AGGREGATION"
    elif 31 <= q_id <= 40 or 86 <= q_id <= 90 or 115 <= q_id <= 117:
        return "GROUP BY"
    elif 41 <= q_id <= 50 or 91 <= q_id <= 95 or 118 <= q_id <= 120:
        return "JOIN"
    elif 51 <= q_id <= 60 or 96 <= q_id <= 100 or 121 <= q_id <= 123:
        return "HAVING"
    elif 61 <= q_id <= 70 or 101 <= q_id <= 105 or 124 <= q_id <= 126:
        return "SUBQUERY"
    return "MISC"


def grade_all():
    print(f"\n{BOLD}{CYAN}====================================================={RESET}")
    print(f"{BOLD}{CYAN}  ISDA MOCK SQL EXAM AUTOMATED GRADER ({TOTAL_QUESTIONS} QUESTIONS) {RESET}")
    print(f"{BOLD}{CYAN}====================================================={RESET}")
    print(f"Target Database: {BOLD}{DB_NAME}{RESET}\n")

    passed_count = 0
    failed_count = 0
    skipped_count = 0

    for i in range(1, TOTAL_QUESTIONS + 1):
        q_id = f"{i:02d}" if i < 100 else f"{i}"
        topic = get_topic_name(i)
        sol_file = solutions_dir / f"{q_id}.sql"
        ans_file = answers_dir / f"{q_id}.sql.txt"

        if not sol_file.exists():
            print(f"Question {q_id} [{topic}]: {RED}MISSING SOLUTION FILE{RESET}")
            failed_count += 1
            continue

        sol_sql = sol_file.read_text()
        sol_ok, sol_headers, sol_rows, sol_err = run_sql_query(sol_sql)
        if not sol_ok:
            print(f"Question {q_id} [{topic}]: {RED}SOLUTION QUERY ERROR ({sol_err}){RESET}")
            failed_count += 1
            continue

        if not ans_file.exists():
            print(f"Question {q_id} [{topic}]: {YELLOW}SKIPPED (No answer file){RESET}")
            skipped_count += 1
            continue

        student_sql = ans_file.read_text().strip()
        sql_lines = [line.strip() for line in student_sql.splitlines() if line.strip() and not line.strip().startswith("--")]
        if not sql_lines:
            print(f"Question {q_id} [{topic}]: {YELLOW}SKIPPED (File {q_id}.sql.txt is empty or unedited){RESET}")
            skipped_count += 1
            continue

        ans_ok, ans_headers, ans_rows, ans_err = run_sql_query(student_sql)
        if not ans_ok:
            print(f"Question {q_id} [{topic}]: {RED}FAILED (SQL Execution Error: {ans_err}){RESET}")
            failed_count += 1
            continue

        is_correct, msg = compare_results(ans_headers, ans_rows, sol_headers, sol_rows)

        if is_correct:
            print(f"Question {q_id} [{topic}]: {GREEN}PASSED ✓{RESET}")
            passed_count += 1
        else:
            print(f"Question {q_id} [{topic}]: {RED}FAILED ✗ ({msg}){RESET}")
            failed_count += 1

    print(f"\n-----------------------------------------------------")
    print(f"SUMMARY: Passed: {GREEN}{passed_count}{RESET} | Skipped: {YELLOW}{skipped_count}{RESET} | Failed: {RED}{failed_count}{RESET} | Total: {TOTAL_QUESTIONS}")
    pct = (passed_count / TOTAL_QUESTIONS) * 100
    print(f"FINAL SCORE: {passed_count} / {TOTAL_QUESTIONS} ({pct:.1f}%)")
    print(f"=====================================================\n")

    if failed_count > 0 or passed_count < TOTAL_QUESTIONS:
        sys.exit(1)


if __name__ == "__main__":
    grade_all()
