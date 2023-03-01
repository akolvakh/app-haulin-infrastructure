import json
import logging
import os
import urllib
import requests
import urllib.request
import urllib.error
import urllib.parse
from urllib.error import URLError, HTTPError
from urllib.request import Request, urlopen
import boto3

# Read environment variables
# SLACK_WEBHOOK_URL = os.environ['SLACK_WEBHOOK_URL']
if "SLACK_WEBHOOK_URL" in os.environ:
    SLACK_WEBHOOK_URL = os.environ['SLACK_WEBHOOK_URL']
else:
    SLACK_WEBHOOK_URL = "https://hooks.slack.com/services/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"

# SLACK_CHANNEL = os.environ['SLACK_CHANNEL']
if "SLACK_CHANNEL" in os.environ:
    SLACK_CHANNEL = os.environ['SLACK_CHANNEL']
else:
    SLACK_CHANNEL = "code-build-status-reports"

# SLACK_USERNAME = os.environ['SLACK_USERNAME']
if "SLACK_USERNAME" in os.environ:
    SLACK_USERNAME = os.environ['SLACK_USERNAME']
else:
    SLACK_USERNAME = "Code Build"

# ENVIRONMENT = os.environ["ENVIRONMENT"]
if "ENVIRONMENT" in os.environ:
    ENVIRONMENT = os.environ['ENVIRONMENT']
else:
    ENVIRONMENT = "test"

STATE_COLORS = {
    "STARTED": "#1a9edb",
    "SUCCEEDED": "#50ba32",
    "RESUMED": "#1a9edb",
    "FAILED": "#f02b1d",
    "CANCELED": "#919191",
    "SUPERSEDED": "#919191",
}

# Set logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)


def get_codepipeline_client():
    return boto3.client("codepipeline")

def format_slack_attachment(*, pipeline_name: str, pipeline_state: str, execution_id: str, environment: str, region: str, revision_summary: str, revision_url: str,) -> dict:
    
    execution_link = (
        f"<https://{region}.console.aws.amazon.com/codesuite/codepipeline/"
        f"pipelines/{pipeline_name}/executions/{execution_id}/timeline"
        f"?region={region}|{execution_id}>"
    )
    
    if revision_summary:
        revision_link = (f"\n\n<{revision_url}|View the changeset>" if revision_url else "")
        revision = f"{revision_summary}{revision_link}"
    return {
        "color": STATE_COLORS[pipeline_state],
        "fallback": (f"`{pipeline_name}` has `{pipeline_state}`"),
        "fields": [
            {"value": execution_link},
            {"value": environment.upper(), "short": True},
            {"value": region, "short": True},
            # {"value": revision}
        ],
    }

def format_slack_text(*, pipeline_name: str, pipeline_state: str, action: str):
    return f"*{action}* of *{pipeline_name}* has {pipeline_state.lower()}."

def build_slack_message_from_event(event):
    # Parse the event and extract relevant bits and pieces
    message = json.loads(event["Records"][0]["Sns"]["Message"])
    region = message["region"]
    pipeline_name = message["detail"]["pipeline"]
    pipeline_state = message["detail"]["state"]
    pipeline_action = message["detail"].get("action")
    execution_id = message["detail"]["execution-id"]
    action=pipeline_action or "Deployment"
    
    # Retrieve extra information about the pipeline run
    codepipeline = get_codepipeline_client()
    pipeline_execution = codepipeline.get_pipeline_execution(
        pipelineName=pipeline_name, pipelineExecutionId=execution_id
    )["pipelineExecution"]
    revision = pipeline_execution["artifactRevisions"][0]
    revision_url = revision.get("revisionUrl")
    revision_summary = revision.get("revisionSummary")

    # Build a message with an attachment with details
    text = f"*{action}* of *{pipeline_name}* has {pipeline_state.lower()}."
    attachment = format_slack_attachment(
        pipeline_name=pipeline_name,
        pipeline_state=pipeline_state,
        execution_id=execution_id,
        region=region,
        environment=ENVIRONMENT,
        revision_summary=revision_summary,
        revision_url=revision_url,
    )

    return {
        "channel": SLACK_CHANNEL,
        "username": SLACK_USERNAME,
        "text": text,
        "attachments": [attachment],
    }

def lambda_handler(event, context):
    
    # Construct a slack message
    params = json.dumps(build_slack_message_from_event(event)).encode()
    
    # Post message on SLACK_WEBHOOK_URL
    try:
        response = requests.post(SLACK_WEBHOOK_URL, headers={'Content-type': 'application/json'}, data=params)
    except HTTPError as e:
        logger.error("Request failed: %d %s", e.code, e.reason)
    except URLError as e:
        logger.error("Server connection failed: %s", e.reason)