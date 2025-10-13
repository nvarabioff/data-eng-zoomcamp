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
