"""Backend do lab 006: servidor HTTP mínimo, só para laboratório (não use em produção)."""
from http.server import BaseHTTPRequestHandler, HTTPServer

PAGE = b"<h1>pedidos-api</h1><p>TBX AI lab 006 &middot; backend respondendo</p>\n"


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/health":
            body, ctype = b"ok\n", "text/plain"
        else:
            body, ctype = PAGE, "text/html; charset=utf-8"
        self.send_response(200)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


if __name__ == "__main__":
    print("pedidos-api escutando em 0.0.0.0:8000", flush=True)
    HTTPServer(("0.0.0.0", 8000), Handler).serve_forever()
