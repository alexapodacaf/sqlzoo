/* SELECT basics */
/* 1 */
SELECT population FROM world
WHERE name = 'Germany';

/* 2 */
SELECT name, population FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');

/* 3 */
SELECT name, area FROM world
WHERE area BETWEEN 200000 AND 250000

/**********************************************************************/
/* SELECT FROM world tutorial */

/* 1 */
/* Read the notes about this table. Observe the result of running this SQL command to show the name, continent and population of all countries. */

SELECT name, continent, population FROM world

/* 2 */
/* How to use WHERE to filter records. Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros. */

SELECT name FROM world
WHERE population >= 200000000;

/* 3 */
/* Give the name and the per capita GDP for those countries with a population of at least 200 million.
HELP:How to calculate per capita GDP
per capita GDP is the GDP divided by the population GDP/population */

SELECT name, gdp/population FROM world
WHERE population >= 200000000;

/* 4 */
/* Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions. */
SELECT name, population/1000000 FROM world
WHERE continent = 'South America';

/* 5 */
/* Show the name and population for France, Germany, Italy */

SELECT name, population FROM world
WHERE name IN ('France', 'Germany', 'Italy');

/* 6 */
/* Show the countries which have a name that includes the word 'United' */

SELECT name FROM world
WHERE name LIKE '%United%';

/* 7 */
/* Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.
Show the countries that are big by area or big by population. Show name, population and area. */

SELECT name, population, area
FROM world
WHERE area > 3000000 OR population > 250000000;

/* 8 */
/* Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.
Australia has a big area but a small population, it should be included.
Indonesia has a big population but a small area, it should be included.
China has a big population and big area, it should be excluded.
United Kingdom has a small population and a small area, it should be excluded. */

SELECT name, population, area
FROM world
WHERE area > 3000000 XOR population > 250000000;

/* 9 */
/* Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.  For South America show population in millions and GDP in billions both to 2 decimal places.
Millions and billions.  Divide by 1000000 (6 zeros) for millions. Divide by 1000000000 (9 zeros) for billions. */

SELECT name, ROUND(population/1000000, 2), ROUND(GDP/1000000000, 2)
FROM world
WHERE continent = 'South America';

/* 10 */
/* Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.
Show per-capita GDP for the trillion dollar countries to the nearest $1000. */

SELECT name, ROUND(gdp/population, -3)
FROM world
WHERE GDP >= 1000000000000;

/* 11 */
/* Greece has capital Athens.
Each of the strings 'Greece', and 'Athens' has 6 characters.
Show the name and capital where the name and the capital have the same number of characters.
You can use the LENGTH function to find the number of characters in a string */

SELECT name, capital
FROM world
WHERE LENGTH(name) = LENGTH(capital);

/* 12 */
/* The capital of Sweden is Stockholm. Both words start with the letter 'S'.  Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
You can use the function LEFT to isolate the first character.
You can use <> as the NOT EQUALS operator. */

SELECT name, capital
FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1) AND name <> capital;

/* 13 */
/* Equatorial Guinea and Dominican Republic have all of the vowels (a e i o u) in the name. They don't count because they have more than one word in the name.
Find the country that has all the vowels and no spaces in its name.You can use the phrase name NOT LIKE '%a%' to exclude characters from your results.
The query shown misses countries like Bahamas and Belarus because they contain at least one 'a' */

SELECT name
FROM world
WHERE name LIKE '%a%'
AND name LIKE '%e%'
AND name LIKE '%i%'
AND name LIKE '%o%'
AND name LIKE '%u%'
AND name NOT LIKE '% %';

/**********************************************************************/
/* SELECT FROM nobel */

/* 1 */
/* Change the query shown so that it displays Nobel prizes for 1950. */

SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950

/* 2 */
/* Show who won the 1962 prize for Literature. */

SELECT winner
FROM nobel
WHERE yr = 1962
AND subject = 'Literature'

/* 3 */
/* Show the year and subject that won 'Albert Einstein' his prize. */

SELECT yr, subject 
FROM nobel
WHERE winner LIKE '% Einstein';

/* 4 */
/* Give the name of the 'Peace' winners since the year 2000, including 2000. */

SELECT winner
FROM nobel
WHERE yr >= 2000 AND subject = 'Peace';

/* 5 */
/* Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive. */

SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Literature' AND yr BETWEEN 1980 AND 1989;

/* 6 */
/* Show all details of the presidential winners:

Theodore Roosevelt
Woodrow Wilson
Jimmy Carter
Barack Obama */

SELECT * FROM nobel
WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama');

/* 7 */
/* Show the winners with first name John */

SELECT winner
FROM nobel
WHERE winner LIKE 'John%';

/* 8 */
/* Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984. */

SELECT *
FROM nobel
WHERE (subject = 'Physics' AND yr = 1980) OR (subject = 'Chemistry' AND yr = 1984);

/* 9 */
/* Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine */

SELECT *
FROM nobel
WHERE yr = 1980 AND subject NOT IN ('Chemistry','Medicine');

/* 10 */
/* Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004) */

SELECT *
FROM nobel
WHERE (subject = 'Medicine' AND yr < 1910) OR (subject = 'Literature' AND yr >= 2004);

/* 11 */
/* Find all details of the prize won by PETER GRÜNBERG */

SELECT *
FROM nobel
WHERE winner = 'PETER GRÜNBERG';

/* 12 */
/* Find all details of the prize won by EUGENE O'NEILL
Escaping single quotes
You can't put a single quote in a quote string directly. You can use two single quotes within a quoted string. */

SELECT *
FROM nobel
WHERE winner = 'EUGENE O''NEILL'

/* 13 */
/* List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order. */

SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE('Sir %')
ORDER BY yr DESC, winner ASC;

/* 14 */
/* The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.
Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last. */

SELECT winner, subject 
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Physics','Chemistry'),subject,winner

/**********************************************************************/
/* SELECT within SELECT */

/* 1 */
/* List each country name where the population is larger than that of 'Russia'. 
world(name, continent, area, population, gdp)*/

SELECT name FROM world
WHERE population >  (SELECT population FROM world WHERE name='Russia')

/* 2 */
/* Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
Per Capita GDP
The per capita GDP is the gdp/population */

SELECT name
FROM world
WHERE continent = 'Europe' AND gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom');

/* 3 */
/* List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country. */

SELECT name, continent
FROM world
WHERE continent IN ('South America', 'Oceania')
ORDER BY name;

/* 4 */
/* Which country has a population that is more than Canada but less than Poland? Show the name and the population. */

SELECT name, population
FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland');

/* 5 */
/* Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.
Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

The format should be Name, Percentage for example:
name	percentage
Albania	3%
Andorra	0%
Austria	11%
...	...
Decimal places
You can use the function ROUND to remove the decimal places.
Percent symbol %
You can use the function CONCAT to add the percentage symbol. 

We can use the word ALL to allow >= or > or < or <=to act over a list. For example, you can find the largest country in the world, by population with this query:

SELECT name
  FROM world
 WHERE population >= ALL(SELECT population
                           FROM world
                          WHERE population>0)
You need the condition population>0 in the sub-query as some countries have null for population.*/

SELECT name, CONCAT(ROUND((population*100)/(SELECT population FROM world WHERE name = 'Germany'),0),'%') AS percentage
FROM world
WHERE continent = 'Europe';

/* 6 */
/* Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values) */

SELECT name  
FROM world  
WHERE gdp > ALL (SELECT gdp FROM world WHERE continent ='Europe' AND gdp > 0);

/* 7 */
/* Find the largest country (by area) in each continent, show the continent, the name and the area: */

SELECT continent, name, area
FROM world x
WHERE area >= ALL(SELECT area FROM world y WHERE y.continent = x.continent AND area > 0);

/* 8 */
/* List each continent and the name of the country that comes first alphabetically. */

SELECT continent, MIN(name)
FROM world x
WHERE name <= ALL(SELECT name FROM world y WHERE y.continent =  x.continent AND name > 0) GROUP BY continent;

/* 9 */
/* Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population. */

SELECT x.name, x.continent, x.population
FROM world x
WHERE NOT EXISTS(SELECT population FROM world y WHERE x.continent = y.continent AND population > 25000000);


/* 10 */
/* Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents. */

SELECT x.name, x.continent
FROM world x
WHERE population/3 >= ALL(SELECT population FROM world y WHERE x.continent = y.continent AND x.name <> y.name);

/**********************************************************************/
/* SUM and COUNT */
/* This tutorial is about aggregate functions such as COUNT, SUM and AVG. An aggregate function takes many values and delivers just one value. For example the function SUM would aggregate the values 2, 4 and 5 to deliver the single value 11. */

/* 1 */
/* Show the total population of the world.
world(name, continent, area, population, gdp) */

SELECT SUM(population)
FROM world

/* 2 */
/* List all the continents - just once each. */

SELECT DISTINCT continent FROM world;

/* 3 */
/* Give the total GDP of Africa */

SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa';

/* 4 */
/* How many countries have an area of at least 1000000 */

SELECT count(name)
FROM world
WHERE area >= 1000000;

/* 5 */
/* What is the total population of ('Estonia', 'Latvia', 'Lithuania') */

SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

/* 6 */
/* For each continent show the continent and number of countries. */

SELECT continent, COUNT(name)
FROM world x
GROUP BY continent;

/* 7 */
/* For each continent show the continent and number of countries with populations of at least 10 million. */
SELECT continent, COUNT(name)
FROM world
WHERE population >= 10000000
GROUP BY continent;

/* 8 */
/* List the continents that have a total population of at least 100 million. */
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >=100000000;

/**********************************************************************/
/* JOIN */
/* This tutorial introduces JOIN which allows you to use data from two or more tables. The tables contain all matches and goals from UEFA EURO 2012 Football Championship in Poland and Ukraine.

The data is available (mysql format) at http://sqlzoo.net/euro2012.sql */

/* 1 */
/* The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime

Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER' */

SELECT matchid, player FROM goal 
WHERE teamid LIKE 'Ger%'

/* 2 */
/* From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.
Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.
Show id, stadium, team1, team2 for just game 1012 */

/* 3 */
/* You can combine the two steps into a single query with a JOIN.

SELECT *
  FROM game JOIN goal ON (id=matchid)
The FROM clause says to merge data from the goal table with that from the game table. The ON says how to figure out which rows in game go with which rows in goal - the matchid from goal must match id from game. (If we wanted to be more clear/specific we could say
ON (game.id=goal.matchid)

The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.

Modify it to show the player, teamid, stadium and mdate for every German goal. */

SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (id=matchid) WHERE teamid LIKE 'GER';

/* 4 */
/* Use the same JOIN as in the previous question.

Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%' */

SELECT team1, team2, player
FROM goal JOIN game ON (id=matchid)
WHERE player LIKE 'Mario%';

/* 5 */
/* The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id
Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10 */

SELECT player, teamid, coach, gtime
FROM goal
JOIN eteam ON teamid = id 
WHERE gtime<=10

/* 6 */
/* To JOIN game with eteam you could use either
game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)

Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id
List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.  */

SELECT game.mdate, eteam.teamname
FROM game
JOIN eteam ON team1=eteam.id
WHERE eteam.coach = 'Fernando Santos';

/* 7 */
/* List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw' */

SELECT goal.player
FROM goal
JOIN game ON game.id = goal.matchid
WHERE game.stadium = 'National Stadium, Warsaw';

/* 8 */
/* The example query shows all goals scored in the Germany-Greece quarterfinal.
Instead show the name of all players who scored a goal against Germany.

HINT
Select goals scored only by non-German players in matches where GER was the id of either team1 or team2.
You can use teamid!='GER' to prevent listing German players.
You can use DISTINCT to stop players being listed twice. */

SELECT DISTINCT player
FROM game JOIN goal ON matchid = id 
WHERE (team1='GER' OR team2 = 'GER') AND teamid <> 'GER';

/* 9 */
/* Show teamname and the total number of goals scored.
COUNT and GROUP BY
You should COUNT(*) in the SELECT line and GROUP BY teamname */

SELECT teamname, COUNT(goal.teamid)
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname
ORDER BY teamname

/* 10 */
/* Show the stadium and the number of goals scored in each stadium. */

SELECT game.stadium, COUNT(goal.teamid)
FROM game
JOIN goal ON game.id = goal.matchid
GROUP BY game.stadium;

/* 11 */
/* For every match involving 'POL', show the matchid, date and the number of goals scored. */

SELECT matchid,mdate, COUNT(teamid)
FROM game JOIN goal ON matchid = id 
WHERE (team1 = 'POL' OR team2 = 'POL') GROUP BY matchid, mdate;

/* 12 */
/* For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER' */

SELECT matchid, mdate, COUNT(teamid)
FROM game JOIN goal ON matchid = id
WHERE (team1 = 'GER' OR team2 = 'GER') AND teamid = 'GER'
GROUP BY matchid, mdate;

/* 13 */
/* List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
mdate	team1	score1	team2	score2
1 July 2012	ESP	4	ITA	0
10 June 2012	ESP	1	ITA	1
10 June 2012	IRL	1	CRO	3
...
Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2. */

SELECT mdate,team1, SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1, team2,
SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM game LEFT JOIN goal ON matchid = id 
GROUP BY mdate,matchid,team1,team2;

/**********************************************************************/
/* more JOIN */
/* This tutorial introduces the notion of a join. The database consists of three tables movie , actor and casting */

/* 1 */
/* List the films where the yr is 1962 [Show id, title] */

SELECT id, title
FROM movie
WHERE yr=1962

/* 2 */
/* Give year of 'Citizen Kane'. */

SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

/* 3 */
/* List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year. */

SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr;

/* 4 */
/* What id number does the actor 'Glenn Close' have? */

SELECT id
FROM actor
WHERE name = 'Glenn Close';

/* 5 */
/* What is the id of the film 'Casablanca' */

SELECT id
FROM movie
WHERE title = 'Casablanca';

/* 6 */
/* Obtain the cast list for 'Casablanca'.
what is a cast list?
The cast list is the names of the actors who were in the movie.
Use movieid=11768, (or whatever value you got from the previous question) */

SELECT name
FROM actor
JOIN casting ON casting.actorid = actor.id
WHERE casting.movieid = 11768;

/* 7 */
/* Obtain the cast list for the film 'Alien' */

SELECT name
FROM actor
JOIN casting ON actor.id = casting.actorid
JOIN movie ON movie.id = casting.movieid
WHERE movie.title = 'Alien';

/* 8 */
/* List the films in which 'Harrison Ford' has appeared */

FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford';

/* 9 */
/* List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] */

SELECT movie.title
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford' AND casting.ord <> 1;

/* 10 */
/* List the films together with the leading star for all 1962 films. */

SELECT movie.title, actor.name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE movie.yr = 1962 AND casting.ord = 1;

/* 11 */
/* Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies. */

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

/* 12 */
/* List the film title and the leading actor for all of the films 'Julie Andrews' played in.
Did you get "Little Miss Marker twice"?
Julie Andrews starred in the 1980 remake of Little Miss Marker and not the original(1934).
Title is not a unique field, create a table of IDs in your subquery */

SELECT movie.title, actor.name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE movieid IN(SELECT casting.movieid FROM casting JOIN actor ON actor.id = casting.actorid WHERE actor.name = 'Julie Andrews') AND casting.ord = 1;

/* 13 */
/* Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles. */

SELECT actor.name
FROM actor
JOIN casting ON casting.actorid = actor.id
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(casting.movieid) >= 15
ORDER BY actor.name;

/* 14 */
/* List the films released in the year 1978 ordered by the number of actors in the cast, then by title. */

SELECT movie.title, COUNT(casting.actorid)
FROM movie
JOIN casting ON casting.movieid = movie.id
WHERE movie.yr = 1978
GROUP BY movie.title
ORDER BY COUNT(casting.actorid) DESC, movie.title;

/* 15 */
/* List all the people who have worked with 'Art Garfunkel'. */

SELECT DISTINCT actor.name
FROM actor
JOIN casting ON casting.actorid = actor.id
WHERE casting.movieid IN(SELECT casting.movieid
FROM casting
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Art Garfunkel') AND actor.name <> 'Art Garfunkel'

/**********************************************************************/
/* using NULL */

/* 1 */
/* List the teachers who have NULL for their department.
Why we cannot use =
You might think that the phrase dept=NULL would work here but it doesn't - you can use the phrase dept IS NULL */

SELECT teacher.name
FROM teacher
WHERE dept IS NULL;

/* 2 */
/* Note the INNER JOIN misses the teachers with no department and the departments with no teacher. */

SELECT teacher.name, dept.name
FROM teacher INNER JOIN dept
ON (teacher.dept=dept.id)

/* 3 */
/* Use a different JOIN so that all teachers are listed. */

SELECT teacher.name, dept.name
FROM teacher
LEFT JOIN dept ON dept.id = teacher.dept;

/* 4 */
/* Use a different JOIN so that all departments are listed. */

SELECT teacher.name, dept.name
FROM teacher
RIGHT JOIN dept ON dept.id = teacher.dept;

/* 5 */
/* Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266' */

SELECT teacher.name, COALESCE(teacher.mobile,'07986 444 2266')
FROM teacher;

/* 6 */
/* Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department. */

SELECT teacher.name, COALESCE(dept.name, 'None')
FROM teacher
LEFT JOIN dept ON dept.id = teacher.dept;

/* 7 */
/* Use COUNT to show the number of teachers and the number of mobile phones. */
SELECT COUNT(teacher.name), COUNT(teacher.mobile)
FROM teacher

/* 8 */
/* Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed. */

SELECT dept.name, COUNT(teacher.name)
FROM teacher
RIGHT JOIN dept ON teacher.dept = dept.id
GROUP BY dept.name;

/* 9 */
/* Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise. */

SELECT teacher.name,
CASE
  WHEN dept.id = 1 THEN 'Sci'
  WHEN dept.id = 2 THEN 'Sci'
  ELSE 'Art'
END
FROM teacher
LEFT JOIN dept ON dept.id = teacher.dept;

/* 10 */
/* Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise. */

/* The following answer is a more complicated way of solving this.  It does not need a JOIN and can be completed by checking WHEN teacher.dept = 1...etc. Instead of WHEN dept.id.  The lesson would not accept the answer without a JOIN unless WHEN THEN IN() was used  */

SELECT teacher.name,
CASE
  WHEN dept.id = 1 THEN 'Sci'
  WHEN dept.id = 2 THEN 'Sci'
  WHEN dept.id = 3 THEN 'Art'
  ELSE 'None'
END
FROM teacher
LEFT JOIN dept ON dept.id = teacher.dept;


/* second acceptable answer */

SELECT teacher.name, 
CASE
  WHEN teacher.dept IN (1, 2) THEN 'Sci'
  WHEN teacher.dept = 3 THEN 'Art'
  ELSE 'None'
END
FROM teacher;
