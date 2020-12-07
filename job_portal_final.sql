SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS selection;
DROP TABLE IF EXISTS application;
DROP TABLE IF EXISTS job;
DROP TABLE IF EXISTS seeker_category_join;
DROP TABLE IF EXISTS job_category;
DROP TABLE IF EXISTS job_seeker_education;
DROP TABLE IF EXISTS job_seeker_work_exp;
DROP TABLE IF EXISTS job_seeker_profile;
DROP TABLE IF EXISTS login;
DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS recruiter;




/* Create Tables */

CREATE TABLE application
(
	application_id int NOT NULL AUTO_INCREMENT,
	status enum('received','pending'),
	resume varchar(500),
	date_applied datetime,
	cv_form longblob,
	content_type varchar(100),
	file_name varchar(100),
	job_id int NOT NULL,
	jobseeker_id varchar(8) NOT NULL,
	PRIMARY KEY (application_id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE job
(
	job_id int NOT NULL AUTO_INCREMENT,
	job_title varchar(50),
	job_category varchar(50),
	gender enum('male','female','both'),
	age varchar(20),
	job_role varchar(50),
	skills_required varchar(100),
	job_qualification varchar(100),
	job_experience int,
	job_post int,
	salary int,
	job_location varchar(100),
	job_post_date date,
	job_open_date datetime,
	job_close_date date,
	job_description varchar(500),
	recruiter_id varchar(7) NOT NULL,
	id int NOT NULL,
	PRIMARY KEY (job_id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE job_category
(
	id int NOT NULL AUTO_INCREMENT,
	job_title varchar(50),
	PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE job_seeker_education
(
	education_id int NOT NULL AUTO_INCREMENT,
	institution_attended varchar(50),
	completion_date varchar(7),
	certification varchar(100),
	certification_file longblob,
	content_type varchar(100),
	file_name varchar(100),
	jobseeker_id varchar(8) NOT NULL,
	PRIMARY KEY (education_id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE job_seeker_profile
(
	jobseeker_id varchar(8) NOT NULL,
	name varchar(50) NOT NULL,
	email varchar(50) NOT NULL,
	phone varchar(20) NOT NULL,
	skills varchar(500),
	gender enum('male','female') NOT NULL,
	dob date NOT NULL,
	address varchar(100) NOT NULL,
	state enum('Yangon','Nay Pyi Taw','Mandalay') NOT NULL,
	postal_code int NOT NULL,
	status enum('activate','deactivate'),
	PRIMARY KEY (jobseeker_id),
	UNIQUE (email)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE job_seeker_work_exp
(
	exp_id int NOT NULL AUTO_INCREMENT,
	company_name varchar(100),
	role varchar(50),
	start_date date,
	end_date date,
	duration varchar(50),
	jobseeker_id varchar(8) NOT NULL,
	PRIMARY KEY (exp_id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE login
(
	login_id varchar(8) NOT NULL,
	username varchar(50) NOT NULL,
	email varchar(50) NOT NULL,
	password varchar(100) NOT NULL,
	PRIMARY KEY (login_id),
	UNIQUE (email)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE payment
(
	payment_id varchar(50) NOT NULL,
	recruiter_id varchar(7),
	plan enum('monthly','yearly'),
	start_date date,
	end_date date,
	amount float,
	discount float,
	PRIMARY KEY (payment_id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE recruiter
(
	recruiter_id varchar(7) NOT NULL,
	recruiter_name varchar(50),
	company_name varchar(50),
	company_license varchar(50),
	email varchar(50) NOT NULL,
	address varchar(100),
	state enum('Yangon','Nay Pyi Taw','Mandalay'),
	postal_code int,
	description varchar(100),
	status enum('activate','deactivate'),
	PRIMARY KEY (recruiter_id),
	UNIQUE (email)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE seeker_category_join
(
	jobseeker_id varchar(8) NOT NULL,
	id int NOT NULL,
	PRIMARY KEY (jobseeker_id, id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE selection
(
	application_id int NOT NULL,
	status enum('selected','cancel'),
	PRIMARY KEY (application_id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;



/* Create Foreign Keys */

ALTER TABLE selection
	ADD CONSTRAINT selection_ibfk_1 FOREIGN KEY (application_id)
	REFERENCES application (application_id)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
;


ALTER TABLE application
	ADD CONSTRAINT application_ibfk_1 FOREIGN KEY (job_id)
	REFERENCES job (job_id)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
;


ALTER TABLE job
	ADD CONSTRAINT job_ibfk_1 FOREIGN KEY (id)
	REFERENCES job_category (id)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
;


ALTER TABLE seeker_category_join
	ADD CONSTRAINT seeker_category_join_ibfk_1 FOREIGN KEY (id)
	REFERENCES job_category (id)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
;


ALTER TABLE application
	ADD CONSTRAINT application_ibfk_2 FOREIGN KEY (jobseeker_id)
	REFERENCES job_seeker_profile (jobseeker_id)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
;


ALTER TABLE job_seeker_education
	ADD CONSTRAINT job_seeker_education_ibfk_1 FOREIGN KEY (jobseeker_id)
	REFERENCES job_seeker_profile (jobseeker_id)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
;


ALTER TABLE job_seeker_work_exp
	ADD CONSTRAINT job_seeker_work_exp_ibfk_1 FOREIGN KEY (jobseeker_id)
	REFERENCES job_seeker_profile (jobseeker_id)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
;


ALTER TABLE seeker_category_join
	ADD CONSTRAINT seeker_category_join_ibfk_2 FOREIGN KEY (jobseeker_id)
	REFERENCES job_seeker_profile (jobseeker_id)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
;


ALTER TABLE job
	ADD CONSTRAINT job_ibfk_2 FOREIGN KEY (recruiter_id)
	REFERENCES recruiter (recruiter_id)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
;

