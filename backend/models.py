from flask_restful_swagger_2 import Schema



# &&&&& MODELS OF THE NODES &&&&&


class GreenPassModel(Schema):
    type = 'object'
    properties = {
        '<id>': {
            'type': 'string',
        },
        'date1': {
            'type': 'datetime',
        },
        'date2': {
            'type': 'datetime',
        },
        'type': {
            'type': 'string',
        }
    }


class PersonModel(Schema):
    type = 'object'
    properties = {
        '<id>': {
            'type': 'string',
        },
        'taxCode': {
            'type': 'string',
        },
        'name': {
            'type': 'string',
        },
        'surname': {
            'type': 'string',
        },
        'birth_date': {
            'type': 'datetime',
        }
    }


class PlaceModel(Schema):
    type = 'object'
    properties = {
        '<id>': {
            'type': 'string',
        },
        'name': {
            'type': 'string',
        },
        'coordinates': {
            'type': 'string',
        }
    }


class InfectionModel(Schema):
    type = 'object'
    properties = {
        '<id>': {
            'type': 'string',
        },
        'date_of_infection': {
            'type': 'datetime',
        }
    }
