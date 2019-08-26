/*
Point Breakdown:
+1.75 for tables
+1.25 for primary keys
+2 for foreign keys
+6.4 for columns
+1 for rating check
*/

/*
Email must come after "user" since it references it
Get rid of commas between columns and their types
*/
CREATE TABLE email (
  id, INT NOT NULL,
  send_date, DATE,
  message, VARCHAR,
  sender, VARCHAR NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(sender) REFERENCES "user"(email_adress)
);

-- Don't need these -> ALTER TABLE "email" OWNER TO postgres;

/*
You don't need foreign keys for user since it is on the 1 side of 1:N relationship
User is postgreSQL command, so you "user", to tell postgres that user should be a table name
*/
CREATE TABLE user (
  email_adress, VARCHAR NOT NULL,
  --email_id, INT,
  --destination_name, VARCHAR,
  PRIMARY KEY(email_adress),
  --FOREIGN KEY(email_id) REFERENCES "email"(id),
  --FOREIGN KEY(destination_name) REFERENCES "trip"(destination)
);

ALTER TABLE "user" OWNER TO postgres;


CREATE TABLE trip(
  destination, VARCHAR NOT NULL,
  start_date, DATE,
  end_date, DATE,
  user_email, VARCHAR NOT NULL,
  PRIMARY KEY(user_email, destination),
  FOREIGN KEY(user_email) REFERENCES "user"(email_adress)
);



ALTER TABLE "trip" OWNER TO postgres;

-- Missing date attribute
CREATE TABLE day_plan (
  destination, VARCHAR NOT NULL,
  name, VARCHAR NOT NULL,
  user_email, VARCHAR NOT NULL,
  PRIMARY KEY(destination, name, user_email),
  FOREIGN KEY(destination, user_email) REFERENCES "trip"(destination, user_email)
);

ALTER TABLE "day_plan" OWNER TO postgres;

/*
Specify primary key
*/
CREATE TABLE favor (
  user_email, VARCHAR,
  longitude, FLOAT,
  latitude, FLOAT,
  place_name, VARCHAR,
  FOREIGN KEY(user_email) REFERENCES "user"(email_adress),
  FOREIGN KEY(longitude, latitude, place_name) REFERENCES "place"(longitude, latitude, name)
);

ALTER TABLE "favor" OWNER TO postgres;

/*
You need to specify the primary key for table
*/
CREATE TABLE follow(
  is_approved, BOOLEAN,
  follower, VARCHAR NOT NULL,
  followee, VARCHAR NOT NULL,
  --PRIMARY KEY (follower, followee),
  FOREIGN KEY(followee) REFERENCES "user"(email_adress),
  FOREIGN KEY(follower) REFERENCES "user"(email_adress)
);

ALTER TABLE "follow" OWNER TO postgres;

/*
Table should be merged with place
*/
CREATE TABLE landmark(
  place_name, VARCHAR NOT NULL,
  longitude, FLOAT NOT NULL,
  latitude, FLOAT NOT NULL,
  FOREIGN KEY(longitude, latitude, place_name) REFERENCES "place"(longitude, latitude, name)
);

ALTER TABLE "landmark" OWNER TO postgres;

/*
Table should be merged with place
*/
CREATE TABLE museum(
  place_name, VARCHAR NOT NULL,
  longitude, FLOAT NOT NULL,
  latitude, FLOAT NOT NULL,
  exhibition, VARCHAR,
  FOREIGN KEY(longitude, latitude, place_name) REFERENCES "place"(longitude, latitude, name)
);

ALTER TABLE "museum" OWNER TO postgres;

/*
Museum and landmark should be merged with places. You should add a 
type column to places to distinguish between landmark/museum. Also add 
museums local attributes to place 
*/
CREATE TABLE place(
  rating, INT,
  opening_hour, INT,
  longitude, FLOAT NOT NULL,
  latitude, FLOAT NOT NULL,
  name, VARCHAR NOT NULL,
  PRIMARY KEY(longitude, latitude, name),
  CONSTRAINT "Place_rating_check" CHECK (((rating >= 0) AND (rating <= 5)))
);

ALTER TABLE "place" OWNER TO postgres;

/*
Specify primary key
*/
CREATE TABLE reference(
  sequence_nr, INT,
  day_plan_name, VARCHAR,
  place_name, VARCHAR,
  longitude, FLOAT,
  latitude, FLOAT,
  user_email, VARCHAR NOT NULL,
  destination, VARCHAR,
  FOREIGN KEY(day_plan_name, user_email, destination) REFERENCES "day_plan"(name, user_email, destination),
  FOREIGN KEY(longitude, latitude, place_name) REFERENCES "place"(longitude, latitude, name)
);
ALTER TABLE "reference" OWNER TO postgres;
