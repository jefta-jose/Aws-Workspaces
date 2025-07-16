# Aws-Workspaces
To run Terraform commands with the `dev` environment using workspaces, here's a clear step-by-step guide for your terminal:

---

### ✅ Prerequisites:

* You've defined a workspace-aware module like:

  ```hcl
  module "enviroment" {
    source      = "../vars"
    environment = terraform.workspace
  }
  ```
* You have initialized your Terraform project (or will do so below).

---

### 🚀 Terminal Steps:

```bash
# 1. Navigate to your Terraform directory
cd path/to/your/terraform/code

# 2. Initialize the Terraform project (if you haven’t already)
terraform init

# 3. Create or select the `dev` workspace
terraform workspace new dev      # Only the first time
# or if it already exists
terraform workspace select dev

# 4. Confirm the current workspace
terraform workspace show          # Should return 'dev'

# 5. Now run your Terraform commands
terraform plan
terraform apply
```

---

### 🧠 How It Works:

* `terraform.workspace` will now evaluate to `"dev"` in your code.
* That value will be passed to your `module "enviroment"` and used however you handle environment-specific variables (e.g., via conditionals, variable files, etc.).

---

If you're using different variables for each environment, and your `../vars` module loads values dynamically based on the `environment` input, this will now work automatically for `dev` after following the steps above. Let me know if you want help structuring `../vars` too.
