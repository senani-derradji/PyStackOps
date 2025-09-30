# 🔑 Generate a GitHub Personal Access Token (PAT)

To run the GitHub Actions Runner with this project, you need a **Personal Access Token (PAT)**.  

Follow these steps:

1. **Go to Settings**
   - Log into [GitHub](https://github.com).
   - Click your **profile picture** (top right) → **⚙️ Settings**.

2. **Open Developer Settings**
   - In the left sidebar, scroll down and click **Developer settings**.

3. **Navigate to Tokens**
   - Click **Personal access tokens** → **Fine-grained tokens**.

4. **Generate a new token**
   - Click **Generate new token**.
   - Fill out the form:
     - **Name**: `runner-token-PyStackOps`
     - **Expiration**: 30 days (or shorter for security).
     - **Resource owner**: your GitHub account (or org).
     - **Repository access**: select **PyStackOps** (or the repo you want).
     - **Permissions**:
       - Under **Repository permissions** → set **Actions** to **Read and write** ✅.

5. **Generate & Copy**
   - Click **Generate token**.
   - Copy the token (looks like `ghp_xxxxx...`).
   - ⚠️ You won’t be able to see it again, so save it securely.

6. **Use the Token**
   - When setting up the runner, run:
     ```bash
     ./config.sh --url https://github.com/senani-derradji/PyStackOps --token YOUR_TOKEN_HERE
     ```

---

> 💡 **Tip:** For production, avoid storing the token in plaintext. Use [Ansible Vault](https://docs.ansible.com/ansible/latest/vault_guide/index.html) or environment variables for security.