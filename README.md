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

Every team must submit repositories with the following folder structure.

```
bin/
config/
db/
lib/
 views/
 models/ 
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

A Gemfile and bundler into your environment.rb that handles gem load dependencies. The result of which is that by correctly loading bundler, you will not need to `require 'anygems'` in your environment.rb besides bundler.

### C. a db directory

All databases should be located in db.

### D. a lib directory for your code.

All your classes must be located in lib/models. They should cover the bulk of the logic for the domain (project). They may not include requires or require relatives. Each file should be named according to model naming conventions, singular classes and corresponding file names, dog.rb defines a class Dog.

Any ERB templates should live in lib/views.

### E. spec directory. 

This should be the home of all your tests. Your tests should have a 1 to 1 model to spec ratio, so a dog.rb model should be tested by a dog_spec.rb. There should also be a spec_helper.rb that is required by all your tests, the only file required by an individual spec, and the spec_helper in turn should require your environment. 

You can easily add RSpec to a project using:

```
rspec --init
```

#### Bonus

Integrate the rspec-guard gem and a Guardfile so that you can autotest your project. That means on each file change, Guard will run your test suite.

Integrate SimpleCov and get 100% code coverage.

# Playlister-RB

Feel free to use:

- http://github.com/flatiron-school/playlister-rb
- http://github.com/aviflombaum/playlister-rb

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

It's okay if your LibraryParser class collaborates with Artist, Song, and Genre to create data. Step through the data and use the API (interface) defined by Song, Genre, and Artist to appropriately create the correct amount of data. Feel free to add methods that you feel you need (maybe Artist.find or overwriting a == for better object equality). Your LibraryParser class should live in the lib directory as well and required by your environment. 

I imagine that most of your programs, the site generator and the CLI will have to initialize a `LibraryParser` before running so that the program has data.

## CLI

Your CLI script should live in the bin directory 

## Site Generator

# Flatiron Students

Feel free to use: https://github.com/flatiron-school/003-School-Domain as a reference.

## Domain Model

The student class you need to build should pass the spec that are located in `flatiron-students/with-db/student_spec.rb`.

The idea is to build an easily modifiable and extensible Object-Relationship-Mapper that will let you access a student and their properties from a database. The model should be responsible for all database interactions, including creating the correct schema for any tables required, resetting the database, inserting students, querying students, etc.

Additionally, there will probably be a requirement for some methods that help the Student class interact with interfaces, for instance, an instance method `#url` that will generate a perdictable and consistent URL for a student, `avi_flombaum.url #=> 'avi-flombaum.html'` maybe.

Make the student class responsible for everything a student has to do in the two sections below.

Feel free to edit the test suite as needed. You should write and use the tests you think you need in order to flex the functionality of the model and ensure it works and behaves as expected.

You do not need to use any metaprogramming or make the class super abstract. You can hard code things (for instance, if you want a `::find_by_` method for every column, you don't need to use dynamic definition, you could just hardcode 10-12 methods.)

## Student Scraper

Once your classes are well defined with obvious functionality, such as having a name and being able to save a row to the database, your next goal is to create a scrapper class that can handle populating the database. Something like:

```ruby
scraper = StudentSiteScraper.new
scraper.call
```

That will use Nokogiri to parse the HTML of http://students.flatironschool.com and create local data using the Student class you built above. The class can collaborate as much as it needs with the other objects in the domain.

In terms of running the scrape for the CLI and Site Generator, I would imagine you would want to build some sort of functionality that can determine whether running the scrape is even required. For instance, maybe in your `cli.rb`, you might have code like:

```ruby
if Student.empty? # where Student.empty? checks the DB or something
  scraper = StudentSiteScraper.new
  scraper.call
end
```

Your scrape should be designed in an OO manner. Additionally, if you felt the need to define another class, maybe that represents an individual student's scrape logic `StudentScraper`, that gets initialized once for each student in the `StudentSiteScraper`, that might be nice. I would imagine then that `StudentSiteScraper` would mostly be responsible for finding the students to scrape and then delegating the scraping of each individual student profile url to `StudentScraper` and then instantiating and saving `Student` instances. So methods like `scrape_name` would be in `StudentScraper`. But design whatever is easiest to you.

## CLI

## Site Generator

