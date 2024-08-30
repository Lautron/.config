#!/sbin/python

import re
import glob
import os
import subprocess


def get_fig_num(filename):
    regx = re.search(r"fig(\d+)", filename)
    return int(regx.group(1))


def get_latest_fig_num(directory):
    files = glob.glob(f"{directory}*.png")
    result = 0
    if files:
        latest = max(files, key=get_fig_num)
        result = get_fig_num(latest)

    return result


def get_new_fig_path(basename):
    directory = f"./{basename}_figs/"
    os.makedirs(directory, exist_ok=True)
    num = get_latest_fig_num(directory) + 1
    return f"{directory}fig{num}.png"


def handle_xournalpp(basename):
    png_path = get_new_fig_path(basename)
    xopp_path = png_path.replace("png", "xopp")
    commands = " && ".join([
        f'xournalpp "{xopp_path}"',
        f'get-png "{xopp_path}"',
    ])
    subprocess.Popen(commands, shell=True)
    print(f"![]({png_path})")


if __name__ == "__main__":
    import sys
    basename = "".join(sys.argv[1].split(".")[:-1])
    handle_xournalpp(basename)
