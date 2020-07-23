self: super:

{
  runit= super.runit.overrideAttrs (oldAttrs: {
    src = ~/suckless/runit/admin;
  });
}

