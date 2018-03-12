# MoviesStar

Search/Favorite popular movies from base in api of [MovieDB](https://developers.themoviedb.org/3/getting-started/introduction).

## Getting Started

### Environment prerequisites

#### Ruby

If yon don't have experience with Ruby we recommend [rbenv](https://github.com/rbenv/rbenv):

```sh
brew install rbenv
rbenv init
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
```

Install the Ruby version used on the project:

```sh
rbenv install `cat .ruby-version`
```

#### Bundler

```sh
gem install bundler
```

### Fastlane

#### Run tests

- To generate and open coverage report:

```sh
bundle exec fastlane test
```

#### Dependencies

- Kingfisher
- Snapkit
- Quick/Nimble
- KIF 



