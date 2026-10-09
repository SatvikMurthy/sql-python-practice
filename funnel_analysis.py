"""A beginner Python script: build a hiring funnel from sample data.

This is a learning project. The data in candidates.csv is made up.
Run it with:  python funnel_analysis.py
"""
import pandas as pd

# The stages in the order candidates move through them
STAGES = ["Sourced", "Screened", "Interviewed", "Shortlisted", "Offered", "Joined"]

# Read the CSV file into a table (a "DataFrame")
df = pd.read_csv("candidates.csv")

# Turn each stage name into a number, so we can ask "reached this stage or further?"
stage_number = {stage: i + 1 for i, stage in enumerate(STAGES)}
df["stage_no"] = df["furthest_stage"].map(stage_number)

# For each stage, count candidates who reached it or went further
reached = [int((df["stage_no"] >= n).sum()) for n in range(1, len(STAGES) + 1)]

print("Stage        Reached   % of sourced   Conversion from previous")
for i, stage in enumerate(STAGES):
    pct_sourced = reached[i] / reached[0] * 100
    conversion = "-" if i == 0 else f"{reached[i] / reached[i - 1] * 100:.1f}%"
    print(f"{stage:<12} {reached[i]:>7}   {pct_sourced:>10.1f}%   {conversion:>10}")

# Average days in process by source
print("\nAverage days in process by source:")
print(df.groupby("source")["days_in_process"].mean().round(1))
