import os

# Upgrade SQLite
os.system("bash setup.sh")

# Confirm SQLite version
import sqlite3
print(f"!SQLite version: {sqlite3.sqlite_version}")

import streamlit as st
from needs_analyzer import NeedsAnalysisCrew
import json

# Initialize the needs analysis crew
analysis_crew = NeedsAnalysisCrew()

# Streamlit UI
st.title("Teresa AI")
st.text("Teresa AI is a simple AI agent that helps you discover local philanthropic needs and opportunities. Just enter your location.")

# Location input
location = st.text_input("Enter the location to analyze:", "")

if st.button("Analyze Needs"):
    if location:
        with st.spinner("Analyzing local needs..."):
            try:
                # Perform the analysis
                analysis = analysis_crew.analyze_area(location)

                # Display results
                st.subheader(f"Analysis for {location}")
                # st.json(analysis)  # Directly display the JSON-friendly result
                # Display each task's output in markdown format
                for task in analysis["tasks"]:
                    st.markdown(task["output"])

                # Add a download button for the JSON file
                st.download_button(
                    label="Download Analysis",
                    data=json.dumps(analysis, indent=2),
                    file_name=f"needs_analysis_{location}.json",
                    mime="application/json"
                )

            except Exception as e:
                st.error(f"Error: {str(e)}")
    else:
        st.warning("Please enter a location to analyze.")
