from uuid import UUID

from flask_migrate import Migrate
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.dialects.mysql import BINARY
from sqlalchemy.types import TypeDecorator

db = SQLAlchemy()
mi = Migrate()


class Operation:
    def persist(self) -> None:
        db.session.add(self)
        db.session.commit()

    def remove(self) -> None:
        db.session.delete(self)
        db.session.commit()


class BinaryUUID(TypeDecorator):
    """
    Optimize UUID keys. Store as 16 bit binary, retrieve as uuid.
    inspired by:
        https://mysqlserverteam.com/storing-uuid-values-in-mysql-tables/
    """

    impl = BINARY(16)
    cache_ok = True
    
    def process_bind_param(self, value, dialect):
        try:
            return value.bytes
        except AttributeError:
            try:
                if isinstance(value, tuple):
                    if isinstance(value[0], UUID):
                        return value[0].bytes
                    return UUID(value[0]).bytes
                if isinstance(value, UUID):
                    return value.bytes
                return UUID(value).bytes
            except ValueError:
                # TODO: logging here
                raise ValueError
            except TypeError:
                # for some reason we ended up with the bytestring
                # ¯\_(ツ)_/¯
                # I'm not sure why you would do that,
                # but here you go anyway.
                return value

    def process_result_value(self, value, dialect):
        return UUID(bytes=value)
