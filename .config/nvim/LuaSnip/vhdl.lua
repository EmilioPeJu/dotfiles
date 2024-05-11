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
            end {};
        ]], {i(1), i(0), rep(1)})
    ),
    s(
        { trig = "arch" },
        fmt([[
            architecture rtl of {} is
            begin
                {}
            end rtl;
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
        fmt([[
            {}_inst : entity work.{} port map (
                {}
            );
        ]], {rep(1), i(1), i(0)})
    ),
    s(
       { trig = "if" },
       fmt("if {} then\n{}\nend if;", {i(1), i(0)})
    ),
    s(
        { trig = "(ot" },
        t("(others => '0')")
    ),
    s(
        { trig = "s" },
        t("std_logic")
    ),
    s(
        { trig = "slv" },
        t("std_logic_vector")
    ),
}
