|%
+$  land  (map spot site)
+$  tuff  (map cite part)
+$  spot  [x=@ud y=@ud]
+$  site  (list cite)
+$  cite  @uw
+$  hole  [=cite part]
+$  part
  $_  ^?
  |%
  ++  name  *@tas
  ++  size  *@ud
  ++  char  *@tD
  ++  text  *@t
  ++  tick  |~(@dr *_^?(..size))
  ++  push  |~([=cite s=_^?(..size)] *(each [@t _^?(..size)] @t))
  ++  pull  |~(=cite *(each [@t _^?(..size)] @t))
  --
--
::
|%
++  player
  =|  her=ship
  =|  have=(list hole)
  |%
  ++  name  %player
  ++  size  100
  ++  char  '@'
  ++  text  (cat 3 'The adventurer they call ' (scot %p her))
  ++  tick  |=(@dr ..size)
  ++  push
    |=  =hole
    ?:  (gte size:hole 100)
      |+'Too big'
    &+[:((cury cat 3) text ' picks up ' text:hole) ..size(have [hole have])]
  ::
  ++  pull
    =|  had=(list hole)
    |=  =cite
    ?~  have
      |+'Don\'t have that item'
    ?:  =(cite cite.i.have)
      &+[(cat 3 'Dropped ' text:i.have) ..size(have (weld (flop had) t.have))]
    $(had [i.have had], have t.have)
  --
::
++  wood
  |%
  ++  name  %wood
  ++  size  50
  ++  char  '-'
  ++  text  'Some wood'
  ++  tick  |=(@dr ..size)
  ++  push  |=(hole |+(cat 3 text ' doesn\'t accept items'))
  ++  pull  |=(cite |+'Doesn\'t hold items')
  --
::
++  campfire
  =|  fuel=@dr
  |%
  ++  name  %campfire
  ++  size  30
  ++  char  'x'
  ++  text
    ?:  (gth fuel ~s0)
      'A crackling campfire'
    'The dying embers of a campfire'
  ::
  ++  tick
    |=  past=@dr
    ^+  ..size
    =.  fuel
      ?:  (gth past fuel)
        ~s0
      (sub fuel past)
    ..size
  ::
  ++  push  :: XX communicate to tuff that wood is gone?
    |=  =hole
    ^-  (each [@t _..size] @t)
    ?.  =(%wood name:hole)
      |+'Can only burn wood'
    &+['The fire increases' ..size(fuel (add fuel ~m2))]
  ::
  ++  pull  |=(=cite |+'Everything is burning')
  --
--
=/  nothing
  :*  `part`player
      `part`wood
      `part`campfire
  ==
::
|_  [lad=land tuf=tuff]
++  show-land
  ^-  wain
  =/  mex=spot
    %+  roll  ~(tap by lad)
    |=  [[spot *] m=spot]
    [(max x x.m) (max y y.m)]
  =|  spot
  |-  ^-  wain
  ?:  (gth y y.mex)
    ~
  :_  $(y +(y))
  %-  crip
  |-  ^-  tape
  ?:  (gth x x.mex)
    ~
  :_  $(x +(x))
  ?~  got=(~(get ja lad) x y)
    '.'
  char:(~(got by tuf) i.got)
::
++  examine
  |=  =spot
  ^-  wain
  ?~  got=(~(get by lad) spot)
    ['There\'s nothing there' ~]
  |-  ^-  wain
  ?~  u.got
    ~
  [text:(~(got by tuf) i.u.got) $(u.got t.u.got)]
::
++  next-tick
  |=  past=@dr
  ^-  tuff
  %-  ~(run by tuf)
  |=  =part
  (tick:part past)
--
