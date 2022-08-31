
# Drivy
- IMPORTANT: Starting from level2 drivy team incorrectly calculates the discounts, that is why all the `output.json` will be not the same as `expected_output.json`, for example in their calculations price with 10% discount, from 4000 is 3800. I used correct calculations and have the 3600 there.
- Model–View–Controller As Architectural Pattern
- Plain Ruby (Gems were added just for dev and test purposes, no runtime dependencies)
- Data Model is Ready To Be Used With SQL Storage (Singleton repositories here used to store models collections)
- I used the approach close to Rails `STI` to support 2 types of rentals with different pricing scale, with storing in one repository, to avoid overbooking between them
- [RSpec](https://github.com/rspec/rspec) For Tests
- 312 specs for all classes
- Tests Coverage 100.0% by [SimpleCov](https://github.com/colszowka/simplecov)
- Code Inspected by [RuboCop](https://github.com/rubocop-hq/rubocop), no issues
- [Pry](https://github.com/pry/pry) For Easy Debugging And Code Inspecting
- Added self written Rails-like validations and associations, with shared tests for them
- Patterns used: MVC, Presenters, repository, singleton, service objects, values objects etc
- Added deep exceptions processing, and boundary conditions processing, including validations for overbooking, several additional_insurance options, prices, dates etc
- Used metaprogramming for associations (to have Rails-like interface, and for example of it's usage)

## Requirements
- Ruby = 2.7

## Setup
- Goto `backend` folder in your terminal
- Run `bundle install`

## Dev Console
- run dev console with included project classes `bin/console`

## Running tests
- `$ bundle exec rspec spec/`

## Running examples
- Goto level dir e.g `level1` in your terminal
- run `$ ruby main.rb`

## Tests Coverage Report
- Goto `backend` folder in your terminal
- run `bundle exec rspec spec`
- Open In Browser `coverage/index.html`
