--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Day_plan; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Day_plan" (
    destination character varying NOT NULL,
    name character varying NOT NULL,
    user_email character varying NOT NULL
);


ALTER TABLE "Day_plan" OWNER TO postgres;

--
-- Name: Email; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Email" (
    id integer NOT NULL,
    date date,
    message character varying,
    sender character varying
);


ALTER TABLE "Email" OWNER TO postgres;

--
-- Name: Favors; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Favors" (
    user_email character varying,
    longitude double precision,
    latitude double precision,
    place_name character varying
);


ALTER TABLE "Favors" OWNER TO postgres;

--
-- Name: Follow; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Follow" (
    is_approved boolean,
    follower character varying,
    followee character varying
);


ALTER TABLE "Follow" OWNER TO postgres;

--
-- Name: LANDMARK; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "LANDMARK" (
    name character varying,
    longitude integer,
    latitude integer
);


ALTER TABLE "LANDMARK" OWNER TO postgres;

--
-- Name: Museum; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Museum" (
    name character varying,
    longitude integer,
    latitude integer,
    current_exhibition character varying
);


ALTER TABLE "Museum" OWNER TO postgres;

--
-- Name: Place; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Place" (
    rating integer,
    opening_hour integer,
    longitude double precision NOT NULL,
    latitude double precision NOT NULL,
    name character varying NOT NULL,
    CONSTRAINT "Place_rating_check" CHECK (((rating >= 0) AND (rating <= 5)))
);


ALTER TABLE "Place" OWNER TO postgres;

--
-- Name: References; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "References" (
    sequence_nr integer,
    day_plan_name character varying,
    place_name character varying,
    longitude double precision,
    latitude double precision,
    user_email character varying NOT NULL,
    destination character varying
);


ALTER TABLE "References" OWNER TO postgres;

--
-- Name: Trip; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Trip" (
    destination character varying NOT NULL,
    start_date date,
    end_date date,
    user_email character varying NOT NULL
);


ALTER TABLE "Trip" OWNER TO postgres;

--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "User" (
    email_adress character varying NOT NULL,
    email_id integer,
    destination_name character varying
);


ALTER TABLE "User" OWNER TO postgres;

--
-- Name: trip; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE trip (
    destination character varying NOT NULL,
    start_date date,
    end_date date
);


ALTER TABLE trip OWNER TO postgres;

--
-- Data for Name: Day_plan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Day_plan" (destination, name, user_email) FROM stdin;
\.


--
-- Data for Name: Email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Email" (id, date, message, sender) FROM stdin;
\.


--
-- Data for Name: Favors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Favors" (user_email, longitude, latitude, place_name) FROM stdin;
\.


--
-- Data for Name: Follow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Follow" (is_approved, follower, followee) FROM stdin;
\.


--
-- Data for Name: LANDMARK; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "LANDMARK" (name, longitude, latitude) FROM stdin;
\.


--
-- Data for Name: Museum; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Museum" (name, longitude, latitude, current_exhibition) FROM stdin;
\.


--
-- Data for Name: Place; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Place" (rating, opening_hour, longitude, latitude, name) FROM stdin;
\.


--
-- Data for Name: References; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "References" (sequence_nr, day_plan_name, place_name, longitude, latitude, user_email, destination) FROM stdin;
\.


--
-- Data for Name: Trip; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Trip" (destination, start_date, end_date, user_email) FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "User" (email_adress, email_id, destination_name) FROM stdin;
\.


--
-- Data for Name: trip; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY trip (destination, start_date, end_date) FROM stdin;
\.


--
-- Name: Day_plan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Day_plan"
    ADD CONSTRAINT "Day_plan_pkey" PRIMARY KEY (destination, user_email, name);


--
-- Name: Email_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Email"
    ADD CONSTRAINT "Email_pkey" PRIMARY KEY (id);


--
-- Name: Place_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Place"
    ADD CONSTRAINT "Place_pkey" PRIMARY KEY (longitude, latitude, name);


--
-- Name: Trip_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Trip"
    ADD CONSTRAINT "Trip_pkey" PRIMARY KEY (user_email, destination);


--
-- Name: User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (email_adress);


--
-- Name: trip_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY trip
    ADD CONSTRAINT trip_pkey PRIMARY KEY (destination);


--
-- Name: Day_plan_destination_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Day_plan"
    ADD CONSTRAINT "Day_plan_destination_fkey" FOREIGN KEY (destination, user_email) REFERENCES "Trip"(user_email, destination);


--
-- Name: Favors_longitude_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Favors"
    ADD CONSTRAINT "Favors_longitude_fkey" FOREIGN KEY (longitude, latitude, place_name) REFERENCES "Place"(longitude, latitude, name);


--
-- Name: Favors_user_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Favors"
    ADD CONSTRAINT "Favors_user_email_fkey" FOREIGN KEY (user_email) REFERENCES "User"(email_adress);


--
-- Name: Follow_followee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Follow"
    ADD CONSTRAINT "Follow_followee_fkey" FOREIGN KEY (followee) REFERENCES "User"(email_adress);


--
-- Name: Follow_follower_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Follow"
    ADD CONSTRAINT "Follow_follower_fkey" FOREIGN KEY (follower) REFERENCES "User"(email_adress);


--
-- Name: LANDMARK_longitude_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "LANDMARK"
    ADD CONSTRAINT "LANDMARK_longitude_fkey" FOREIGN KEY (longitude, latitude, name) REFERENCES "Place"(longitude, latitude, name);


--
-- Name: Museum_longitude_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Museum"
    ADD CONSTRAINT "Museum_longitude_fkey" FOREIGN KEY (longitude, latitude, name) REFERENCES "Place"(longitude, latitude, name);


--
-- Name: References_day_plan_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "References"
    ADD CONSTRAINT "References_day_plan_name_fkey" FOREIGN KEY (day_plan_name, user_email, destination) REFERENCES "Day_plan"(name, destination, user_email);


--
-- Name: References_longitude_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "References"
    ADD CONSTRAINT "References_longitude_fkey" FOREIGN KEY (longitude, latitude, place_name) REFERENCES "Place"(longitude, latitude, name);


--
-- Name: Trip_user_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Trip"
    ADD CONSTRAINT "Trip_user_email_fkey" FOREIGN KEY (user_email) REFERENCES "User"(email_adress);


--
-- Name: User_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "User"
    ADD CONSTRAINT "User_email_id_fkey" FOREIGN KEY (email_id) REFERENCES "Email"(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

