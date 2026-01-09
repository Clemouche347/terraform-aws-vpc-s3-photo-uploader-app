from flask import Flask, request, render_template_string
import boto3
import os

app = Flask(__name__)

BUCKET_NAME = os.environ.get("BUCKET_NAME")
s3 = boto3.client("s3")

HTML_FORM = """
<html><body>
<h1>Photo Uploader</h1>
<form action="/" method="post" enctype="multipart/form-data">
<input type="file" name="file"/>
<input type="submit"/>
</form>
<ul>
{% for file in files %}
<li>{{file}}</li>
{% endfor %}
</ul>
</body></html>
"""

@app.route("/", methods=["GET", "POST"])
def upload():
    files = []
    if request.method == "POST":
        f = request.files["file"]
        if f:
            s3.upload_fileobj(f, BUCKET_NAME, f.filename)
    # Lister les fichiers
    resp = s3.list_objects_v2(Bucket=BUCKET_NAME)
    if "Contents" in resp:
        files = [obj["Key"] for obj in resp["Contents"]]
    return render_template_string(HTML_FORM, files=files)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
