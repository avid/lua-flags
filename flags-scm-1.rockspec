package = 'flags'

version = 'scm-1'

source  = {
    url    = 'git://github.com/avid/lua-flags.git',
    branch = 'master'
}

description = {
    summary  = "Lua package for command line options parsing"
}

-- Lua version and other packages on which this one depends
-- Tarantool currently supports strictly Lua 5.1
dependencies = {
    'lua == 5.1'
}

build = {
    type = 'builtin',

    modules = {
        ['flags'] = 'flags/flags.lua',
    }
}
