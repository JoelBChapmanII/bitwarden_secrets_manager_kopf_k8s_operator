import requests
from getpass import getpass

# Bitwarden API endpoint for retrieving an item (secret)
BITWARDEN_API_URL = "https://api.bitwarden.com/"

# Bitwarden authentication endpoint
BITWARDEN_AUTH_URL = "https://identity.bitwarden.com/connect/token"


def get_bitwarden_token(org_id, client_secret):
    data = {f"grant_type=client_credentials&scope=api.organization&client_id={org_id}&client_secret={client_secret}"}
    headers = {"Content-Type": "application/x-www-form-urlencoded"}
    response = requests.post(BITWARDEN_AUTH_URL, json=data, headers=headers)
    if response.status_code == 200:
        return response.json()["access_token"]
    else:
        print(f"Failed to get Bitwarden token. Status code: {response.status_code}")
        return None


def get_secret(token, item_id):
    item_url = BITWARDEN_API_URL + f"items/{item_id}"
    headers = {"Authorization": f"Bearer {token}"}
    response = requests.get(item_url, headers=headers)

    if response.status_code == 200:
        return response.json()
    else:
        print(f"Failed to get secret. Status code: {response.status_code}")
        return None


if __name__ == "__main__":
    # Replace with your Bitwarden credentials
    bitwarden_username = "your_email@example.com"
    bitwarden_password = getpass("Enter your Bitwarden password: ")

    # Replace with the ID of the secret you want to retrieve
    secret_id_to_retrieve = "your_secret_id"

    # Get Bitwarden token
    bitwarden_token = get_bitwarden_token(bitwarden_username, bitwarden_password)

    if bitwarden_token:
        # Get secret
        secret = get_secret(bitwarden_token, secret_id_to_retrieve)

        if secret:
            print("Secret retrieved successfully:")
            print(secret)
        else:
            print("Failed to retrieve secret.")
    else:
        print("Failed to get Bitwarden token.")
