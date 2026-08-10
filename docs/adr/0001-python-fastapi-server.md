# Python + FastAPI for the Server

The Server performs PDF text extraction, the Bionic Reading transformation, and EPUB assembly in a single synchronous HTTP request. We chose Python with FastAPI because `pymupdf` is the strongest available PDF text extractor (good handling of pages, fonts, reading order), EPUB is trivially assembled as a zipped set of XHTML files, and the bionic transformation is pure string manipulation. FastAPI gives a single endpoint with minimal boilerplate and simple deployment. Rejected alternatives: Node.js (weaker PDF extraction libraries), Go (limited PDF options).
