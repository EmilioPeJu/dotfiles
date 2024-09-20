return {
    s(
        { trig = "#!" },
        { t("#!/usr/bin/env python") }
    ),
    s(
        { trig = "ifmain" },
        {
            t({"def main():", "\t"}),
            i(0),
            t({"", "", "", "if __name__ == '__main__':", "\tmain()"}),
        }
    ),
    s(
        { trig = "parse_args" },
        fmt([[
            def parse_args():
                parser = argparse.ArgumentParser()
                parser.add_argument({})
                return parser.parse_args()
        ]], {i(0)})
    ),
    s(
        { trig = "cocotb" },
        fmt([[
            import cocotb

            from cocotb.clock import Clock
            from cocotb.triggers import RisingEdge, ClockCycles, ReadOnly
            from cocotb_tools.runner import get_runner


            @cocotb.test()
            def example_test(dut):
                cocotb.start_soon(Clock(dut.clk_i, 1, 'ns').start(start_high=False))
                {}


            def test_{}():
                runner = get_runner('ghdl')
                runner.build(sources=[ '{}.vhd' ],
                             hdl_toplevel='{}',
                             build_args=['--std=08'],
                             always=True)
                runner.test(hdl_toplevel='{}', test_args=['--std=08'],
                            plusargs=['--vcd={}.vcd'],
                            test_module='test_{}')
        ]], {i(0), i(1), rep(1), rep(1), rep(1), rep(1), rep(1)})
    ),
}
