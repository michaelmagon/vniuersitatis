# VNIUERSITATIS

## Install

### Clone the repository

```shell
git clone https://github.com/michaelmagon/vniuersitatis.git
cd vniuersitatis
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby ruby 2.6.5`

If not, install the right ruby version using [rvm](https://rvm.io/)

```shell
rvm install 2.5.1
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler)

```shell
bundle install
```

### Initialize the database

```shell
rails db:create db:migrate db:seed
```

## Serve

```shell
rails s
```

## Running Rspec Tests

```shell
rspec
```

## Running Cucumber Selenium Tests

Run server in test environment

```shell
rails s -e test
```

In a separate terminal

```shell
cucumber
```
