# Check Monocle

A test suite built with [RSpec](http://rspec.info/), [Capybara](http://teamcapybara.github.io/capybara/) and [Poltergeist](https://github.com/teampoltergeist/poltergeist) in order to validate latest and soon to be released radio shows have correct content and assets.

Using [CircleCI](https://circleci.com/gh/lukemorton/check-monocle/tree/master) we run these checks at 19:00 UTC every day.

**Coming soon:** We will setup a Slack integration with CircleCI which will then mean the test results, and in particular, test failures can be posted into a channel so the team can be made aware.

## How does it work?

Using feature testing tools common in the ruby on rails community we make requests to the website and make assertions against the DOM.

- [RSpec](http://rspec.info/): Is a test runner, it executes the tests for us and produces output either on the command line or in a format that CircleCI recognises, depending on how it is run.
- [Capybara](http://teamcapybara.github.io/capybara/): Provides some features to RSpec that allows us to visit web pages and assert their contents.
- [Poltergeist](https://github.com/teampoltergeist/poltergeist): Is a driver for Capybara that uses PhantomJS behind the scenes to browser web pages with JavaScript enabled. You can also use Poltergeist to take screenshots of web pages automatically.

There are additional tools used to run the scripts on your own machine:

- [Docker](https://www.docker.com/)
- [Make](https://www.gnu.org/software/make/manual/make.html)

### Directories and files in this project

There are a few important directories and files to discuss.

[**`lib/`**](lib): Contains helper library classes that can be used in tests.

[**`spec/`**](spec): Contains all the tests, have a browse yourself. You will notice a `spec_helper.rb` which sets up RSpec to use Capybara and Poltergeist. You will also see files ending in `_spec.rb`, these are RSpec test files.

[**`circle.yml`**](circle.yml): Configures CircleCI to run the tests whenever there are new commits pushed to GitHub and also nightly.

**[`Dockerfile`](Dockerfile) and [`docker-compose.yml`](docker-compose.yml)**: When running this project on your own machine, you can use Docker so that you do not need to install ruby and other dependencies yourself.

**[`Gemfile`](Gemfile) and [`Gemfile.lock`](Gemfile.lock)**: These are files that manage our ruby dependencies for us.

[**`Makefile`**](Makefile): When running this project on your own machine, instead of typing long Docker commands yourself you can use make commands.

## Local development

### Prerequisites

- Install [Docker](https://docs.docker.com/engine/installation/) or make sure your current version is up to date
- Check `make` is installed by running `make -v` in your terminal

### Installing

Checkout this project with git:

```
git clone https://github.com/lukemorton/check-monocle.git
cd check-monocle
```

Now run the default make command which will install everything and then run the tests:

```
make
```

### Running tests many times

When running `make` we spend some time booting up a Docker container to run the tests in before executing the tests. There is a quicker way to run the tests if you are developing.

First of all, we need to shell into the Docker container's own command line:

```
make shell
```

Now we are in the container's own command line we can run RSpec directly:

```
bundle exec rspec
```

See, much faster wasn't it? Have fun!
