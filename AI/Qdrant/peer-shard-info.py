#This script has been tested only on an on-prem instance
#compound by 1 node (Vagrant VM based on Ubuntu/focal)
#and qdrant running on docker:
#docker run -p 6333:6333 -p 6334:6334 -v $(pwd)/qdrant_storage:/qdrant/storage:z qdrant/qdrant

import argparse  # For handling command-line arguments
import requests  # For making HTTP requests (replaces subprocess + curl)
import json  # For working with JSON data
import time  # For retry backoff
import sys  # To handle script exits in case of errors
import logging  # For proper logging
from tabulate import tabulate  # To print tables nicely


# Set up logging
logging.basicConfig(
    filename='cluster_topology.log',  # Log file name
    level=logging.INFO,  # Log level (you can change to DEBUG if needed)
    format='%(asctime)s [%(levelname)s] - %(message)s'
)

# Function to get and validate the arguments provided to the script
def check_prompt():
    parser = argparse.ArgumentParser(description="Script to get the topology of the cluster")
    parser.add_argument("IP", help="IP address of the host to connect to")
    parser.add_argument("COLLECTION", help="Name of the collection to check shard information for")
    args = parser.parse_args()
    return [args.IP, args.COLLECTION]


# Function to validate if the provided IP is in the correct format
def validate_ip(ip_value):
    if ip_value == "localhost":
        return True  # localhost is always valid

    octets = ip_value.split('.')
    if len(octets) != 4:
        return False  # IP must have exactly 4 octects

    for octet in octets:
        if not octet.isdigit() or not (0 <= int(octet) <= 255):
            return False  # Each octet must be a number between 0 and 255
    return True


# Function to make an HTTP GET request with retries and return parsed JSON
def http_get_json(url, retries=3, backoff_seconds=2):
    attempt = 0

    while attempt < retries:
        try:
            logging.info(f"Attempting to GET {url} (try {attempt + 1}/{retries})")
            response = requests.get(url, timeout=5)
            response.raise_for_status()
            return response.json()

        except requests.Timeout:
            logging.warning(f"Timeout when connecting to {url} (attempt {attempt + 1}/{retries})")
        except requests.RequestException as e:
            logging.warning(f"Error during request to {url}: {e} (attempt {attempt + 1}/{retries})")

        # Wait before retrying
        attempt += 1
        if attempt < retries:
            time.sleep(backoff_seconds)

    logging.error(f"Failed to fetch data from {url} after {retries} attempts.")
    print(f"Failed to fetch data from {url} after {retries} attempts. Check the logs for details.")
    sys.exit(1)


# Function to print a table with peer and shard information
def table_print(shard_count, table_content):
    shard_ids = ','.join(map(str, table_content[2:]))
    table = [['peer_id', 'shard_count', 'shard_ids'], [table_content[0], table_content[1], shard_ids]]
    print(tabulate(table, headers='firstrow', tablefmt='fancy_grid'))


# Main function
def main():
    # Get command-line arguments (IP and collection)
    cluster_info = check_prompt()
    ip = cluster_info[0]
    collection = cluster_info[1]

    # Validate IP format
    if not validate_ip(ip):
        logging.error(f"Invalid IP address provided: {ip}")
        print("The provided IP address is invalid. Please re-run the script with a valid IP.")
        sys.exit(1)

    logging.info(f"Starting topology check for collection '{collection}' on host {ip}")

    # Get cluster status
    cluster_url = f'http://{ip}:6333/cluster'
    cluster_data = http_get_json(cluster_url)

    # Get collection shard information
    collection_url = f'http://{ip}:6333/collections/{collection}/cluster'
    collection_data = http_get_json(collection_url)

    # If the collection does not exist, exit the script with a message and logging it
    if collection_data['status'] != "ok":
        logging.error(f"Collection '{collection}' does not exist on host {ip}")
        print("The specified collection does not exist. Please re-run the script with a valid collection name.")
        sys.exit(1)

    # Prepare a list to store peer and shard information for the output table
    peers_shard = []
    result = collection_data['result']
    peers_shard.append(result['peer_id'])
    peers_shard.append(result['shard_count'])

    # Add all shard IDs to the list
    for shard in result['local_shards']:
        peers_shard.append(shard['shard_id'])

    # Print the table
    table_print(result['shard_count'], peers_shard)

    logging.info(f"Successfully retrieved and displayed topology for collection '{collection}' on host {ip}")

# Script entry point
if __name__ == "__main__":
    main()
