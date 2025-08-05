# 📘 Git Commands and Team Workflow

## 🔧 Main Git Commands

| Command | Description |
|--------|-------------|
| `git init` | Initializes a new Git repository. |
| `git clone <repo_url>` | Clones a remote repository to your local machine. |
| `git status` | Shows the current state of the working directory and staging area. |
| `git add <file>` | Stages changes to be committed. Use `git add .` to stage all changes. |
| `git commit -m "message"` | Commits staged changes with a descriptive message. |
| `git pull` | Fetches and merges changes from a remote repository into the current branch. |
| `git push` | Pushes local commits to the remote repository. |
| `git branch` | Lists all local branches. Add `-r` for remote branches. |
| `git checkout <branch>` | Switches to a different branch. |
| `git checkout -b <branch>` | Creates and checks out a new branch. |
| `git merge <branch>` | Merges changes from the specified branch into the current branch. |
| `git fetch` | Downloads objects and refs from another repository, but doesn’t merge. |
| `git fetch origin <branch>` | Fetches a specific branch from the remote. |
| `git log` | Shows the commit history. |
| `git diff` | Shows differences between commits, branches, or the working directory. |

---
## 💡 Useful Tips
### 🔍 Listing Branches
Local branches:
```bash
git branch
```

Remote branches:
```bash
git branch -r
```

All branches (local + remote):
```bash
git branch -a
```

### 📌 Branch Filtering
Find branches by name pattern (e.g., all feature branches):
```bash
git branch --list '*feature*'
```

### 🧼 Clean Up Merged Branches
List merged branches:
```bash
git branch --merged
```

Delete all merged branches except main:
```bash
git branch --merged | grep -v 'main' | xargs git branch -d
```

### 🆕 Create and Switch to a New Branch
```bash
git checkout -b feature/awesome-feature
```

### 🆙 Keep Your Branch Updated with Main
Switch to your branch:
```bash
git checkout feature/your-branch
```

Fetch and merge the latest changes from main:
```bash
git fetch origin
git merge origin/main
```

## 👥 Typical Git Workflow for a Team

### 1. Clone the Repository
```bash
git clone https://github.com/team/project.git
cd project
```
### 2. Create a New Branch for Your Task
git checkout -b feature/login-form
### 3. Make Changes and Commit
```bash
git add .
git commit -m "Implement login form UI"
```
### 4. Push the Branch to Remote
```bash
git push origin feature/login-form
```
### 5. Open a Merge Request (MR) or Pull Request (PR)
Navigate to the repository on GitHub, GitLab, or Bitbucket.

Create a new MR/PR from feature/login-form to main or develop.

Request reviews from team members.

### 6. Fetch and Check Out a Specific Branch
```bash
git fetch origin feature/login-form
git checkout feature/login-form
```
### 7. Merge the Branch After Approval
```bash
git checkout main
git pull origin main
git merge feature/login-form
git push origin main
```
### 8. Delete the Feature Branch (Optional Cleanup)
```bash
git branch -d feature/login-form              # Delete locally
git push origin --delete feature/login-form   # Delete from remote
```
## 📝 Tips
Use meaningful branch names (e.g., feature/signup, bugfix/navbar).

Commit small, logical changes with clear messages.

Always pull before pushing to avoid merge conflicts

## Create a repo from CLI
```bash
mkdir your-repo
cd your-repo
gh repo create learning --public --source=. --remote=origin --push
```

