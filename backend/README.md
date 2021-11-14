# Covid Free App Backend

This section discusses how to run backend application and an API of it.

## How to run

1. You need to create the Neo4j database. We used sandbox.neo4j.com to distribute the database between all of us. 
2. After the creation of it there will be password, username and its address. You need to put them in your environment variables named COVID_FREE_DATABASE_USERNAME, COVID_FREE_DATABASE_PASSWORD, COVID_FREE_DATABASE_URL. The last one should be without the port.
3. Also create environmental variable named SECRET_KEY and place there whatever you want, for example String 'very secret key'
4. Run the requirements.txt
5. Run the command 
 ```
$ flask run
```
6. You are done!

## Heroku deployment

Our team has deployed this service with Heroku. To do it you should follow the Heroku guide.

## API

### HTTP [GET]

* ``/api/v0/PlaceAmountPeop`` is a **Q2** command that displays top 10 places with the most infected people and the number of the infected people for each of this place 
* ``/api/v0/PlaceQuarPeop/<string:place_name>/``is a **Q1** command that gets as the parameter the name of place and shows the people that went to a place while being infected
* ``/api/v0/DailyInfected/`` is a **Q3** command that shows each vaccination type and the number of people that have done it
* ``/api/v0/InfectedHealed/`` is a **Q4** command that shows daily healed/infected ratio
* ``/api/v0/GetDailyStamp/`` is a **Q5** command that shows daily infected/tested ratio
* ``/api/v0/MostVisited/`` is a **Q6** command that shows the most visited day of the most visited place

### HTTP [POST]
* ``/api/v0/SetPositive/``is a **C1** command that sets positive a list of already registered people
* ``/api/v0/SetGreen/``is a **C2** command that attaches the green pass to the specified user
* ``/api/v0/clean/``is a **C3** command that cleans the database keeping only active records
* ``/api/v0/PersonCreate/``is a out of scope command that registers the user
