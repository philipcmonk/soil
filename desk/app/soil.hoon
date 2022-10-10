/+  shoe, s=soil, default-agent, verb, dbug
|%
+$  card  card:shoe
+$  versioned-state
  $%  state-0
  ==
::
+$  state-0
  $:  %0
      lad=land:s
      tuf=tuff:s
  ==
::
+$  sole-id  @ta
+$  command
  $%  [%move ?(%n %ne %e %se %s %sw %w %nw)]
      [%exam ~]
      [%take id=@uw]
      [%drop id=@uw]
      [%push id=@uw =part:s]
  ==
--

=|  state-0
=*  state  -
::
%-  agent:dbug
%+  verb  |
%-  (agent:shoe command)
^-  (shoe:shoe command)
=<
  |_  =bowl:gall
  +*  this       .
      soil-core  +>
      sc         ~(. soil-core bowl)
      def        ~(. (default-agent this %|) bowl)
      des        ~(. (default:shoe this command) bowl)
  ::
  ++  on-init
    ^-  (quip card _this)
    =.  lad  (~(add ja lad) [1 1] `@`our.bowl)
    =.  tuf  (~(put by tuf) `@`our.bowl %*(. player:s her our.bowl))
    `this
  ::
  ++  on-save  !>(state)
  ++  on-load
    |=  old-state=vase
    ^-  (quip card _this)
    =/  old  !<(versioned-state old-state)
    ?>  ?=(%0 -.old)
    `this(state old)
  ::
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    =^  cards  state
      ?+  mark        (on-poke:def mark vase)
        %noun         (poke-noun:sc !<(* vase))
      ==
    [cards this]
  ::
  ++  on-agent  on-agent:def
  ++  on-watch  on-watch:def
  ++  on-leave  on-leave:def
  ++  on-peek   on-peek:def
  ++  on-arvo   on-arvo:def
  ++  on-fail   on-fail:def
  ::
  ++  command-parser
    |=  =sole-id
    ~(parser sh:sc sole-id)
  ::
  ++  tab-list
    |=  =sole-id
    ~(tab-list sh:sc sole-id)
  ::
  ++  on-command
    |=  [=sole-id =command]
    =^  cards  state
      (~(work sh:sc sole-id) command)
    [cards this]
  ::
  ++  on-connect
    |=  =sole-id
    ^-  (quip card _this)
    [[~(prompt sh:sc sole-id)]~ this]
  ::
  ++  can-connect     can-connect:des
  ++  on-disconnect   on-disconnect:des
  --
::
|_  =bowl:gall
++  poke-noun
  |=  a=*
  ^-  (quip card _state)
  !!
++  s  ~(. ^s lad tuf)
::
++  sh
  |_  =sole-id
  ::  +effex: emit shoe effect card
  ::
  ++  effex
    |=  effect=shoe-effect:shoe
    ^-  card
    [%shoe ~[sole-id] effect]
  ::  +effect: emit console effect card
  ::
  ++  effect
    |=  effect=sole-effect:shoe
    ^-  card
    (effex %sole effect)
  ::  +tan: emit tang
  ::
  ++  tan
    |=  =tang
    (effect %tan tang)
  ::
  ++  parser
    %-  stew
    ^.  stet  ^.  limo
    :~
      ['8' ;~(pfix (just '8') (easy %& %move %n))]
      ['9' ;~(pfix (just '9') (easy %& %move %ne))]
      ['6' ;~(pfix (just '6') (easy %& %move %e))]
      ['3' ;~(pfix (just '3') (easy %& %move %se))]
      ['2' ;~(pfix (just '2') (easy %& %move %s))]
      ['1' ;~(pfix (just '1') (easy %& %move %sw))]
      ['4' ;~(pfix (just '4') (easy %& %move %w))]
      ['7' ;~(pfix (just '7') (easy %& %move %nw))]
      ['5' ;~(pfix (just '5') (easy %& %exam ~))]
      :-  ['a' 'z']
      ;~(pfix sym (easy %| %exam ~))
    ==
  ::
  ++  tab-list
    ^-  (list [@t tank])
    :~
      ['8' 'move north']
      ['9' 'move northeast']
      ['6' 'move east']
      ['3' 'move southeast']
      ['2' 'move south']
      ['1' 'move southwest']
      ['4' 'move west']
      ['7' 'move northwest']
      ['5' 'examine']
    ==
  ::
  ++  prompt
    ^-  card
    (effect %pro %& %soil-line ':' ~)
  ::
  ++  work
    |=  =command
    ^-  (quip card _state)
    ?+    -.command  [[(tan >command< ~) ~] state]
        %exam
      :_  state
      [(tan (examine:s 1 1)) (tan show-land:s) ~]
    ==
  --
--
