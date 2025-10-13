# Using this Directory

## Video 1: Build sample Docker image

*Summary: This video demonstrates how to build a Docker image that includes Python and Pandas.*

1. Ensure Docker is installed and running.
2. Run the command to build the Docker image from Dockerfile in this directory:

    ```bash
    docker build -t test:pandas .
    ```

3. Run the Docker container with the following command:

    ```bash
    docker run -it test:pandas
    ```

## Video 2: Ingest csv data into Postgresql via Docker Container

*Summary: This video shows how to set up a PostgreSQL database in a Docker container and load NYC taxi data from CSV files into it.*

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

    *Leave this container running in the background.*

2. Open a new terminal, connect to PostgreSQL using the following command (make sure `pgcli` is installed):

    ```bash
    pgcli -h localhost -p 5432 -U root -d ny_taxi
    ```

3. Open another terminal and use a Jupyter notebook (`upload-data.ipynb`) to load data into PostgreSQL. This notebook connects to the PostgreSQL database running in the Docker container and uploads the NYC taxi data from CSV files.

4. After loading the data, you can query the database using the `pgcli` in the terminal from step 2.

5. Data persists in the `ny_taxi_postgres_data` directory, which is mounted to the Docker container that runs Postgresql that we used in step 1. You can stop the container and restart it later, and the data will still be available.

## Video 3: Connecting pgAdmin and PostgreSQL

*Summary: This video demonstrates how to set up pgAdmin in a Docker container to manage the PostgreSQL database running in a Docker container.*

1. Create docker network to allow the pgAdmin container to communicate with the PostgreSQL container:

    ```bash
    docker network create pg-network
    ```

    *When running containers, need to specify the container is running on the `pg_network` network.*

2. Re-run the PostgreSQL container with the network specified:

    ```bash
    docker run -it \
        -e POSTGRES_USER="root" \
        -e POSTGRES_PASSWORD="root" \
        -e POSTGRES_DB="ny_taxi" \
        -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data \
        -p 5432:5432 \
        --network=pg-network \
        --name pg-database \
        postgres:13
    ```

3. Run the pgAdmin container with the network specified:

    ```bash
    docker run -it \
        -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
        -e PGADMIN_DEFAULT_PASSWORD="root" \
        -p 8080:80 \
        --network=pg-network \
        --name pgadmin \
        dpage/pgadmin4
    ```

    *Connect at localhost:8080 in your browser and login with credentials.*

4. In pgAdmin, create a new server connection with the following settings:

    - **Name**: `Docker localhost`
    - **Host**: `pg-database`
    - **Port**: `5432`
    - **Username**: `root`
    - **Password**: `root`

## Video 4: Dockerize ingestion script

*Summary: This video shows how to convert the Jupyter notebook for data ingestion into a Python script and run it in a Docker container.*

Converted `upload-data.ipynb` to a Python script `ingest-data.py` that can be run from a Docker container.

1. Build and run `ingest-data.py` Docker container

    ```bash
    docker build -t taxi_ingest:v001 .
    ```

    ```bash
    docker run -it \
        --network=pg-network \
        taxi_ingest:v001 \
            --user=root \
            --password=root \
            --host=pg-database \
            --port=5432 \
            --db=ny_taxi \
            --table_name=yellow_taxi_data \
            --url=https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz
    ```

## Video 5: Running Postgres and pgAdmin with Docker-Compose

*Summary: This video demonstrates how to use Docker Compose to run PostgreSQL and pgAdmin containers together.*

Previous: run multiple different docker containers with different commands inside the same docker network. Not very convenient.

Now: Specify 1 yaml file with all the containers and their configurations.

Docker Compose: configuration for multiple containers in a single file.

1. Run the following command to start the containers defined in `docker-compose.yml`:

    ```bash
    docker-compose up
    ```

    *Connect at localhost:8080 in your browser and login with credentials.*

2. Configure new pgAdmin server connection as described in Video 3.

    Name: Docker localhost
    Host: pgdatabase
    Port: 5432
    Username: root
    Password: root

3. Shut down the containers with:

    ```bash
    docker-compose down
    ```

4. Run in detached mode with:

    ```bash
    docker-compose up -d
    ```

    *This allows you to run the containers in the background.*
