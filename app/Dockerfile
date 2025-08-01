FROM python:3.9-slim

WORKDIR /app/
COPY . /app/

RUN pip install -r requirements.txt
RUN apt update && apt install -y wget
RUN echo "Start..." && sleep 3 && echo "Done after sleep"
RUN wget -O \
    wait-for-it.sh \
    https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
RUN chmod +x wait-for-it.sh
EXPOSE 5000
# i used gunicorn with 5 workers and 3 threads because it is a good balance for handling multiple requests efficiently
# you can adjust the number of workers and threads based on your application's needs and the resources available
# 5 workers and 3 threads is based on my Hardware Performance 2 cores and 4GB RAM
CMD ["./wait-for-it.sh", "db:3306", "--", "gunicorn", "-w", "2", "--threads", "3", "-b", "0.0.0:5000", "app:app"]