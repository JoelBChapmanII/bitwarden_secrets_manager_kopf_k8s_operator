import kopf
import logging
import kubernetes

@kopf.on.create('bitwardensecrets')
def create_fn(body, **kwargs):
    logging.info(f"A handler is called with body: {body}")
    k_api = kubernetes.client.CoreV1Api()
    k_sec = kubernetes.client.V1Secret(
        api_version="v1",
        kind = "Secret",
        metadata= kubernetes.client.V1ObjectMeta(name="test"),
        string_data ={"username": "test"},
    )

    k_api.create_namespaced_secret(body=k_sec, namespace='default')

