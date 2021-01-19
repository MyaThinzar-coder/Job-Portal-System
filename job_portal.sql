SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS application;
DROP TABLE IF EXISTS card;
DROP TABLE IF EXISTS selection;
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
	date_applied datetime,
	cv_form mediumblob,
	job_id int NOT NULL,
	jobseeker_id varchar(8) NOT NULL,
	recruiter_id varchar(7) NOT NULL,
	PRIMARY KEY (application_id)
);


CREATE TABLE card
(
	card_id int NOT NULL AUTO_INCREMENT,
	card_number varchar(16),
	voucher_no varchar(11) NOT NULL,
	PRIMARY KEY (card_id)
);


CREATE TABLE job
(
	job_id int NOT NULL AUTO_INCREMENT,
	job_title varchar(50),
	job_category varchar(50),
	gender enum('male','female'),
	age int,
	job_role varchar(50),
	skills_required varchar(100),
	job_qualification varchar(100),
	job_experience int,
	job_post int,
	expected_salary int,
	job_location varchar(100),
	job_post_date datetime,
	job_open_date datetime,
	job_close_date datetime,
	job_description varchar(500),
	recruiter_id varchar(7) NOT NULL,
	id int NOT NULL,
	PRIMARY KEY (job_id)
);


CREATE TABLE job_category
(
	id int NOT NULL AUTO_INCREMENT,
	job_title varchar(50),
	PRIMARY KEY (id)
);


CREATE TABLE job_seeker_education
(
	education_id int unsigned NOT NULL AUTO_INCREMENT,
	institution_attended varchar(50),
	completion_year year(4),
	certification varchar(100),
	certification_file mediumblob,
	jobseeker_id varchar(8) NOT NULL,
	PRIMARY KEY (education_id)
);


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
	PRIMARY KEY (jobseeker_id),
	UNIQUE (email)
);


CREATE TABLE job_seeker_work_exp
(
	exp_id int NOT NULL AUTO_INCREMENT,
	company_name varchar(100),
	role varchar(50),
	start_date date,
	end_date date,
	jobseeker_id varchar(8) NOT NULL,
	PRIMARY KEY (exp_id)
);


CREATE TABLE login
(
	login_id varchar(8) NOT NULL,
	username varchar(50) NOT NULL,
	email varchar(50) NOT NULL,
	password varchar(100) NOT NULL,
	PRIMARY KEY (login_id),
	UNIQUE (email)
);


CREATE TABLE payment
(
	voucher_no varchar(11) NOT NULL,
	payment_date date,
	payment_amt int,
	PRIMARY KEY (voucher_no)
);


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
	PRIMARY KEY (recruiter_id),
	UNIQUE (email)
);


CREATE TABLE seeker_category_join
(
	jobseeker_id varchar(8) NOT NULL,
	id int NOT NULL,
	PRIMARY KEY (jobseeker_id, id)
);


CREATE TABLE selection
(
	selection_id int NOT NULL AUTO_INCREMENT,
	status enum('selected','cancel'),
	jobseeker_id varchar(8) NOT NULL,
	recruiter_id varchar(7) NOT NULL,
	job_id int NOT NULL,
	PRIMARY KEY (selection_id)
);



/* Create Foreign Keys */

ALTER TABLE application
	ADD FOREIGN KEY (job_id)
	REFERENCES job (job_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE selection
	ADD FOREIGN KEY (job_id)
	REFERENCES job (job_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE job
	ADD FOREIGN KEY (id)
	REFERENCES job_category (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE seeker_category_join
	ADD FOREIGN KEY (id)
	REFERENCES job_category (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE application
	ADD FOREIGN KEY (jobseeker_id)
	REFERENCES job_seeker_profile (jobseeker_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE job_seeker_education
	ADD FOREIGN KEY (jobseeker_id)
	REFERENCES job_seeker_profile (jobseeker_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE job_seeker_work_exp
	ADD FOREIGN KEY (jobseeker_id)
	REFERENCES job_seeker_profile (jobseeker_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE seeker_category_join
	ADD FOREIGN KEY (jobseeker_id)
	REFERENCES job_seeker_profile (jobseeker_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE selection
	ADD FOREIGN KEY (jobseeker_id)
	REFERENCES job_seeker_profile (jobseeker_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE card
	ADD FOREIGN KEY (voucher_no)
	REFERENCES payment (voucher_no)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE application
	ADD FOREIGN KEY (recruiter_id)
	REFERENCES recruiter (recruiter_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE job
	ADD FOREIGN KEY (recruiter_id)
	REFERENCES recruiter (recruiter_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE selection
	ADD FOREIGN KEY (recruiter_id)
	REFERENCES recruiter (recruiter_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



