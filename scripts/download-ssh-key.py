#!/usr/bin/python3
import json
from os import environ
from pathlib import Path
from subprocess import PIPE, Popen, check_output

import boto3
from botocore.exceptions import ClientError


def get_secret():
    secret_name = environ.get("SECRET_NAME", "ssh_key")
    region_name = "eu-central-1"

    session = boto3.session.Session()
    client = session.client(
        service_name="secretsmanager",
        region_name=region_name,
    )

    try:
        get_secret_value_response = client.get_secret_value(SecretId=secret_name)
    except ClientError as e:
        if e.response["Error"]["Code"] == "ResourceNotFoundException":
            print("The requested secret " + secret_name + " was not found")
        elif e.response["Error"]["Code"] == "InvalidRequestException":
            print("The request was invalid due to:", e)
        elif e.response["Error"]["Code"] == "InvalidParameterException":
            print("The request had invalid params:", e)
        elif e.response["Error"]["Code"] == "DecryptionFailure":
            print(
                "The requested secret can't be decrypted using the provided KMS key:", e
            )
        elif e.response["Error"]["Code"] == "InternalServiceError":
            print("An error occurred on service side:", e)
    else:
        secrets = json.loads(get_secret_value_response["SecretString"])

        with Path("/home/lucas/.ssh/id_ed25519").open("w") as of:
            of.write(secrets["key"].replace("\\n", "\n"))

        print(secrets["passphrase"])


if __name__ == "__main__":
    get_secret()
