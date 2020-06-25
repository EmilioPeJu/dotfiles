#!/usr/bin/env python3
import json
import subprocess

def main():
    task_output = subprocess.check_output(["task", "export"])
    data = json.loads(task_output)
    data.sort(key=lambda x: x["urgency"], reverse=True)
    print(data[0]["description"])


if __name__ == "__main__":
    main()
