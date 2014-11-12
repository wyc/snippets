# Description:
#   Evaluate Simple S-Expressions
#
# Dependencies:
#   None
#
# Commands:
#   See definition of @symbols
#   e.g.
#   (+ 1 (+ 1 2))
#   (append abc efg)
#   (if (= 1 1) correct incorrect)
#   
#
# Features:
#   As many unmatched )'s as you'd like.
#   No type enforcement
#   No variables yet
#
# Author:
#   wyc

class Sexpr

  constructor: (@robot) ->
    @symbols = {
      'car': (xs) -> xs[0]
      'cdr': (xs) -> xs[1..]
      '+': (x, y) -> x + y
      '-': (x, y) -> x - y
      '*': (x, y) -> x * y
      '/': (x, y) -> x / y
      '%': (x, y) -> x % y
      'sum': (xs) -> xs.reduce (x, y) -> x + y
      'append': (x, y) -> x.concat(y)
      'concat': (xs) -> xs.reduce (x, y) -> x.concat(y)
      '=':  (x, y) -> x == y
      '<':  (x, y) -> x < y
      '<=': (x, y) -> x <= y
      '>':  (x, y) -> x > y
      '>=': (x, y) -> x >= y
      # @todo add karma features
    }

    @lazySymbols = {
      'if': (x, y, z) -> if this.eval(x) then this.eval(y) else this.eval(z)
    }

  eval: (ast) ->
    if ast[0] of @symbols
      p = []; p[i] = this.eval(v) for v, i in ast[1..]
      @symbols[ast[0]].apply(this, p)
    else if ast[0] of @lazySymbols
      @lazySymbols[ast[0]].apply(this, ast[1..])
    else if ast instanceof Array
      p = []; p[i] = this.eval(v) for v, i in ast; p
    else ast

  parse: (ts) ->
    throw "unmatched (" if ts.length == 0
    t = ts.shift()
    if t == '('
      list = []; list.push(this.parse(ts)) while ts[0] != ')'
      ts.shift()
      list
    else
      if      t of @symbols                then t
      else if t.match /^-?[0-9]+\.[0-9]+$/ then parseFloat t
      else if t.match /^-?[0-9]+$/         then parseInt t
      else                                 "#{t}"

  tokenize: (s) ->
    ts = s.replace(/\(/g, ' ( ').replace(/\)/g, ' ) ').split(' ')
    ts.splice(i, 1) while (i = ts.indexOf('')) != -1
    ts

  toString: (r) ->
    if r instanceof Array
      s = '( '; s += "#{this.toString(v)} " for v in r; s += ')'; s
    else
      "#{r}"

module.exports = (robot) ->
  sexpr = new Sexpr robot
  robot.respond /(\(.*?\))$/, (msg) ->
    match = msg.match[1] # msg.match[1].toLowerCase()
    try
      ts = sexpr.tokenize match
      ast = sexpr.parse ts.slice(0)
      result = sexpr.eval(ast)
      s = sexpr.toString(result)
      msg.send "#{msg.message.user.name}: #{s}"
    catch e
      msg.send "#{msg.message.user.name}: #{e}"

