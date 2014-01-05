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

_module = ->

    matches = [
      { expression: "expedit_white_1x1"                   , substitute: "expedit-1x1-ikea"           , materials: { 'material-0': 'bianco-ikea'}}
      { expression: "expedit_white_2x2"                   , substitute: "expedit-2x2-ikea"           , materials: { 'material-0': 'bianco-ikea'}}
      { expression: "detail"                              , substitute: "vaso-anonimo" }
      { expression: "rattan"                              , substitute: "rattan-ikea" }
      { expression: "besta___60x40x64_white"              , substitute: "besta_60x40x64_white_ikea"  , materials: { 'material-0': 'bianco-ikea'}}
      { expression: "IDIKE_"                              , substitute: "besta_60x40x64_white_ikea"  , materials: { 'material-0': 'bianco-ikea'}}
      { expression: "besta___anta___60x64_grey_turquoise" , substitute: "besta_60x64_turquoise_ikea" , materials: { 'material-0': 'grigio-ikea'}}
      { expression: "IDIK_"                               , substitute: "besta_60x64_gray_ikea"      , materials: { 'material-0': 'grigio-ikea'}}
      { expression: "besta___anta___60x64_white"          , substitute: "besta_60x64_white_ikea"     , materials: { 'material-0': 'bianco-ikea'     , 'material-1': 'vetro'} }
      { expression: "fronts_BESTA_VARA"                   ,                                          , substitute: "besta_anta_cassetto_white_ikea" , materials: { 'material-0': 'bianco-ikea'}}
      { expression: "CDs"                                 , substitute: "pila-di-cd"}
      { expression: "Series_680"                          , substitute: "finestra-balcone"           , materials: { 'material-0': 'luce'} }
      { expression: "BESTA_Shelf_Glass"                   , substitute: "besta_mensola_vetro_ikea"   , materials: { 'material-0': 'vetro'} }
    ]

          
    iface = { 
        matches: matches 
    }
  
    return iface
 
module.exports = _module()





