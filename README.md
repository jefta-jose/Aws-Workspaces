### 🔧 **Project Overview**

Provision an S3 bucket in each environment (`dev`, `staging`, `prod`) that triggers a Lambda function when new files are uploaded.

---

### 📁 **Directory Structure (DRY & Modular)**

```bash
terraform-project/
│
├── modules/
│   ├── s3/
│   │   └── main.tf
│   ├── lambda/
│   │   └── main.tf
│   └── event/
│       └── main.tf
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

---

### ⚙️ **Environments**

Each environment uses the same modules with different `terraform.tfvars` values:

* Bucket name suffix
* Lambda function name
* Region, if needed

---

### 🔄 **CI/CD Pipeline**

We'll create a pipeline that does the following:

* On `main` branch push: deploy to `dev`
* On PR merge to `staging`: deploy to `staging`
* On release tag: deploy to `prod`

---
