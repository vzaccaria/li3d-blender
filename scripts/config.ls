_               = require('underscore')
_.str           = require('underscore.string');
moment          = require 'moment'
fs              = require 'fs'
color           = require('ansi-color').set
{ spawn, kill } = require('child_process')
__q             = require('q')
sh              = require('shelljs')
os              = require('os')
shelljs         = sh
ut              = require('utf-8')
winston         = require('winston')

disp-ok = -> 
  winston.info "Ok"
  
disp-ko = -> 
  winston.error it.toString()
  
disp    = winston.info
pdisp   = console.log
pdeb    = winston.warn

_.mixin(_.str.exports());
_.str.include('Underscore.string', 'string');

o = (x, s, mt) ->
  { expression: x, substitute: s, materials: mt }

ikea-bianco       = { 'material-0': 'bianco-ikea' }
ikea-grigio       = { 'material-0': 'grigio-ikea'}
ikea-bianco-vetro = { 'material-0': 'bianco-ikea', 'material-1': 'vetro' }
luce              = { 'material-0': 'luce' }
vetro             = { 'material-0': 'vetro'}

_module = ->

    matches = [
      o "expedit_white_1x1"                   , "expedit-1x1-ikea"               , ikea-bianco
      o "expedit_white_2x2"                   , "expedit-2x2-ikea"               , ikea-bianco
      o "detail"                              , "vaso-anonimo" 
      o "rattan"                              , "rattan-ikea"
      o "besta___60x40x64_white"              , "besta_60x40x64_white_ikea"      , ikea-bianco
      o "IDIKE_"                              , "besta_60x40x64_white_ikea"      , ikea-bianco
      o "besta___anta___60x64_grey_turquoise" , "besta_60x64_turquoise_ikea"     , ikea-grigio
      o "IDIK_"                               , "besta_60x64_gray_ikea"          , ikea-grigio 
      o "besta___anta___60x64_white"          , "besta_60x64_white_ikea"         , ikea-bianco-vetro
      o "fronts_BESTA_VARA"                   , "besta_anta_cassetto_white_ikea" , ikea-bianco
      o "CDs"                                 , "pila-di-cd"
      o "Series_680"                          , "finestra-balcone"               , luce
      o "BESTA_Shelf_Glass"                   , "besta_mensola_vetro_ikea"       , vetro 
    ]

    cameras = [
      { source: "Camera1", dest: "cam1" }
      { source: "Camera2", dest: "cam2" }
    ]

          
    iface = { 
        matches: matches 
        cameras: cameras
    }
  
    return iface
 
module.exports = _module()





