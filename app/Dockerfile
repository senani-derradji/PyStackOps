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


CMD ["./wait-for-it.sh", "db:3306", "--", "python3", "app.py"]