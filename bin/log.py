#!/usr/bin/env python

from datetime import date, datetime
from pathlib import Path
import csv
import os
import sys

if len(sys.argv) != 2:
    print("Usage: {} 'job to be logged'".format(sys.argv[0]))
    exit(1)

log_dir = "{}/time_logs".format(Path.home())
if not os.path.isdir(log_dir):
    os.mkdir(log_dir)

csv_file = "{}/{}_time_log.csv".format(log_dir, date.today())
csv_fields = ["job", "start", "end", "duration"]
job = sys.argv[1]


def now_string():
    return datetime.now().isoformat(timespec="seconds")


def new_row(job):
    return {"job": job, "start": now_string()}


def complete_row(row):
    row["end"] = now_string()

    start = datetime.fromisoformat(row["start"])
    end = datetime.fromisoformat(row["end"])

    row["duration"] = str(end - start)

    return row


if os.path.isfile(csv_file):
    with open(csv_file) as fh:
        rows = list(csv.DictReader(fh))
        rows[-1] = complete_row(rows[-1])
        rows.append(new_row(job))
else:
    rows = [new_row(job)]

with open(csv_file, "w") as fh:
    writer = csv.DictWriter(fh, csv_fields)

    writer.writeheader()
    writer.writerows(rows)
