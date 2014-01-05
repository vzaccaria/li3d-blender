#!/usr/bin/env lsc
# options are accessed as argv.option

_       = require('underscore')
_.str   = require('underscore.string');
moment  = require 'moment'
fs      = require 'fs'
color   = require('ansi-color').set
os      = require('os')
shelljs = require('shelljs')
table   = require('ansi-color-table')
x       = require('xml2json')

_.mixin(_.str.exports());
_.str.include('Underscore.string', 'string');

name        = "xml2json"
description = "reads from stdin, spits on stdout"
author      = "Vittorio Zaccaria"
year        = "2013"

src = __dirname
otm = if (os.tmpdir?) then os.tmpdir() else "/var/tmp"
cwd = process.cwd()

setup-temporary-directory = ->
    name = "tmp_#{moment().format('HHmmss')}_tmp"
    dire = "#{otm}/#{name}" 
    shelljs.mkdir '-p', dire
    return dire

remove-temporary-directory = (dir) ->
    shelljs.rm '-rf', dir 
    
usage-string = """

#{color(name, \bold)}. #{description}
(c) #author, #year

Usage: #{name} [--option=V | -o V] 
"""

require! 'optimist'

argv     = optimist.usage(usage-string,
              help:
                alias: 'h', description: 'this help', default: false

                         ).boolean(\h).argv


if(argv.help)
  optimist.showHelp()
  return

command = argv._

ff = fs.readFileSync('/dev/stdin', 'utf-8')
console.log x.toJson(ff, {+reversible, +coerce})
