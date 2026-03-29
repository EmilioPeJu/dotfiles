return {
    s(
        { trig = "meta-" },
        fmt([[
            meta-{}:
              url: https://github.com/Xilinx/meta-{}
              path: sources/meta-{}
            {}
        ]], {i(1), rep(1), rep(1), i(0)})
    ),
}
