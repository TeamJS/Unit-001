# Learning Objectives

- git workflow
- Understand require vs require_relative, loading multiple project files.

# General Guidelines

## Deliverables

- Per team, one repackaged version of the playerlister app in a new repository called
  "playlister-rb-unit-1"
- Per team, one repackaged version of the students app in a new repository called
  "flatiron-students-unit-1"

## Source Files

All the files you need for these projects are located on:

https://github.com/flatiron-school/ruby-003-unit-1

Because I want you to work on packaging projects and going from start to finish, you should clone these files and copy them into your working directories (probably one for each project).

## Project Structure

Every team must submit a repository with the following folder structure.

```
bin/
config/
db/
lib/
spec/
README.md
```

### A. A bin directory

Your program must be runnable from the command line from a single ruby file, called an executable (or a bin/ary), perhaps passing in command line arguments, but honestly, I don't see why you wouldn't be able to hard code those. So for example, from within the root directory of the student-site-generator, you should be able to:

```
ruby bin/generate.rb
```

and end up with the desired result.

or for a command line program of the student site.

```
ruby bin/cli.rb
```

#### Bonus

Your executables located in your bins may only include a single instantiation and method call, not including any parsing or passing of arguments, a require, along with code related to loading an environment. All in all, more than 4-8 lines of code is probably doing it wrong. Not including data, the RSpec executable (oddly located in a directory called exe), is 7 loc (lines of code). https://github.com/rspec/rspec-core/blob/master/exe/rspec

This should require discovering and defining some new objects, however, could also just use a nice require sort of like rspec does above.

### B. An environment.rb file.

You must build an environment.rb file that will load all the dependencies of your project. This file, when loaded into irb, should provide you with a current environment with which to manipulate all your classes. So it should load all the dependencies, classes, models, gems, etc, that are needed for any other file or a developer to load your project into memory.

#### Bonus

Figure out how to account for different environments. You'll probably notice that when you run your test suite, if it's dropping and adding the database, you might be losing meaningful data, forcing you to re-run the scrape or data collection mechanism. Your classes, could in theory (and in practice), account for different database files for different environments, keeping your tests always using a different, disposable, database.

### C. a db directory

All databases should be located in db.

### D. a lib directory for your models.

All your classes must be located in lib. They should cover the bulk of the logic for the domain (project). They may not include requires or require relatives. Each file should be named according to model naming conventions, singular classes and corresponding file names, dog.rb defines a class Dog.

### E. spec directory. 

This should be the home of all your tests. Your tests should have a 1 to 1 model to spec ratio, so a dog.rb model should be tested by a dog_spec.rb. There should also be a spec_helper.rb that is required by all your tests, the only file required by an individual spec, and the spec_helper in turn should require your environment. 

You can easily add RSpec to a project using:

```
rspec --init
```

## Bonus Challenges

Integrate:

A. the rspec-guard gem and a Guardfile so that you can autotest your project. That means on each file change, Guard will run your test suite.

B. A Gemfile and bundler into your environment.rb that handles gem load dependencies. The result of which is that by correctly loading bundler, you will not need to `require 'anygems'` in your environment.rb besides bundler.

C. Integrate SimpleCov and get 100% code coverage.

1. Playlister-RB CLI + Site Generator

2. Flatiron Students CLI + Site Generator

# Playlister-RB

## Domain Model

Included in the ruby-003-unit-1 repository are spec files to use as guidelines for your artist, genre, and song models. Complete a song_spec.rb as those tests are marked pending. Your playlister-rb models should be based of these and tested against these.

## Data Parser

Included in the ruby-003-unit-1 repository is a data directory that has 99 fake mp3s in it. Your goal is to design a class that can parse those file names and use the data to create appropriate artist, genre, and song instances.

Something like:

```ruby
parser = LibraryParser.new('/Users/avi/fs-playlister-rb/db/data')
parser.call
```

After that, if I was to call `Artist.all.first` I would see the instance representing the Artist Action Bronson. Furthermore, `Artist.all.first.songs` should include the Song instance representing Larry Csonka. Calling `genre` on that instance should return the genre indie. Additionally, calling `songs` on that indie genre should return even more songs, etc.

It's okay if your LibraryParser class collaborates with Artist, Song, and Genre to create data. Step through the data and use the API (interface) defined by Song, Genre, and Artist to appropriately create the correct amount of data. Feel free to add methods that you feel you need (maybe Artist.find or overwriting a == for better object equality). Your LibraryParser class should live in the lib directory as well and loaded by your environment. 

## CLI

Your CLI script should live in the bin directory 

## Site Generator

# Flatiron Students

## Domain Model

## Site Scraper

## CLI

## Site Generator

*Bonus* Integrate Classes / Modules
*Bonus* Abstract The CLI and Site Generator
Simplecov
