#!/usr/bin/env python3
import json
import re
import subprocess


def main():
    task_context = subprocess.check_output(["task", "context", "show"])
    context_match = re.match("Context '([^']*)' with filter '([^']+)'",
                             task_context.decode())
    task_cmd = ["task"]
    if context_match:
        context_filter = context_match.group(2)
        task_cmd.append(context_filter)
    task_cmd.append("export")
    task_output = subprocess.check_output(task_cmd)
    data = [item for item in json.loads(task_output) if item["status"] == "pending"]
    data.sort(key=lambda x: x["urgency"], reverse=True)
    if data:
        print(data[0]['description'])


if __name__ == "__main__":
    main()
