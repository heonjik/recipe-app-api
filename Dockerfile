FROM python:3.9-alpine3.13
LABEL maintainer="heonjik"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app
WORKDIR /app
# defualt working directory when we run the commands on Docker image
EXPOSE 8000
# access port

# define single run command
RUN python -m venv /py && \
    # creates new vm
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    # add a user to avoid using root user account
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"
# automatically run in vm

USER django-user