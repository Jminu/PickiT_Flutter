from firebase_functions import db_fn, https_fn
from firebase_admin import initialize_app, db
from werkzeug.http import http_date

app = initialize_app()


@https_fn.on_request()
def addmessageHello(req: https_fn.Request) -> https_fn.Response:
    original = req.args.get("text")
    if original is None:
        return https_fn.Response("No text parameter provided", status=400)

    ref = db.reference("message")
    new_ref = ref.push({"original" : original})

    return https_fn.Response(f"Message with ID {new_ref.key} added.")