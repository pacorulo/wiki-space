#### Example Log Output
```
2025-03-03 14:30:12 [INFO] - Starting topology check for collection 'test_collection' on host 127.0.0.1
2025-03-03 14:30:12 [INFO] - Attempting to GET http://127.0.0.1:6333/cluster (try 1/3)
2025-03-03 14:30:12 [INFO] - Attempting to GET http://127.0.0.1:6333/collections/test_collection/cluster (try 1/3)
2025-03-03 14:30:12 [INFO] - Successfully retrieved and displayed topology for collection 'test_collection' on host 127.0.0.1
```

#### Example if a request fails
```
2025-03-03 14:30:12 [WARNING] - Timeout when connecting to http://127.0.0.1:6333/cluster (attempt 1/3)
2025-03-03 14:30:15 [ERROR] - Failed to fetch data from http://127.0.0.1:6333/cluster after 3 attempts.
```
