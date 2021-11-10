import os
import ast
import re
from functools import wraps

from dotenv import load_dotenv, find_dotenv


from flask import Flask, g, request, abort, request_started
from flask_restful import Resource, reqparse
from flask_cors import CORS
from flask_json import FlaskJSON, json_response
from flask_restful_swagger_2 import Api, swagger, Schema

from neo4j import GraphDatabase, basic_auth

"""
The credits are 
https://github.com/neo4j-examples/neo4j-movies-template/blob/master/flask-api/app.py
"""

# For environmental variables that represents the connection
load_dotenv(find_dotenv())

app = Flask(__name__)

CORS(app)
FlaskJSON(app)

api = Api(app, title='Neo4J Covid Free Demo API', api_version='0.0.10')


@api.representation('application/json')
def output_json(data, code, headers=None):
    return json_response(data_=data, headers_=headers, status_=code)


def env(key, default=None, required=True):
    """
    Retrieves environment variables and returns Python natives. The (optional)
    default will be returned if the environment variable does not exist.
    """
    try:
        value = os.environ[key]
        return ast.literal_eval(value)
    except(SyntaxError, ValueError):
        return value
    except KeyError:
        if default or not required:
            return default
        raise RuntimeError("Missing required environment variable '%s'" % key)


#DATABASE_USERNAME = env('COVID_FREE_DATABASE_USERNAME')
DATABASE_USERNAME = "neo4j"
#DATABASE_PASSWORD = env('COVID_FREE_DATABASE_PASSWORD')
DATABASE_PASSWORD = "chimneys-october-meaning"
#DATABASE_URL = env('COVID_FREE_DATABASE_URL')
DATABASE_URL = "bolt://3.83.161.32"

driver = GraphDatabase.driver(DATABASE_URL, auth=basic_auth(DATABASE_USERNAME, str(DATABASE_PASSWORD)))

#app.config['SECRET_KEY'] = env('SECRET_KEY')
app.config['SECRET_KEY'] = "very secret key"


def get_db():
    if not hasattr(g, 'neo4j_db'):
        g.neo4j_db = driver.session()
    return g.neo4j_db


@app.teardown_appcontext
def close_db(error):
    if hasattr(g, 'neo4j_db'):
        g.neo4j_db.close()


def set_user(sender, **extra):
    auth_header = request.headers.get('Authorization')
    if not auth_header:
        g.user = {'id': None}
        return
    match = re.match(r'^Token (\S+)', auth_header)
    if not match:
        abort(401, 'invalid authorization format. Follow `Token <token>`')
        return
    token = match.group(1)

    # get users from the system
    def get_user_by_token(tx, token):
        return tx.run(
            '''
            MATCH (user: User {api_key: $api_key}) RETURN user
            ''', {'api_key': token}
        ).single()

    db = get_db()
    result = db.read_transaction(get_user_by_token, token)

    try:
        g.user = result['user']
    except (KeyError, TypeError):
        abort(401, 'invalid authorization key')
    return


#request_started.connect(set_user, app)


def login_required(f):

    @wraps(f)
    def wrapped(*args, **kwargs):
        auth_header = request.headers.get('Authorization')
        if not auth_header:
            return {'message': 'no authorization provided'}, 401
        return f(*args, **kwargs)


class PlaceQuarPeop(Resource): #Q1
    def get(self, place_name):
        def get_placeQuar(tx, name_place):
            return list(tx.run('''MATCH
                (a:Place { name: $name_place} )-
                [c:HOSTED]->(p:Person)-[:GOT_AN]->(i:Infection)
                WHERE c.entry_moment >= i.date_of_infection
                RETURN p,a''', {'name_place': name_place}))
        db = get_db()
        result = db.read_transaction(get_placeQuar, place_name)
        return result

class PlaceAmountPeop(Resource):#Q2
    def get(self):
        def get_amountPeop(tx):
            return list(tx.run('''MATCH (p:Place)-[:HOSTED]->(:Person)-[r:GOT_AN]->(:Infection)
                        WITH p, COUNT(r) AS cnt ORDER BY cnt desc
                        RETURN collect(p.name) as names
                        LIMIT 1'''))
        db = get_db()
        result = db.read_transaction(get_amountPeop)
        return result

class DailyInfected(Resource):#Q3
    def get(self):
        def get_cluster(tx):
            return list(tx.run('''MATCH (gp: GreenPass)
                    WITH gp.type as Vaccination_type, COUNT(gp) as number
                    RETURN COLLECT(Vaccination_type) as type_of_vaccine, number ORDER BY number 
                    DESC'''))
        db = get_db()
        result = db.read_transaction(get_cluster)
        return result

class InfectedHealed(Resource):#Q4
    def get(self):
        def get_genres(tx):
            return list(tx.run('''MATCH (pInfected:Person)-[:GOT_AN]->(:Infection) 
                                WITH COUNT(pInfected) AS infected 
                                MATCH (pRecovered:Person) 
                                WHERE EXISTS ((pRecovered)-[:GOT_AN]-(:Infection)) = FALSE 
                                WITH infected, COUNT(pRecovered) AS recovered 
                                RETURN (infected / toFloat(recovered)) AS dailyInfectedRatio'''))
        db = get_db()
        result = db.read_transaction(get_genres)
        return result

class MostVisited(Resource):#Q5
    def get(self):
        def get_history(tx):
            return list(tx.run('''match (:Person)-[r:WENT_TO]->(p:Place)
                                with count(r) as num, p
                                order by num desc limit 1
                                match (a:Person)-[r1:WENT_TO]->(p)<-[r2:WENT_TO]-(b:Person)
                                where r1.exit_moment.epochSeconds > r2.entry_moment.epochSeconds AND 
                                r1.entry_moment < r2.exit_moment
                                with count(a)+1 as number, p.name as place, r1, date(r1.entry_moment) as date, a
                                return date, number, place, collect(a) order by number desc limit 1'''))
        db = get_db()
        result = db.read_transaction(get_history)
        return result

class SetPositive(Resource):#C1
    def get(self,people, infections):
        def make_person(person):
            r = list()
            c = 0
            for p in person:
                r.append("(p" + str(c) + ": Person" + p + ")")
                c = c + 1
            return str(r)[1:-1].replace("\'", "")

        def make_infection(infection):
            r = list()
            c = 0
            for i in infection:
                r.append("(p" + str(c) + ")-[:GOT_AN]->(:Infection" + i + ")")
                c = c + 1
            return str(r)[1:-1].replace("\'", "")

        def get_genres(tx, people, infections):
            people = make_person(people)
            infections = make_infection(infections)
            return list(tx.run("""MATCH ($people)}
                                CREATE $infections""", {'people':people, 'infections':infections}))
        db = get_db()
        result = db.write_transaction(get_genres, people, infections)
        return result

class SetGreen(Resource):#C2
    def get(self):
        def get_genres(tx, tax):
            return list(tx.run("""MATCH (a:Person)
                        WHERE a.taxCode=$tax 
                        CREATE (gp:GreenPass), (a)-[:HAS_A]->(gp)-[:BELONGS_TO]->(a)
                        WITH 1 as dummy
                        MATCH (a)-[r:GOT_AN]->(i:Infection)
                        WHERE a.taxCode= $tax
                        DETACH DELETE i"""),{'tax':tax})
        db = get_db()
        result = db.write_transaction(get_genres)
        return result

class DataCleaning(Resource):#C3
    def get(self):
        def get_genres(tx):
            return list(tx.run("""MATCH (a)-[r:HAS_A|BELONGS_TO|WENT_TO|HOSTED]->(p)
                            WHERE (datetime().epochSeconds-(r.exit_moment).epochSeconds>=0 
                            AND datetime().epochSeconds-(r.exit_moment).epochSeconds >= 86400*14)
                            OR
                            (datetime().epochSeconds > p.date2.epochSeconds OR datetime().epochSeconds > 
                            a.date2.epochSeconds)
                            DELETE r
                            WITH 1 AS dummy
                            MATCH (gp:GreenPass) WHERE NOT EXISTS( (gp)<-[:HAS_A]-(:Person) )
                            DELETE gp"""))
        db = get_db()
        result = db.write_transaction(get_genres)
        return result


api.add_resource(PlaceAmountPeop, '/api/v0/PlaceAmountPeop/')
api.add_resource(PlaceQuarPeop, '/api/v0/PlaceQuarPeop/<string:place_name>')#Duomo of Milan,
api.add_resource(DailyInfected, '/api/v0/DailyInfected/')
api.add_resource(InfectedHealed, '/api/v0/InfectedHealed/') #wrong query in document
api.add_resource(MostVisited, '/api/v0/MostVisited/')#TypeError: Object of type Date is not JSON serializable, query is ok
#api.add_resource(SetPositive, '/api/v0/SetPositive/<people:people>/<infections:infections>') #to test
api.add_resource(SetGreen, '/api/v0/SetGreen/')#to test
api.add_resource(DataCleaning, '/api/v0/topk/')#to test
