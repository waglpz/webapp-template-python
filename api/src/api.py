from flask_restx import Api
from werkzeug.exceptions import HTTPException


api = Api(
    version="0.1.0",
    title="@PROJECT_NAME@ API",
    doc="/api/doc",
    default="API",
    prefix='/api',
    security="apiKey",
    # authorizations=authorizations
)


class ApiProblem(Exception):

    def __init__(self, http_ex: HTTPException, detail: str = None):
        self.ex = http_ex
        self.detail = detail

    def data(self):
        return {
            "type": "about:blank",
            "status": self.ex.code,
            "title": self.ex.__name__,
            "detail": self.ex.description if self.detail is None else self.detail
        }

    def code(self):
        return self.ex.code
