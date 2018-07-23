# lua-flags
Lua package for command line options parsing.
You are able to use it wuith Tarantool.

## Usage example
``` lua
local flags = require('flags')
flags:string('s', 'myname')
flags:boolean('b')
flags:number('n', 0)
flags:table('t', {'127.0.0.1:8080'})
flags:parse(arg)

print(flags.values['s'])
print(flags.values['b'])
print(flags.values['n'])
print(table.getn(flags.values['r']))
```

```
lua myscript.lua -s test -t 127.0.0.1:8080 -t 127.0.0.1:8081 -n 5

test
false
5
2
```

```
lua myscript.lua -v

myname
true
0
1
```