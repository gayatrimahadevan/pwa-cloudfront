import random
import json

def lambda_handler(event, context):
    with open("vivekananda.txt", "r") as swami_quotes:
       quotes = swami_quotes.readlines()
    return {
        'statusCode': 200,
        'headers': { 
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'         
        },
        'body': json.dumps({'Version': '2',
        'Quote': random.choice(quotes)
        })
    }    
