# Core
Integrating every business application


## Getting Started
Adding in Docker support which will hopefully make it easier for you guys to get started.

If you aren't familier with Docker it is a container technology that lets you quickly deploys apps. You can checkout a 5 minute intro here: [Docker in 5 Minutes](https://www.youtube.com/watch?v=Av2Umb6nELU)

You can download the [Docker Toolbox](https://www.docker.com/products/docker-toolbox) to get started.
Once you have docker intalled you should be able to make a machine, and start the app by doing:

    docker-compose up

This will look at `docker-compose.yml` and bring up 2 services: the rails app and a postgres database. You will need to create and run database migrations by doing this:

    docker-compose run web rake db:create db:migrate

I have brought in Devise and Omniauth for authentication and API access. I have added Stripe and Quickbooks integrations as well.
We should start with Stripe, Quickbooks still needs some work.

## Configs

We manage configs in the `.env` file. You will need to fill in the blanks with our tokens from stripe and quickbooks. These shouldn't be checked in to git- they are dependent on the environment. Development and Production will use different tokens.
