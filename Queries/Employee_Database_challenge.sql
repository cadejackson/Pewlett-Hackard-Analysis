-- Deliverable 1: The Number of Retiring Employees by Title
SELECT e.emp_no,
	   e.first_name,
	   e.last_name,
	   t.title,
	   t.from_date,
	   t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no

-- Deliverable 1***: The Number of Retiring Employees by Title (More efficient way to solve the problem)
SELECT COUNT(e.emp_no) AS count_emp_no,
	   t.title
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (t.to_date = '9999-01-01')
GROUP BY t.title
ORDER BY count_emp_no DESC 

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
				   first_name,
				   last_name,
				   title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Count number of employees retiring by title
SELECT COUNT(emp_no) AS count_emp_no,
	   title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC

-- Deliverable 2: Employees Eligible for Mentorship
SELECT DISTINCT ON (e.emp_no) e.emp_no,
				   e.first_name,
				   e.last_name,
				   e.birth_date,
				   de.from_date,
				   de.to_date,
				   t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no

-- Count of Mentorship Eligibility by Title
SELECT COUNT(emp_no) AS count_emp_no,
			title
FROM mentorship_eligibility
GROUP BY title
ORDER BY count_emp_no DESC

-- New hires
SELECT COUNT(e.emp_no) AS count_emp_no,
			t.title	
FROM employees AS e
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
WHERE (de.from_date BETWEEN '2002-01-01' AND '2002-12-31') AND (de.to_date = '9999-01-01')
GROUP BY  t.title
ORDER BY COUNT(e.emp_no) DESC;

-- Get number of current managers
SELECT COUNT(emp_no)
FROM titles
WHERE title = 'Manager' AND to_date = '9999-01-01'

-- Get number of current employees
SELECT COUNT(emp_no)
FROM titles
WHERE to_date = '9999-01-01'
