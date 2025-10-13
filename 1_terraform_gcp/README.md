# Terraform and GCP

## Video 1: Terraform Basics

1. Set up service account on GCP

    a. Create a project in GCP -> `terraform-demo`
    b. Create a service account in the project -> `terraform-runner` with `Storage Admin`, `Compute Admin`, and `BigQuery Admin` roles
    c. Create a key for the service account and download it as `terraform-runner.json`

2. Create `main.tf` file

3. Set google credentials

    a. Set the environment variable `GOOGLE_APPLICATION_CREDENTIALS` to the path of the service account key file
       ```bash
       export GOOGLE_APPLICATION_CREDENTIALS="/path/to/terraform-runner.json"
       ```

4. Run terraform init to initialize the project

   ```bash
   terraform init
   ```

5. Run terraform plan to see the execution plan

   ```bash
   terraform plan
   ```

6. Run terraform apply to apply the changes

   ```bash
   terraform apply
   ```

   *Terraform `.tfstate` file will be created to keep track of the resources*

7. Run terraform destroy to destroy the resources

   ```bash
   terraform destroy
   ```

## Video 2: Terraform Variables

1. Add bigquery dataset to `main.tf`

2. Create `variables.tf` file and make updates to `main.tf` to use variables

## Video 1.4.1: Setting up the Environment on Google Cloud (Cloud VM + SSH access)

1. Create SSH keys

   a. Navigate to `.ssh/` directory

   b. Generate SSH key `ssh-keygen -t rsa -f gcp -C nvarabioff -b 2048`

   c. Enter passphrase or leave it empty (you will need to enter it every time you ssh into this VM)

   d. This creates two files `gcp` (private key) and `gcp.pub` (public key). Do not share the private key with anyone.

   e. Navigate to GCP console -> Compute Engine -> Metadata -> SSH Keys and add the content of `gcp.pub` file.

2. Create a VM instance on GCP

   a. Navigate to Compute Engine -> VM Instances -> Create Instance

   b. Name the instance `de-zoomcamp` and select region and zone.

   c. Choose `e2-standard-2` machine type.

   d. Choose Ubuntu as Boot Disk Operating System and set boot disk size to `30GB`.

3. SSH into the VM instance

   a. Copy the external IP of the instance

   b. SSH into the instance using the private key `ssh -i ~/.ssh/gcp nvarabioff@<EXTERNAL_IP>`

4. Configure instance

   a. Download anaconda `wget https://repo.anaconda.com/archive/Anaconda3-2025.06-0-Linux-x86_64.sh`

   b. Install anaconda `bash Anaconda3-2025.06-0-Linux-x86_64.sh`

   c. Create entry in `~/.ssh/config` file to avoid using `-i` and username every time you ssh into the VM

      ```bash
      Host de-zoomcamp
         HostName <EXTERNAL_IP>
         User nvarabioff
         IdentityFile ~/.ssh/gcp
      ```

   d. Now you can ssh into the VM using `ssh de-zoomcamp`

   e. Install docker `sudo apt-get install docker.io`

   f. Run docker without sudo: `sudo groupadd docker` and `sudo usermod -aG docker $USER`

   g. Install docker compose `wget https://github.com/docker/compose/releases/download/v2.40.0/docker-compose-linux-x86_64 -O docker-compose` and `chmod +x docker-compose`

   h. Add docker compose to PATH variable -> add `export PATH="${HOME}/bin:${PATH}"` to `~/.bashrc` file

   i. Git clone data engineering zoomcamp repo (http)

   j. cd into `01-docker-terraform/2_docker_sql` folder and `docker-compose up -d`

   k. In a new window, install pgcli `pip install pgcli` and connect to the Postgres db `pgcli -h localhost -U root -d ny_taxi`. Password is `root`.

   l. Forward this port to local machine so we can interact with the db from local machine. In "Ports" section of VSCode terminal, forward port 5432. Now you can execute `pgcli -h localhost -U root -d ny_taxi -p <forwarded port>` from local machine. Can add 8080 port as well to access pgadmin from local machine.

   m. Execute jupyter notebook. Start `jupyter notebook` on VM from `2_docker_sql` directory. Add port 8888 to port forwarding in VSCode terminal. Copy jupyter notebook link (with token) to access it from local browser.

   o. Run `upload-data.ipynb` notebook to upload data to Postgres db.

   p. Install Terraform in `~/bin` directory

      ```bash
      wget https://releases.hashicorp.com/terraform/1.13.3/terraform_1.13.3_linux_amd64.zip
      unzip terraform_1.6.7_linux_amd64.zip
      ```

   q. Get GCP service account credentials on VM. `sftp de-zoomcamp` and move `terraform-runner.json` file to `~/.gc/` directory on VM. and `put /path/to/terraform-runner.json`

   r. Configure Google Cloud CLI `export GOOGLE_APPLICATION_CREDENTIALS=~/.gc/terraform-runner.json` then `gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS`

5. Configure VSCode to use the VM as remote environment

   a. Install `Remote - SSH` extension in VS Code

   b. Click on the green icon in the bottom left corner and select `Remote-SSH: Connect to Host...`

   c. Select `de-zoomcamp` from the list

   d. Open the folder where you want to work on the VM

6. Shut down VM

   a. From console, navigate to VM instances and select the instance, click the three dots, more actions, and select stop (or delete).

   b. From terminal, run `sudo shutdown now`.

   c. Once you restart the instance, it will have a new external IP. Update the `HostName` in `~/.ssh/config` file accordingly.
