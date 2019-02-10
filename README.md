# Sam Miller's Blog

[![Amber Framework](https://img.shields.io/badge/using-amber_framework-orange.svg)](https://amberframework.org)

This is a project written using [Amber](https://amberframework.org). Enjoy!

## Getting Started

These instructions will get a copy of this project running on your machine for development and testing purposes.

### Prerequisites

This project requires [Crystal](https://crystal-lang.org/) ([installation guide](https://crystal-lang.org/docs/installation/)).

This project requires [Docker](https://docs.docker.com/install/).

### Development

Development is done with Docker

To start up the app in development:

1. Build the containers with `docker-compose build`
2. Run the containers with `docker-compose up`
3. Visit [localhost:3000](http://localhost:3000) to see the app!

### Production

Production is also served via Docker

This will launch the app on port 80 and bind it to 0.0.0.0

1. Build the containers with `docker-compose -p sam-blog-prod -f docker-compose.prod.yml build`
2. Run the containers with `docker-compose -p sam-blog-prod -f docker-compose.prod.yml up -d`
3. Visit [localhost](http://localhost) to see the production app!
4. Logs are visible with `docker-compose -p sam-blog-prod logs -f --tail=500`

## Contributing

1. Fork it ( https://github.com/jhonnold/sam-blog/fork )
2. Create your feature branch ( `git checkout -b my-new-feature` )
3. Commit your changes ( `git commit -am 'Add some feature'` )
4. Push to the branch ( `git push origin my-new-feature` )
5. Create a new Pull Request

## Contributors

- [jhonnold](https://github.com/jhonnold) Jay Honnold - creator, maintainer
