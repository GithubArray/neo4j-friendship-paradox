MATCH (person) DETACH DELETE person


// dataset 1
CREATE (a: Person {name: "A"}),
(b: Person {name: "B"}),
(c: Person {name: "C"}),
(d: Person {name: "D"}),
(e: Person {name: "E"}),
(a)-[:IS_FRIEND_OF]->(b),
(a)-[:IS_FRIEND_OF]->(c),
(b)-[:IS_FRIEND_OF]->(c),
(c)-[:IS_FRIEND_OF]->(d),
(c)-[:IS_FRIEND_OF]->(e),
(d)-[:IS_FRIEND_OF]->(e)

MATCH (person) RETURN person

// dataset 2
CREATE (a: Person {name: "A"}),
(b: Person {name: "B"}),
(c: Person {name: "C"}),
(d: Person {name: "D"}),
(e: Person {name: "E"}),
(f: Person {name: "F"}),
(a)-[:IS_FRIEND_OF]->(b),
(a)-[:IS_FRIEND_OF]->(c),
(b)-[:IS_FRIEND_OF]->(c),
(c)-[:IS_FRIEND_OF]->(d),
(c)-[:IS_FRIEND_OF]->(e),
(c)-[:IS_FRIEND_OF]->(f),
(d)-[:IS_FRIEND_OF]->(e),
(d)-[:IS_FRIEND_OF]->(f),
(e)-[:IS_FRIEND_OF]->(f)

MATCH (person) RETURN person

/////////////////////////////////////////////////////////////////////////////////////////////////


// list nodes and counts
MATCH (f1)-[r1]-(f2) 
WITH f1 , COUNT(r1) AS nf, f2
MATCH (f2)-[r2]-(f3)
WITH f1, nf, f2, COUNT(r2) AS nff
WITH f1, nf, f2, SUM(nff) AS nff
WITH f1, SUM(nf) AS nf, COLLECT(f2) AS f2, COLLECT(nff) AS nffList, SUM(nff) AS nff
RETURN f1, nf, f2, nffList, nff, size(nffList) AS s
ORDER BY f1

// calc avg
MATCH (f1)-[r1]-(f2) 
WITH f1 , COUNT(r1) AS nf, f2
MATCH (f2)-[r2]-(f3)
WITH f1, nf, f2, COUNT(r2) AS nff
WITH f1, nf, f2, SUM(nff) AS nff
WITH f1, SUM(nf) AS nf, COLLECT(f2) AS f2, COLLECT(nff) AS nffList, SUM(nff) AS nff
WITH f1, nf, f2, nffList, nff, size(nffList) AS s, COUNT(*) AS numRows
RETURN SUM(nf) * 1.0 / SUM(numRows) AS avgNumOfFriends, SUM(nff) * 1.0 / SUM(s) AS avgNumOfFriendsOfFriends
