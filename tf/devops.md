### Job Description

Lead DevOps Engineer

As DevOps Engineer, you will be responsible for managing our operations, building our delivery
pipelines and monitoring our platform to ensure the reliability of our services.

Requirements

* Strong background in Linux administration
* Automation and configuration management
* Experience with Ruby web frameworks, specifically Ruby on Rails
* Experience with databases: MySQL, MongoDB
* Experience with cloud platforms, provisioning tools & monitoring tools
* Experience with web technologies and websites running Apache or NGINX
* Experience with Node.JS is also a plus

Additionally:

* Experience in highly-available IT operations: fault-tolerance, zero-downtime deploy, scalability
* Continuous Integration and Continuous Delivery best practices
* Security Best Practices / Secure architecture and design
#### Question 1
1. Hobbies:
  - cycling
  - fiddling with computers
  - photography
  - videography

2. Commercial projects:
 a) Im mostly proud of my experience moving a 400 server DC from Amsterdam to Brno. That was for Jumpshot/Avast. 
    I had developed a way to get the server up and freshly installed as a node of HDFS within 17 minutes from putting it on the rack.
 b) This year i had to commercialy install prometheus and configure it on 6 different occasions.

 #### Question 2

* Describe your experience with cloud platforms such as Google Cloud, Amazon AWS, DigitalOcean, etc.

I've had commecialy a go at all of them:
  AWS: Lift and shift of 400 apps for a german OS manufacturer
  GCP: groundup IaaC based K8s + Storage + DBs etc for a startup
  Azure: I'd rather shut it down, but - Pulumi based cluster management(I used JS) for an IoT cable manufacturer. 
  DigitalOcean: Used just some of their services for personal projects. 

* Describe your experience with provisioning tools such as Chef, Puppet, Ansible, etc.

 Q1.2.a: was written in kickstart and ansible entirely using etcd as inventory store and a python interpretor of json to yaml. 

* Describe your experience with monitoring tools such as Stackdriver, Datadog, Nagios, etc.

  Prometheus fan and ELK(OpenDistro) pioneer for Czech Republic - worked with ELK since 2016.

#### Question 3

Explain how you would create an unified deployment platform to push new release on production.

Requirements:

    * It can be automated (from CI) and triggered manually (when manual actions are required)
    * It checks CI success before deploy a new release
    * It keeps track of every deployment
    * It queues deployment to avoid conflicts
    * It allows quick rollback
    * It ensures deployment integrity through process monitoring
All this happens in Gitlab, cuase it's easy;) 
1. Download necessary artifacts(an image on the side can be maintained with a direct copy of the artifact declaration, gemfile, package.json etc.)
2. Code coverage - overcommit or something like this. (linting security etc)
3. Build in docker
4. make a deployment with the branch name on k8s
5. wait for external-dns to assign the dns record
6. Run tests against that particular deployment
7. Send test results to elasticsearch, display them in grafana, notify QA.
8. If the tests pass with 98% move on and deploy to staging against traffic which is directly forked from production(could be goreplay or just ingress feature.)
9. If it breaks down - go back to development, if it doesn't - move on to verifying what is functioning - time for manual testing.
10. if manual testing works out well - congrats - you can move start a deployment to production. If not - back to the drawing board.
11. Production rollout. If it doesn't work out, roll back to an earlier version. 

#### Question 4

Create a [Terraform](https://www.terraform.io/) provisioning for [Google Cloud
Compute](https://cloud.google.com/compute).

Requirements:

    * It generates a new GCP project with a simple HTTP load balancing architecture (only one http service). 

#### Question 5 (bonus)

Create a [Chef](https://www.chef.io/) Cookbook to install a tool (as your convenience) to backup
databases (MySQL, MongoDB, etc..) and backup files (S3, Google Cloud Storage, etc...).
