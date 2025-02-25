# QuickAndRuby

Gem to group utilities in ruby.

## install

```ruby
gem install quick_and_ruby
```

## bin's

### proxy

### datetime

Used to manipulate date:
- allow to compute all increment between 2 dates.
- allow to compute a date starting form another/now.

Usage:
``` shell
datetime -o <offset> -i <incr> -f "<format>" <from>|now <to>|now

datetime -o <offset> -i <incr> -f "<format>" <from>|now
```

### epoch

Convert epoch and time.

Usage:

``` shell
# time to epoch
epoch 2025-01-01T01:01:01.000Z
1735693261

# epoch to time UTC
epoch -u 1735693261
2025-01-01T01:01:01.000Z

# epoch to time (local time zone)
epoch 1735693261
2025-01-01T02:01:01.000+01:00

# time to epoch millis
epoch -m 2025-01-01T01:01:01.123Z
1735693261123
```

### yaml2json

Convert yaml formated string, file or stdin to json format.

usage:

``` shell
yaml2json file.json
# ... generates file.json

yaml2json 'msg: test'
# {
#   "msg": "test"
# }

echo 'msg: test' | yaml2json
# {
#   "msg": "test"
# }
```

### json2yaml

Convert json formated string, file or stdin to yaml format.

usage:

``` shell
json2yaml file.json
# ... generates file.yaml

json2yaml '{"msg": "test"}'
# ---
# msg: test

echo '{"msg": "test"}' | json2yaml
# ---
# msg: test
```
