FROM python:3.10

ARG APPUID=0
ARG APPUGID=0
ARG VIRTUAL_ENV=/api/venv

RUN if [ $APPUID != 0 ]; then        \
        mkdir -p  /home/devguy;        \
        groupadd -g $APPUGID devguy; \
        useradd -d /home/devguy -r -l -u $APPUID -g devguy devguy; \
    fi;

ENV VIRTUAL_ENV $VIRTUAL_ENV
ENV VIRTUAL_ENV_PROMPT (venv)
ENV PATH "$VIRTUAL_ENV/bin:$PATH"
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir -p /home/devguy/.cache/pip \
     && mkdir -p /home/devguy/.local \
     && chown -R devguy:devguy /home/devguy/.cache \
     && chown -R devguy:devguy /home/devguy/.local

COPY  gunicorn-cfg.py /gunicorn-cfg.py

RUN echo Init virtual environment then activating \
  && pip install gunicorn                         \
  && python3 -m venv --copies $VIRTUAL_ENV        \
  && chown -R $APPUID:$APPUGID $VIRTUAL_ENV

WORKDIR /api

CMD ["gunicorn", "--config", "/gunicorn-cfg.py", "run:app"]
