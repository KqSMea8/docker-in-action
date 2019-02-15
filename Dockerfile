FROM python:3.6-alpine
COPY build /app
WORKDIR /app/html
EXPOSE 8000
CMD ["python", "-m", "http.server"]