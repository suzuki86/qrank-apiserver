# qrank-apiserver

This application provides RESTful API for various purposes.

## Features

- Crawl Qiita API and store data.
- Provide JSON API by using stored data.

## Usage

### Runner

#### QrankRunner#get_entries

Get entries and store them to database.

```
bundle exec rails runner QrankRunner.get_entries
```

If page number is passed as argument, entries in the specified page are performed. Example like below gets entries from page of 2. 

```
bundle exec rails runner QrankRunner.get_entries(2)
```
