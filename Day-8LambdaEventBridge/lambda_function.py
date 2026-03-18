import json

def lambda_handler(event, context):

    # Display the input event
    print("Event received:", event)

    response = {
        'statusCode': 200,
        'body': json.dumps('Hello from Salman The Champion!')
    }

    # Display the output test
    print("Response:", response)

    return response


if __name__ == "__main__":
    test_event = {"key": "value"}
    test_context = None

    result = lambda_handler(test_event, test_context)
    print("Final result:", result)