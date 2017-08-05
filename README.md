# pid_usage

A tool that get info of pid cpu and memory usage, inspire by https://github.com/soyuka/pidusage

> Just test on osx and ubuntu.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  pid_usage:
    github: aiasfina/pid_usage
```

## Usage

```crystal
require "pid_usage"

PidUsage::State.info(pid)
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/[your-github-name]/pid_usage/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[your-github-name]](https://github.com/[your-github-name]) apan - creator, maintainer
