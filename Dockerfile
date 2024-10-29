FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

EXPOSE 8501

CMD ["/bin/bash", "-c", "sleep 30 && streamlit run main.py"]
