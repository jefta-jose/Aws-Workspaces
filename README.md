
---

### 🔧 **Project Overview**

Provision an S3 bucket in each environment (`dev`, `staging`, `prod`) that triggers a Lambda function when new files are uploaded. Each environment has a **dedicated IAM user** who is allowed to drop files into the respective S3 bucket, triggering the `ObjectCreated` event.

---

### 📁 **Directory Structure (DRY & Modular)**

```bash
terraform-project/
│
├── modules/
│   ├── s3/
│   ├── lambda/
│   ├── event/
│   ├── iam_user/
│   │   └── main.tf
│   │   └── outputs.tf
│   │   └── variables.tf
│
├── environments/
│   ├── dev/
│   │   └── main.tf
│   │   └── terraform.tfvars
│   ├── staging/
│   │   └── main.tf
│   │   └── terraform.tfvars
│   └── prod/
│       └── main.tf
│       └── terraform.tfvars
│
├── shared/
│   └── provider.tf
│   └── backend.tf
│
└── pipeline/
    └── ci-cd.yml  # GitHub Actions or GitLab CI
```

---

### 🧱 **Modules**

Each module does one thing:

* `s3`: Creates the S3 bucket.
* `lambda`: Creates a basic Lambda function (with placeholder or inline code).
* `event`: Sets up S3 → Lambda trigger using `aws_s3_bucket_notification`.
* `iam_user`: Creates a dedicated IAM user per environment with `s3:PutObject` permission to the corresponding S3 bucket. This user is intended to upload files and trigger the Lambda.

---

### ⚙️ **Environments**

Each environment uses the same modules with different `terraform.tfvars` values:

* Unique bucket name (e.g., `my-bucket-dev`)
* Lambda function name
* IAM username (e.g., `uploader-dev`)
* Region, if needed

Each environment creates:

* 1 S3 bucket
* 1 Lambda function
* 1 IAM user with S3 write access
* 1 S3 → Lambda trigger

---

### 🔄 **CI/CD Pipeline**

We'll create a pipeline that does the following:

* On `main` branch push: deploy to `dev`
* On PR merge to `staging`: deploy to `staging`
* On release tag: deploy to `prod`

Access credentials (`access_key`, `secret_access_key`) for the uploader IAM users can be securely stored in secrets management tools (e.g., AWS Secrets Manager, Vault, or CI/CD secrets).

---
