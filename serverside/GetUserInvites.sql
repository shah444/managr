-- Stored procedure skeleton. Write your code here and then submit to Brightspace.

DELIMITER //

CREATE PROCEDURE GetUserInvites (IN p_id int)

BEGIN

	DROP TABLE IF EXISTS GetUserInvites;

	CREATE TABLE GetUserInvites (event_id int,person_id int,attending int, email varchar(30),event_title varchar(30),details varchar(30),room_id int, date datetime, building varchar(30), room varchar(30));

	INSERT INTO GetUserInvites
	(SELECT rsvp.event_id, rsvp.person_id, rsvp.attending, invitelist.email, invitelist.event_title, events.details, events.room_id, events.date, rooms.building, rooms.room FROM invitelist natural join rsvp join events on (rsvp.event_id=events.event_id) join rooms ON (events.room_id=rooms.room_id) WHERE person_id = p_id);
END //
DELIMITER ;
