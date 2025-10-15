{ }:
{
  enable = true;
  keyboards.default = {
    config = ''
      (defsrc
        esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        caps a    s    d    f    g    h    j    k    l    ;    '    ret
        lsft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt prtsc rctl
      )

      (deflayer base
        caps f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        @cap a    s    d    f    g    h    j    k    l    ;    '    ret
        lsft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt prtsc rctl
      )

      (deflayer apps
        _    _    _    _    _    _    _    _    _    _    _    _    _
        _    C-A-S-F1  C-A-S-F2  C-A-S-F3  C-A-S-F4  C-A-S-F5  C-A-S-F6    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _              _              _    _    _
      )

      (defalias
        ;; Tap for escape, hold for apps layer (200ms hold threshold)
        cap (tap-hold 100 200 esc (layer-while-held apps))
      )
    '';
  };
}
