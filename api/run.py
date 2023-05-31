import logging

from src import app, db


@app.shell_context_processor
def make_shell_context():
    return {
        "app": app,
        "db": db,
    }


if __name__ != '__main__':
    gunicorn_logger = logging.getLogger('gunicorn.error')
    app.logger.handlers = gunicorn_logger.handlers
    app.logger.setLevel(gunicorn_logger.level)

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")
