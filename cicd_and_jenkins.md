# Intro to CI/CD and Jenkins
- [Intro to CI/CD and Jenkins](#intro-to-cicd-and-jenkins)
  - [What is CI?](#what-is-ci)
  - [What is CD?](#what-is-cd)
- [What is Jenkins?](#what-is-jenkins)
    - [Drawbacks](#drawbacks)
  - [Stages of Jenkins](#stages-of-jenkins)
  - [Alternatives](#alternatives)
- [Why build a CICD Pipeline?](#why-build-a-cicd-pipeline)
- [How does Jenkins Work?](#how-does-jenkins-work)

## What is CI?
- continuous integration
- CI often triggered when updated code gets pushed to particular branches
  - depends on the specific git workflow used
  - in the case of feature branches
- If the code passes automated tests, it gets integrated (merged) into the dev/main branch.
  - A fail safe that picks up (some) errors
- helps keep software stable

## What is CD?
Two versions:
- Continuous Delivery
  - Build the software, turn it into an artifact that can be deployed whenever the go is given
  - Usually deployment depends on manual approval
- Continuous Deployment
  - Deploy application (often straight to production)

# What is Jenkins?
- open source automation server
- mostly used for CICD
  -  has other uses
-  automation is usually good
-  extensible - 1800+ plugins
-  scalability - Jenkins can distribute workload across agents/nodes
-  Lots of community support
-  cross-platform

### Drawbacks
- Can get pretty complicated
- Not always easy to optimize
- Plugin management can get busy

## Stages of Jenkins
1. **CI:** source code management (SCM)
2. **CI:** Build code
3. **CI:** Run tests
4. **CD:** Packaging into deployable artifact
5. **CD:** Deploy package and run it
6. **CD:** Monitoring

## Alternatives
- GitLab
- CircleCI
- Travis CI
- Github Actions
- Bamboo
- GoCD
- TeamCity
- Azure Devops Pipelines

# Why build a CICD Pipeline?
- Can be used for user testing:
  - feature toggles
  - A/B Testing
  - Blue/Green deployment
- Shortens time from creation to reception.
  - Benefits end users
  - Feedback comes back faster
- Bug fixes can go fast
- Generally al lot of speeed benefits

# How does Jenkins Work?
- When a developer pushes to certain branches, github/etc will trigger a webhook to alert listeners a change has been made
- Jenkins master node either runs the pipeline itself, or sends it to an agent node
  - using an agent node is generally better, or at least safer
- The pipeline might be the following steps:
   1. Test code
   2. Merge into main/product branch
   3. build/deploy code
- It can then directly connect to production machines to deploy it automatically