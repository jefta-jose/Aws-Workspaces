---

## 🚀 **Terraform S3 + Lambda Event Trigger with Terragrunt**

---

### 🔧 **Project Overview**

Provision an **S3 bucket** in each environment (`dev`, `staging`, `prod`) that triggers a **Lambda function** when new files are uploaded. Each environment has a **dedicated IAM user** who is authorized to upload files to the respective S3 bucket, triggering an `ObjectCreated` event.

Built with **Terragrunt** to enforce **DRY principles**, centralize backend and provider configurations, and manage environment-specific stacks easily.

---

### 📁 **Directory Structure (Modular & DRY)**

```bash
terraform-project/
│
├── modules/                      # Reusable Terraform modules
│   ├── s3/                       # S3 bucket creation
│   ├── lambda/                   # Lambda function definition
│   ├── event/                    # S3 → Lambda trigger setup
│   ├── iam_user/                 # IAM user with S3 upload permissions
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│
├── environments/                # Environment-specific configurations
│   ├── dev/
│   │   ├── main.tf
│   │   └── terragrunt.hcl
│   ├── staging/
│   │   ├── main.tf
│   │   └── terragrunt.hcl
│   └── prod/
│       ├── main.tf
│       └── terragrunt.hcl
│
├── root.hcl                     # Root Terragrunt configuration
│
└── pipeline/
    └── ci-cd.yml                # GitHub Actions or GitLab CI pipeline
```

## 📁 Module Path Structure Explained

Terragrunt creates a `.terragrunt-cache` directory during operations such as `init`, `plan`, and `apply`. This cache directory is nested within the environment-specific folder where each Terragrunt configuration is executed.

Because of this, relative paths in `terraform` blocks—especially those referencing shared modules—are evaluated _from within_ the `.terragrunt-cache` directory rather than the actual location of the `terragrunt.hcl` file.

### 🔍 Why the Deep Relative Path?

To correctly locate shared Terraform modules, we use a path like:
```hcl
path = "../../../../../../modules/app"

---

### 🧱 **Modules**

Each module encapsulates a single responsibility:

* `s3`: Creates a versioned S3 bucket.
* `lambda`: Defines a Lambda function with placeholder code.
* `event`: Sets up the bucket → Lambda trigger.
* `iam_user`: Creates an IAM user with `s3:PutObject` permissions for the specific bucket.

---

#### 💡 Terragrunt DRY Principle

Terragrunt allows you to define shared configurations (like remote state and providers) in `root.hcl`, and it **generates `backend.tf` automatically** per environment.

If you already have a state file tracking resources (like in `dev`), **Terragrunt will overwrite the backend configuration** if `if_exists = "overwrite_terragrunt"` is set. For untracked modules, it just works.

---

### 🧠 **Why Terragrunt Rocks**

* Treats each environment as a **stack** using `terragrunt.hcl` files.
* Supports `run-all` commands for multi-environment workflows.
* Eliminates copy-pasting backend/provider blocks.
* Great for managing **remote state** and consistent deployments.

You can deploy everything from the root with:

```bash
cd terraform-project/
terragrunt run-all apply
```

And tear down everything with:

```bash
terragrunt run-all destroy
```

---

### 🔄 **CI/CD Pipeline**

A sample pipeline could:

* Deploy to **`prod`** on `main` branch push
* Deploy to **`staging`** on PR merge to staging
* Deploy to **`dev`** on PR merge to dev

**Secrets**, such as IAM access keys, should be stored securely (e.g., GitHub Secrets, AWS Secrets Manager, Vault).

---