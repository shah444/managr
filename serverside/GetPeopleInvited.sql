-- Stored procedure skeleton. Write your code here and then submit to Brightspace.

DELIMITER //

CREATE PROCEDURE GetPeopleInvited (IN ev_id int)

BEGIN

	DROP TABLE IF EXISTS GetPeopleInvited;

	CREATE TABLE GetPeopleInvited (event_id int,person_id int,event_title varchar(30),email varchar(30),attending int);

	INSERT INTO GetPeopleInvited
	(SELECT * FROM invitelist natural join rsvp WHERE event_id = ev_id);
END //
DELIMITER ;
