SELECT number, frequency, operatorName
FROM Route
JOIN Operates
	ON Route.`number` = Operates.routeNumber
WHERE operatorName = "Diamond Buses";

SELECT bs.ID, bs.description
FROM BusStop bs
ORDER BY bs.ID DESC LIMIT 1;

SELECT name, phone
FROM Operator
LEFT JOIN Operates
	ON Operates.operatorName = Operator.name
LEFT JOIN Route
	ON Route.`number` = Operates.routeNumber
WHERE Route.`start` = 8000 OR Route.destination = 8000;

SELECT SUM(Route.frequency) * (Operates.proportion / 100) AS journeysPerHour
FROM Route, Operates
WHERE Route.`Number` = Operates.routeNumber
	AND Operates.operatorName = "Blue Belle";
	
SELECT DISTINCT description FROM BusStop bs
WHERE bs.ID NOT IN (SELECT ID FROM NearTo WHERE ID IS NOT NULL);

SELECT ID, COUNT(*) AS facilityCount
FROM NearTo nt
GROUP BY ID;

SELECT DISTINCT O.email FROM Operator O
	LEFT JOIN Operates os
		ON o.name = os.operatorName
	LEFT JOIN Route r
		ON os.routeNumber = r.`number`
	LEFT JOIN BusStop destination
		ON r.destination = destination.ID
	LEFT JOIN NearTo ntEnd
		ON destination.ID = ntEnd.ID
	LEFT JOIN BusStop beginning
		ON r.`start` = beginning.ID
	LEFT JOIN NearTo ntBeginning
		ON beginning.ID = ntBeginning.ID
WHERE ntEnd.facility LIKE "Bike Rack" OR ntBeginning.facility LIKE "Bike Rack"
ORDER BY email ASC;

SELECT bs.ID, bs.description FROM BusStop bs
	INNTER JOIN NearTo nt ON bs.ID = nt.ID
WHERE bs.ID
	IN (SELECT r.`start` FROM Route r WHERE r.`number`
	IN (SELECT o.routeNumber FROM Operates o WHERE o.operatorName = "Bond Brothers") 
UNION ALL 
	SELECT r.destination FROM Route r WHERE r.`number`
	IN (SELECT o.routeNumber FROM Operates o WHERE o.operatorName = "Bond Brothers")) 
AND nt.facility = "Cashpoint";

SELECT COUNT(DISTINCT r.`start`) AS `Bus Count`
FROM Route r
WHERE r.`start` NOT IN (SELECT destination FROM Route);

SELECT o.operatorName AS `Operator Name`,
	COUNT(DISTINCT bs.ID) AS `Stops Served`
FROM Operates o, Route r, BusStop bs
WHERE o.routeNumber = r.`number`
	AND (bs.ID = r.`start` OR bs.ID = r.destination) 
GROUP BY o.operatorName
HAVING COUNT(DISTINCT bs.ID) > 4;