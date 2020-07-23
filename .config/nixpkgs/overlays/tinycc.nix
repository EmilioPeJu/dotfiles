self: super:

{
  tinycc= super.tinycc.overrideAttrs (oldAttrs: {
    src = ~/suckless/tcc/src;
  });
}

