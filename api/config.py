import os

from dotenv import load_dotenv

BASE_DIR = os.path.dirname(os.path.realpath(__file__))
e = load_dotenv(".env", override=True)
LOG_LEVEL = str(os.environ.get('LOG_LEVEL'))
DATABASE_URI = str(os.environ.get("DATABASE_URI"))
SQLALCHEMY_ECHO = str(os.environ.get("SQLALCHEMY_ECHO")) == "True"

API_HOST_NAME = str(os.environ.get('API_HOST_NAME'))

class BaseConfig:
    API_HOST_NAME = API_HOST_NAME
    SQLALCHEMY_DATABASE_URI = DATABASE_URI
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_ECHO = SQLALCHEMY_ECHO
    SQLALCHEMY_ENGINE_OPTIONS = {
        "pool_pre_ping": True,
        "pool_recycle": 300,
    }
    PAGINATE_DATA_OBJECT_KEY = '_embedded'
    PAGINATE_PAGINATION_OBJECT_KEY = None
    PAGINATE_PAGE_SIZE = 10
    PAGINATE_RESOURCE_LINKS_ENABLED = False
    LOG_LEVEL = LOG_LEVEL
