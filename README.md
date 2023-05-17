# QuickAndRuby

Gem to group utilities in ruby.

## install

```ruby
gem install quick_and_ruby
```

## bins

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
