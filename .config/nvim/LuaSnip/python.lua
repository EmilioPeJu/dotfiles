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
    )
}
