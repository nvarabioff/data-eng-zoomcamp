# Using this Directory

Video 1: Build Docker image

1. Ensure Docker is installed and running.
2. Run the command to build the Docker image from Dockerfile in this directory:

    ```bash
    docker build -t test:pandas .
    ```

3. Run the Docker container with the following command:

    ```bash
    docker run -it test:pandas
    ```

Video 2: Postgresql Docker Container

1. Run the Docker container for PostgreSQL with the following command:

    ```bash
    docker run -it \
        -e POSTGRES_USER="root" \
        -e POSTGRES_PASSWORD="root" \
        -e POSTGRES_DB="ny_taxi" \
        -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data \
        -p 5432:5432 \
        postgres:13
    ```

    Leave this container running in the background.

2. Open a new terminal, connect to PostgreSQL using the following command (make sure `pgcli` is installed):

    ```bash
    pgcli -h localhost -p 5432 -U root -d ny_taxi
    ```

3. Open another terminal and use a Jupyter notebook (`upload-data.ipynb`) to load data into PostgreSQL.

4. After loading the data, you can query the database using the `pgcli` in the terminal from step 2.
