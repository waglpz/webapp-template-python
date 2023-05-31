import logging.handlers

from flask import Flask
from flask import make_response
from flask_cors import CORS
from werkzeug.exceptions import BadRequest, Unauthorized, Forbidden, NotFound, MethodNotAllowed, UnprocessableEntity
from werkzeug.exceptions import Conflict
from werkzeug.exceptions import InternalServerError

from src import manage
from src.api import api, ApiProblem
from src.db import db, mi
from src.ma import ma
from src.pa import pa


app = Flask(__name__)
app.config.from_object('config.BaseConfig')
log_level = logging.DEBUG if app.debug else logging.getLevelName(app.config['LOG_LEVEL'])
app.logger.setLevel(log_level)
app.logger.info('AuthZ Provider is starting and greetings you :)')

CORS(app)

db.init_app(app)
ma.init_app(app)
mi.init_app(app, db)
api.init_app(app)
pa.init_app(app, db)


#app.cli.add_command(manage.webapp_create)

@app.after_request
def after_request(response):
    status = int(response.status_code)
    if status == 500:
        http_ex = InternalServerError
    elif status == 400:
        http_ex = BadRequest
    elif status == 401:
        http_ex = Unauthorized
    elif status == 403:
        http_ex = Forbidden
    elif status == 404:
        http_ex = NotFound
    elif status == 405:
        http_ex = MethodNotAllowed
    elif status == 409:
        http_ex = Conflict
    elif status == 422:
        http_ex = UnprocessableEntity
    else:
        return response

    parent_response_data = response.get_json()
    if parent_response_data is None:
        api_problem = ApiProblem(http_ex)
        response = make_response(api_problem.data(), status)
        return response

    if 'message' in parent_response_data:
        message = parent_response_data['message']
        api_problem = ApiProblem(http_ex, message)
    else:
        api_problem = ApiProblem(http_ex)
    data = api_problem.data()

    if 'errors' in parent_response_data:
        problems = parent_response_data['errors']
        data['problems'] = problems

    response = make_response(data, status)
    return response
