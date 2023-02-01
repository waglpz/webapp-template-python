bind = '0.0.0.0:5000'
proc_name = '@PROJECT_NAME@'
workers = 6
threads = 2
accesslog = '-'
loglevel = 'debug'
capture_output = True
enable_stdio_inheritance = True
reload = True
max_requests = 1
timeout = 60
graceful_timeout = 60

