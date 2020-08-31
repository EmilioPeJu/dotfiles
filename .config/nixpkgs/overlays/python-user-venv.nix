self: super:

{
  python-user = super.python3.withPackages (pp: with pp; [ pyzmq ]);
  python-user-venv = super.buildEnv {
    name = "python-user-venv";
    paths = [ self.python-user ];
  };
}
