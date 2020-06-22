self: super:

{
  st = (super.st.override {
    conf = (builtins.readFile ~/st/config.h);
  }).overrideAttrs (oldAttrs: {
    src = super.fetchgit {
      url = " https://git.suckless.org/st";
      rev = "refs/heads/master";
      sha256 = "01z6i60fmdi5h6g80rgvqr6d00jxszphrldx07w4v6nq8cq2r4nr";
    };
  });
}
