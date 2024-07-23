return {
    s(
        { trig = "main" },
        fmt([[
            fn main() -> io::Result<()> {{
                let mut scan = Scan::new();
                {}
                Ok(())
            }}
        ]], {i(0)})
    ),
    s(
        { trig = "solve1" },
        fmt([[
            fn solve1(scan: &mut Scan) -> io::Result<()> {{
                {}
                Ok(())
            }}

            fn main() -> io::Result<()> {{
                let mut scan = Scan::new();
                let ts: usize = scan.next();
                for _ in 0..ts {{
                    solve1(&mut scan)?;
                }}
                Ok(())
            }}
        ]], {i(0)})
    ),
    s(
        { trig = "Scan" },
        fmt([[
            use std::collections::VecDeque;
            use std::io;

            struct Scan {{
                buffer: VecDeque<String>,
            }}

            impl Scan {{
                fn new() -> Scan {{
                    Scan {{
                        buffer: VecDeque::new(),
                    }}
                }}

                fn next_line(&self) -> io::Result<String> {{
                    let mut line = String::new();
                    match io::stdin().read_line(&mut line)? {{
                        0 => Err(io::Error::new(io::ErrorKind::Other, "EOF")),
                        _ => Ok(line),
                    }}
                }}

                fn next<T: std::str::FromStr>(&mut self) -> T {{
                    loop {{
                        if let Some(token) = self.buffer.pop_front() {{
                            match token.parse() {{
                                Ok(x) => {{
                                    return x;
                                }}
                                _ => {{
                                    panic!("parse");
                                }}
                            }}
                        }}
                        let line = self.next_line().unwrap();
                        self.buffer = line.split_whitespace().map(String::from).collect();
                    }}
                }}
            }}

            {}
        ]], {i(0)})
    ),
    s(
        { trig = "next_n" },
        fmt("(0..{}).map(|_| scan.next()).collect()", {i(1)})
    )
}
