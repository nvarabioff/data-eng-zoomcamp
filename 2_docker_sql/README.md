# Using this Directory

Build Docker image

1. Ensure Docker is installed and running.
2. Run the command to build the Docker image from Dockerfile in this directory:

    ```bash
    docker build -t test:pandas .
    ```

3. Run the Docker container with the following command:

    ```bash
    docker run -it test:pandas
    ```
