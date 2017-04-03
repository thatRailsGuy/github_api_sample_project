# Github API Sample Project

A sample app that uses the github API.

## Instructions
1. Copy application.yml.sample to application.yml and replace values for configuration. `cp config/application.yml.sample config/application.yml`
1. run `rake db:migrate`
1. run rails console `rails c`
1. Import an Organization (for example "lodash") by running `Organization.pull_from_github("lodash")`
