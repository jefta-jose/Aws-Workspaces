Here's a fine-tuned version of your README. I’ve improved clarity, structure, grammar, and tone for better professionalism and readability, while preserving your original technical intent:

---

## 🚀 **Terraform S3 + Lambda Trigger with Terragrunt**

---

### 🔧 **Project Overview**

This project provisions an **S3 bucket** for each environment (`dev`, `staging`, `prod`) that triggers a **Lambda function** upon file uploads (`ObjectCreated` events). Each environment has its own **dedicated IAM user**, authorized to upload files to its respective S3 bucket.

The infrastructure is built using **Terragrunt**, which enforces **DRY principles**, centralizes backend and provider configurations, and simplifies multi-environment management.

---

### 📁 **Directory Structure**

```bash
terraform-project/
│
├── modules/                      # Reusable Terraform modules
│   ├── s3/                       # Creates S3 buckets
│   ├── lambda/                   # Defines Lambda functions
│   ├── event/                    # Sets up S3 → Lambda trigger
│   └── iam_user/                 # IAM user with upload permissions
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
│
├── environments/                # Environment-specific Terragrunt configurations
│   ├── dev/
│   │   └── terragrunt.hcl
│   ├── staging/
│   │   └── terragrunt.hcl
│   └── prod/
│       └── terragrunt.hcl
│
├── app/                         # Terraform composition layer
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
│
├── root.hcl                     # Root-level Terragrunt configuration
│
└── pipeline/
    └── ci-cd.yml                # CI/CD pipeline (GitHub Actions, GitLab CI, etc.)
```

---

### 🧭 **Understanding Path Resolution in Terragrunt**

Terragrunt creates a `.terragrunt-cache` directory during operations like `init`, `plan`, and `apply`. This cache causes relative paths (e.g., module sources) to be resolved from within the cache directory—not from the original source file.

#### ✅ Best Practice

To correctly reference shared modules, use deep relative paths such as:

```hcl
path = "../../../../../../modules/app"
```

This ensures compatibility across environments and avoids path resolution errors.

---

### 🧱 **Module Responsibilities**

Each module is purpose-built for single responsibility:

* **`s3/`**: Creates versioned S3 buckets.
* **`lambda/`**: Defines a basic Lambda function (custom code placeholder).
* **`event/`**: Connects S3 `ObjectCreated` events to Lambda.
* **`iam_user/`**: Provisions an IAM user with scoped `s3:PutObject` permissions.

---

### 💡 **Terragrunt & DRY Principles**

Terragrunt enables central management of:

* **Remote backend configuration**
* **Provider configuration**
* **Common input variables**

Using the `generate` block, Terragrunt **automatically creates the `backend.tf`** file in each environment. When `if_exists = "overwrite_terragrunt"` is specified, the backend config will be **regenerated on every run**, even if it already exists.

---

### 🧠 **Why Use Terragrunt?**

Terragrunt simplifies and scales Terraform workflows:

✅ Treats each environment as a stack
✅ Supports `run-all` for multi-stack orchestration
✅ Removes duplication of backend/provider code
✅ Improves state management and operational consistency

To deploy across all environments:

```bash
cd terraform-project/
terragrunt run --all apply
```

To destroy all environments:

```bash
terragrunt run --all destroy
```

---

### 🔄 **CI/CD Integration (Optional)**

Sample deployment workflow:

* **`main` branch push** → deploy to **`prod`**
* **PR merge to `staging`** → deploy to **`staging`**
* **PR merge to `dev`** → deploy to **`dev`**

Use secure storage for sensitive credentials (e.g., **GitHub Secrets**, **AWS Secrets Manager**, or **Vault**).

---
