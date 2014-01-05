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

name        = "renamer"
description = "renames .dae file internals"
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


print-stats = (d) ->
  console.log "Materials: "  , d.COLLADA.library_materials.material.length
  console.log "Effects: "    , d.COLLADA.library_effects.effect.length
  console.log "Visual scenes", d.COLLADA.library_visual_scenes.visual_scene.node.length
  console.log "Geometries: " , d.COLLADA.library_geometries.geometry.length
  console.log "Cameras:"     , d.COLLADA.library_cameras.camera.length


{ matches } = require('./config')

material-change = { } 
changed-names = []

sid = (s) ->
  _.str.splice(s, 0, 1, '')

change-node-id = (n, new-id) ->
  n.id = new-id
  n.name = new-id 
  n.sid = new-id

change-material = (node-material, new-material-name, n) ->
  old-material-name = sid node-material.target
  console.error "Scheduling material change: #old-material-name to #{new-material-name} for node #{n.id}"

  if not _.contains(changed-names, new-material-name)
    material-change[ old-material-name ] = { to: new-material-name }
    changed-names.push(new-material-name)

  node-material.target = "\##new-material-name"

fix-materials = (lm) ->
  for origin,destination of material-change
    for m in lm.material 
      if origin == m.name 
         destination.effect = m.instance_effect

  for origin, destination of material-change
    console.error "Committing material change: #{destination.to}"
    lm.material.push(name: destination.to, id: destination.to, instance_effect: destination.effect)

has-geometry-matching = (n) ->
  for m in matches 
    if n.instance_geometry?.url?
        if n.instance_geometry?.url.match(m.expression)

          change-node-id(n, "#{m.substitute}-#{n.id}")

          if n.instance_geometry.bind_material?.technique_common?.instance_material?

            p = n.instance_geometry.bind_material?.technique_common?.instance_material
            x = []

            if _.is-array(p)
              x = p 
            else 
              x.push(p)

            for e in x 
                ns = "#{m.substitute}-#{e.symbol}"
                if m.materials?[e.symbol]?
                  ns = m.materials[e.symbol]
                change-material(e, ns, n ) 



parse-node-tree = (root-node) ->
  for n in root-node.node 
    has-geometry-matching(n)
    if n.node?
      parse-node-tree(n)

require! 'optimist'

argv     = optimist.usage(usage-string,
              stats:
                alias: 's', description: 'print statistics', boolean: true

              help:
                alias: 'h', description: 'this help', default: false

                         ).boolean(\h).argv


if(argv.help)
  optimist.showHelp()
  return

command = argv._

if not command[0]?
  console.log "please specify input file"
  process.exit()

data = require("#cwd/"+command[0])

if argv.stats
  print-stats(data)
else 
 parse-node-tree(data.COLLADA.library_visual_scenes.visual_scene)
 fix-materials(data.COLLADA.library_materials)
 console.log '<?xml version="1.0" encoding="UTF-8"?>'
 console.log require('xml-mapping').dump(data);






