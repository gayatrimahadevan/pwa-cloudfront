#FROM public.ecr.aws/lambda/python:3.8
FROM amazon/aws-lambda-python:3.8

COPY __init__.py quote.py requirements.txt vivekananda.txt ./

RUN python3.8 -m pip install -r requirements.txt -t .

CMD ["quote.lambda_handler"]
