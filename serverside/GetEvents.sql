-- Stored procedure skeleton. Write your code here and then submit to Brightspace.

DELIMITER //

CREATE PROCEDURE GetEvents (IN p_id int)

BEGIN

	DROP TABLE IF EXISTS GetEvents;

	CREATE TABLE GetEvents (event_id int,date datetime,host_id int,room_id int,event_title varchar(30),details varchar(30), invited_count int, accepted_count int, cancel int);

	INSERT INTO GetEvents
	(SELECT * FROM events WHERE host_id = p_id);
END //
DELIMITER ;
