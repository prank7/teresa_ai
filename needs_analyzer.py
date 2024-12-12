from datetime import datetime
from crewai import Agent, Task, Crew, Process
from crewai_tools import SerperDevTool
from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()

# Get API keys from environment variables
SERPER_API_KEY = os.getenv("SERPER_API_KEY")
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

# Set API keys for the respective services
os.environ["SERPER_API_KEY"] = SERPER_API_KEY
os.environ["OPENAI_API_KEY"] = OPENAI_API_KEY

# Initialize Serper search tool
search_tool = SerperDevTool()

# Define the agent
needs_analysis_agent = Agent(
    role="Needs Analyzer",
    goal="Analyze local community needs and identify opportunities for philanthropic intervention.",
    backstory="""
        You are an expert in community needs assessment and social impact analysis.
        Your role is to identify pressing community needs based on local news and organization data.
    """,
    tools=[search_tool],
    verbose=True
)

# Define the task
needs_analysis_task = Task(
    description="""
        Analyze the community needs for {location}.

        Steps:
        1. Gather recent news articles using the search tool.
        2. Identify key organizations supporting the community.
        3. Analyze gaps in community support systems.
        4. Provide actionable recommendations for philanthropic intervention.

        Deliver a report structured as:
        - Key community needs.
        - Existing support systems and gaps.
        - Recommendations for intervention.
        - Potential organizations to partner with.
    """,
    expected_output="""
        A structured analysis report with:
        1. Identified needs.
        2. Support system gaps.
        3. Recommendations for philanthropy.
        4. List of potential partners.
    """,
    agent=needs_analysis_agent
)

# Define the Crew
class NeedsAnalysisCrew:
    def __init__(self):
        self.crew = Crew(
            agents=[needs_analysis_agent],
            tasks=[needs_analysis_task],
            process=Process.sequential  # Execute tasks one at a time
        )

    def analyze_area(self, location: str):
        # Kickoff the analysis process with the provided location
        result = self.crew.kickoff(inputs={"location": location})

        print(f"{result} -<<<<< RESULTSSS")

        # Convert CrewOutput into a JSON-friendly dictionary
        serializable_result = {
            "tasks": [
                {
                    "description": getattr(task_output, "description", "N/A"),  # Task description
                    "output": getattr(task_output, "raw", "No output"),  # Task output
                    "success": True if getattr(task_output, "raw", None) else False,  # Success status
                    "errors": None,  # No errors field in TaskOutput
                }
                for task_output in result.tasks_output  # Iterate over tasks_output list
            ],
            "result": result,
            "metadata": {
                "timestamp": datetime.now().isoformat(),
                "location": location
            }
        }

        return serializable_result
