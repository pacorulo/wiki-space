#In case you get the error about: doesn't match a supported version 
#you have to install with pip: pip[3] install --upgrade requests

from qdrant_client.models import Distance, VectorParams
from qdrant_client import QdrantClient

client = QdrantClient(host="localhost", port=6333)

client.create_collection(
    collection_name="XXXXXX",
    shard_number=X,
    vectors_config=VectorParams(size=4, distance=Distance.DOT),
)
