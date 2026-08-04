-- PostgreSQL Table Creation Script
-- Converted from Oracle SQL (.sql)

CREATE TABLE administration (
    admin_nr INT,
    pres_name VARCHAR(30),
    year_inaugurated INT,
    CONSTRAINT administration_con UNIQUE (admin_nr, pres_name, year_inaugurated)
);

CREATE TABLE admin_pr_vp (
    admin_nr INT,
    pres_name VARCHAR(30),
    vice_pres_name VARCHAR(30),
    CONSTRAINT admin_pr_vp_con UNIQUE (admin_nr, pres_name, vice_pres_name)
);

CREATE TABLE election (
    election_year INT,
    candidate VARCHAR(30),
    votes INT,
    winner_loser_indic VARCHAR(15),
    CONSTRAINT election_con UNIQUE (election_year, candidate)
);

CREATE TABLE president (
    pres_name VARCHAR(30),
    birth_yr INT,
    yrs_serv INT,
    death_age INT,
    party VARCHAR(30),
    state_born VARCHAR(30),
    CONSTRAINT president_pk PRIMARY KEY (pres_name)
);

CREATE TABLE pres_hobby (
    pres_name VARCHAR(30),
    hobby VARCHAR(30),
    CONSTRAINT pres_hobby_con UNIQUE (pres_name, hobby)
);

CREATE TABLE pres_marriage (
    pres_name VARCHAR(30),
    spouse_name VARCHAR(30),
    pr_age INT,
    sp_age INT,
    nr_children INT,
    mar_year INT,
    CONSTRAINT pres_marriage_con UNIQUE (pres_name, spouse_name)
);

CREATE TABLE state (
    state_name VARCHAR(30),
    admin_entered INT,
    year_entered INT,
    CONSTRAINT state_pk PRIMARY KEY (state_name)
);
