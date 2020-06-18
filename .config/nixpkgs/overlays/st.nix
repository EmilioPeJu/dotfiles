self: super:

{
  st = super.st.override { conf = /home/user/st/config.h; };
}
