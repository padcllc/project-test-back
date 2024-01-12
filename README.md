# Welcome to the project-test-back repository! 
This document provides an overview of our branching strategy to help streamline development and collaboration.

## Branching Strategy

### Main Branch

The main branch always reflects the production-ready state of the project.
It should only contain code that is thoroughly tested and ready for deployment.

### Dev Branch

The dev branch is the main development branch.
Feature branches are regularly merged into this branch to keep it up-to-date with the latest developments.

### Staging Branch

The staging branch is used for preparing releases.
Code from the dev branch is merged into staging for final testing before deployment to production.

### Branch Naming

Use meaningful and descriptive names for branches.
Please use this branch names:

- `feature` for new features
- `bugfix` for bug fixes
- `hotfix` for critical fixes in production

### Automatic Branch Deletion and Protected Branch

Once a branch is merged it is automatically deleted.
This helps keep the repository clean and reduces confusion.

Branches with the following prefixes will be protected:

- `main`
- `dev`
- `staging`

Protected branches cannot be pushed directly and cannot be deleted.
