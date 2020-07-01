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
    arg_parser.add_argument("--skipn", help="skip n elements",
                            type=int, default=0)
    return arg_parser.parse_args()


def main():
    args = parse_args()
    data = sys.stdin.read()
    data_arr = [float(item) for item in data.split() if is_number(item)]
    data_arr = data_arr[args.skipn:]
    print(f"average: {np.average(data_arr)}")
    print(f"std: {np.std(data_arr)}")
    plt.plot(data_arr)
    plt.show()


if __name__ == "__main__":
    main()
