-- Course table
CREATE TABLE course (
    course_id TEXT PRIMARY KEY,
    name TEXT,
    semester TEXT,
    academic_year TEXT,
    faculty TEXT
);

-- Session Type table
CREATE TABLE session_type (
    type_id TEXT PRIMARY KEY,
    name TEXT,
    code TEXT,
    is_mandatory BOOLEAN,
    max_absences INTEGER
);

-- Course Session Type table
CREATE TABLE course_session_type (
    course_session_type_id TEXT PRIMARY KEY,
    course_id TEXT REFERENCES course(course_id),
    type_id TEXT REFERENCES session_type(type_id),
    semester TEXT,
    max_absences INTEGER
);

-- Teacher table
CREATE TABLE teacher (
    teacher_id TEXT PRIMARY KEY,
    user_id UUID,
    name TEXT,
    department TEXT,
    email TEXT
);

-- Session table
CREATE TABLE session (
    session_id TEXT PRIMARY KEY,
    course_session_type_id TEXT REFERENCES course_session_type(course_session_type_id),
    teacher_id TEXT REFERENCES teacher(teacher_id),
    location TEXT,
    group_id TEXT,
    scheduled_time TIMESTAMP WITHOUT TIME ZONE,
    duration INTERVAL,
    qr_code_validity_duration INTERVAL,
    is_active BOOLEAN
);

-- QR Code table
CREATE TABLE qr_code (
    qr_id TEXT PRIMARY KEY,
    session_id TEXT REFERENCES session(session_id),
    generated_time TIMESTAMP WITHOUT TIME ZONE,
    validity_duration INTERVAL
);

-- Student table
CREATE TABLE student (
    student_id TEXT PRIMARY KEY,
    user_id UUID,
    name TEXT,
    group_name TEXT,
    faculty TEXT,
    specialty TEXT,
    year INTEGER
);

-- Attendance Record table
CREATE TABLE attendance_record (
    record_id TEXT PRIMARY KEY,
    session_id TEXT REFERENCES session(session_id),
    student_id TEXT REFERENCES student(student_id),
    status TEXT,
    timestamp TIMESTAMP WITHOUT TIME ZONE,
    is_late_arrival BOOLEAN
);

-- Student Session Type Stats table
CREATE TABLE student_session_type_stats (
    stat_id TEXT PRIMARY KEY,
    student_id TEXT REFERENCES student(student_id),
    course_session_type_id TEXT REFERENCES course_session_type(course_session_type_id),
    total_sessions INTEGER,
    total_present INTEGER,
    total_absent INTEGER,
    justified_absences INTEGER,
    unjustified_absences INTEGER
);

-- Administration table
CREATE TABLE administration (
    admin_id TEXT PRIMARY KEY,
    user_id UUID,
    name TEXT,
    department TEXT,
    role TEXT,
    email TEXT
);