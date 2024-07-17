return {
    s(
        { trig = "lib" },
        fmt([[
            library ieee;
            use ieee.std_logic_1164.all;
            use ieee.numeric_std.all;
            {}
        ]], {i(0)})
    ),
    s(
        { trig = "ent" },
        fmt([[
            entity {} is
                port (
                    {}
                );
            end;
        ]], {i(1), i(0)})
    ),
    s(
        { trig = "arch" },
        fmt([[
            architecture rtl of {} is
            begin
                {}
            end;
        ]], {i(1), i(0)})
    ),
    s(
        { trig = "proc" },
        fmt([[
            process (clk_i)
            begin
                if rising_edge(clk_i) then
                    {}
                end if;
            end process;
        ]], {i(0)})
    ),
    s(
        { trig = "sig" },
        fmt("signal {} : {};\n{}", {i(2), i(1), i(0)})
    ),
    s(
        { trig = "inst" },
        c(1, {
            fmt([[
                {}_inst : entity work.{} port map (
                    {}
                );
            ]], {rep(1), i(1), i(2)}),
            fmt([[
                {}_inst : entity work.{} generic map (
                    {}
                ) port map (
                    {}
                );
            ]], {rep(1), i(1), i(2), i(3)})
        })
    ),
    s(
       { trig = "if" },
       c(1, {
            fmt([[
                if {} then
                    {}
                end if;]], {r(1, 'cond'), i(2)}),
            fmt([[
                if {} then
                    {}
                else
                    {}
                end if;]], {r(1, 'cond'), i(2), i(3)}),
            fmt([[
                if {} then
                    {}
                elsif {} then
                    {}
                end if;]], {r(1, 'cond'), i(2), i(3), i(4)}),
       })
    ),
    s(
       { trig = "case" },
       fmt([[
            case {} is
                {}
            end case;
        ]], {i(1), i(2)})
    ),
    s(
        { trig = "(ot" },
        t("(others => '0')")
    ),
    s(
        { trig = "sl" },
        t("std_logic")
    ),
    s(
        { trig = "slv" },
        t("std_logic_vector")
    ),
    s(
        { trig = "w" },
        fmt("when {} else", {i(1)})
    ),
}
