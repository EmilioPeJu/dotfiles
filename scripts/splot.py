#!/usr/bin/env python
import argparse
import sys
import matplotlib.pyplot as plt
import numpy as np


def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False


def parse_args():
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument("--xvals", help="values in x axis", type=float,
                            nargs='+')
    arg_parser.add_argument("--title", default=None)
    arg_parser.add_argument("--xlabel", default=None)
    arg_parser.add_argument("--ylabel", default=None)
    arg_parser.add_argument("--intmode", action="store_true")
    arg_parser.add_argument("--save", default=None)
    return arg_parser.parse_args()


def main():
    args = parse_args()
    data = sys.stdin.read()
    cast = int if args.intmode else float
    yvals = [cast(item) for item in data.split() if is_number(item)]
    xvals = [cast(item) for item in args.xvals] if args.xvals \
        else [cast(item) for item in range(0, len(yvals))]
    print(f"x: {repr(xvals)}")
    print(f"y: {repr(yvals)}")
    print(f"len: {len(yvals)}")
    print(f"average: {np.average(yvals)}")
    print(f"std: {np.std(yvals)}")
    if args.title:
        plt.title(args.title)
    if args.xlabel:
        plt.xlabel(args.xlabel)
    if args.ylabel:
        plt.ylabel(args.ylabel)
    plt.plot(xvals, yvals)
    if args.save:
        plt.savefig(args.save)
    else:
        plt.show()


if __name__ == "__main__":
    main()
