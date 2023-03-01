
from aws_xray_sdk.core import xray_recorder

if __name__ == '__main__':
  xray_recorder.begin_segment('test_init')
  request = __import__('lambda_request')
  context = {}
  event = { 'echo' : {} }
  handler = request.lambda_handler
  print(handler(event, context))
  xray_recorder.end_segment()
