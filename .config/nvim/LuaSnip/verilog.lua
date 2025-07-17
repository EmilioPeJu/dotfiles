return {
    s(
        { trig = "mod" },
        fmt([[
            `default_nettype none
            module {} (
                {}
            );
            {}
            endmodule
        ]], {i(1), i(2), i(0)})
    ),
    s(
        { trig = "alw" },
        fmt([[
            always @(posedge clk_i) begin
                {}
            end
        ]], {i(0)})
    ),
    s(
       { trig = "if" },
       c(1, {
            fmt([[
                if ({}) begin
                    {}
                end]], {r(1, 'cond'), i(2)}),
            fmt([[
                if ({}) begin
                    {}
                end else begin
                    {}
                end]], {r(1, 'cond'), i(2), i(3)}),
            fmt([[
                if ({}) begin
                    {}
                end else if ({}) begin
                    {}
                end]], {r(1, 'cond'), i(2), i(3), i(4)}),
       })
    ),
    s(
       { trig = "case" },
       c(1, {
            fmt([[
                case ({}) begin
                    {}: {}
                endcase]], {r(1, 'expr'), r(2, 'val'), i(3)}),
            fmt([[
                case ({}) begin
                    {}: {}
                    default: {}
                endcase]], {r(1, 'expr'), r(2, 'val'), i(3), i(4)}),
       })
    ),
    s(
        { trig = "inst" },
        fmt([[
            {} {}_inst({}({}));
        ]], {i(1), rep(1), r(2, '.x'), i(3)})
    ),
    s(
        { trig = "for" },
        fmt([[
            generate
                for ({} = 0; {} < {}; {} = {} + 1) begin
                    {}
                end
            endgenerate
        ]], {r(1, 'i'), rep(1), r(2, '10'), rep(1), rep(1), i(0)})
    ),

}
