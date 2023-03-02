# Contributing to the Relaunch Community Web App

## Style guide

This project aims to follow these code style guides, deviating occasionally when
the Ruby on Rails community has significant discussion (*e.g.* double vs. single
quotes or string literals).

- [Ruby style guide](https://rubystyle.guide/)
- [Rails style guide](https://rails.rubystyle.guide/)
- [Rspec style guide](https://rspec.rubystyle.guide/)

The styleguide is enforced by the [Standard](https://github.com/testdouble/standard)
gem, and we aim to make few if any overrides to it, to keep things simple.

Also check out [betterspecs](https://betterspecs.org) for ideas on good rspec formatting!

**tl;dr**: if you follow the below checking/enforcement steps,
your code will be linted to follow the Standard gem's implementation/interpretation
of these style guides, so **don't worry!**

### Manually Checking/Enforcing styles

Note: Although useful, the auto-correct/auto-fix utilities provided by the linters we use,
discussed below, aren't perfect. It's important to review the changes they apply
before blindly commiting them!

#### Ruby linting (files matching `/*.rb$/i`)

1. To **view** all ruby offenses in the codebase, run
   ```sh
   rubocop
   ```
2. To **fix** all offenses in the codebase, run
   ```sh
   rubocop -A
   ```

For more details, refer to the [Rubocop](https://docs.rubocop.org/rubocop/1.46/usage/autocorrect.html) gem's
docs.

#### ERB linting (files matching `/*.erb$/i`)

1. To **view** all ruby offenses in the codebase, run
   ```sh
   bundle exec erblint --lint-all
   ```
2. To **fix** all offenses in the codebase, run
   ```sh
   bundle exec erblint --lint-all --autocorrect
   ```

For more details, refer to the [shopify/erblint](https://github.com/Shopify/erb-lint) gem docs.

### Automatically check/enforce the style guide

We use [pre-commit](https://pre-commit.com/) to automatically enforce the style-guide
on each git commit. Installing it is the best way to ensure your contributions
are in-line with the guide!

Simply install it, and it'll run with each `git commit`.

It'll tell you what's out-of-line. To have `rubocop` attempt to fix the issues
automatically, run,

```sh
rubucop -A
```

## Run the Dev Environment

### Requirements

The development environment currently requires a number of tools to support
development:

1. [docker](https://docs.docker.com/engine/install/)
2. [docker-compose](https://docs.docker.com/compose/install/)
3. \[OPTIONAL, **RECOMMENDED**\][Ruby 3.x+](https://www.ruby-lang.org/en/documentation/installation/)
   - This project uses [Foreman](https://github.com/ddollar/foreman) to configure
     the development environment via Procfile.
   - I recommend installing and managing ruby versions via [rbenv](https://github.com/rbenv/rbenv).

#### Option 1 (Recommended): Hybrid (docker+local) environment

Due to the inherent slowness of transferring volume data from host through to
the docker daemon, it's often preferable to develop with a hybrid environment.

This can dramatically decrease the friction of lag between changes made in, *e.g.*
your text editor/IDE, and them being seen within/across the docker containers/watchers.

##### Additional Requirements

1. This project depends on PostgreSQL (14 at time of writing), and installing the
   ruby drivers for the [pg](https://github.com/ged/ruby-pg) gem requires the libraries/headers for the C
   language front-end to be available locally on your host.
   - Ubuntu: `sudo apt-get install postgresql-dev`
   - OpenSUSE: `sudo zypper in postgresql14-devel`
2. To manage external/vendored dependencies, we use GitHub's [Licensed](https://github.com/github/licensed)
   project. This has a transient dependency on [CMake](https://cmake.org/)
   - Ubuntu: `sudo apt-get install cmake`
   - OpenSUSE: `sudo zypper in cmake`

##### Start the dev environment & dependencies

Assuming you're working with an environment supporting shell scripts,
execute the convenience script located at `./bin/dev` (`./bin/dev-docker` for
fully dockerized environments).

- This will start all relevant dev dependencies (*e.g.* PostgreSQL, Redis),
  the Rails server, Sidekiq background job processing, and a tailwind css
  watcher.

After the services start, you should be able to move on to the
[First-run preparation](#first-run-preparation) step.

**The web application is running at http://localhost:3000**

## First-run preparation

Once you've got the database and other dependencies up and running,
there are a few house-cleaning steps you'll need to take care of.

The following steps assume that the *previous* steps worked out just fine.

### Database Migrations

#### Hybrid environment

1. Start the dependent services
   ```sh
   bin/dev
   # Or, start JUST the database:
   # docker-compose up -d postgres
   ```
2. Create the development database
   ```sh
   bundle exec rails db:create
   ```
3. Run all relevant database migrations
   ```sh
   bundle exec rails db:migrate
   ```
4. Seed the database (if available/required)
   ```sh
   bundle exec rails db:seed
   ```

#### Docker environment

1. Start the `postgres` service
   ```sh
   docker-compose up -d postgres
   ```
2. Create the development database
   ```sh
   docker-compose run --rm --no-deps rails sh -c "rails db:create"
   ```
3. Run all relevant database migrations
   ```sh
   docker-compose run --rm --no-deps rails sh -c "rails db:migrate"
   ```
4. Seed the database (if available/required)
   ```sh
   docker-compose run --rm --no-deps rails sh -c "rails db:seed"
   ```

## Running Tests

### Hybrid environment

1. Start the dependent services
   ```sh
   bin/dev
   # Or, start JUST the database:
   # docker-compose up -d postgres
   ```
2. Create the development database
   ```sh
   bundle exec rails db:test:preprae
   ```
3. Run all relevant database migrations
   ```sh
   bundle exec rails rspec spec
   ```

### Docker environment

1. Start the `postgres` service
   ```sh
   docker-compose up -d postgres
   ```
2. Prepare the test database
   ```sh
   docker-compose run --rm \
                      --no-deps \
                      -e RELAUNCH_COMMUNITY_DATABASE_HOST="postgres" \
                      rails-test \
                      rails db:test:prepare
   ```
3. Run all tests
   ```sh
      docker-compose run --rm \
                      --no-deps \
                      -e RELAUNCH_COMMUNITY_DATABASE_HOST="postgres" \
                      rails-test
   ```

## Licensing/Legal

- [Individual Contributor License Agreement](#individual-contributor-license-agreement)
- [Privacy Policy](#privacy-policy)

### Individual Contributor License Agreement

This project requires an Individual Contributor License Agreement (ICLA) to be signed
by all contributors, to protect contributors and the Relaunch Community's rights.

Details are available at https://gist.github.com/momer/c6685b0ca4d2573b43c10a265d65bfa3

We use https://cla-assistant.io/ to help manage this!

### Privacy Policy

The Privacy Policy found at https://rmfs.com/privacy-policy applies to data
collection related to the ICLA and by other means or software
relating to the management of software contributors and/or software itself
(*e.g.* GitHub, GitLab, etc.).
