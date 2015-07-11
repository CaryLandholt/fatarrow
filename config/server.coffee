PORT = 8181
PROXY_CONFIG = [
	'^/api$ http://localhost:8182/api [P, L]'
]

module.exports = {PORT, PROXY_CONFIG}
