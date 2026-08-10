# Fixation Bolding

An application that converts PDF documents into EPUB files using fixation-prefix bolding. Subtitle: Reading help for people with ADHD.

## Language

**Fixation Bolding**:
The text transformation this application performs — bolding the first N characters of each word (the Fixation Prefix) and leaving the remaining characters in regular weight, to guide the reader's eye along the line. Named generically to avoid the "Bionic Reading®" trademark.
_Avoid_: bionic reading, bionic formatting, speed reading

**Fixation Prefix**:
The leading portion of a word that is bolded by the Fixation Bolding transformation. Its length is a function of the word's total length.
_Avoid_: fixation point, emphasis span

**Conversion**:
The act of transforming an uploaded PDF into a Fixation Bolding EPUB. The server holds the input and output only for the duration of a single Conversion; nothing is persisted afterward.
_Avoid_: processing, rendering, export

**Stateless**:
The application stores no data between Conversions. There are no accounts, no conversion history, and no retained files. Each visit is independent.
_Avoid_: sessionless, ephemeral

**Client**:
The browser front-end. It accepts the user's PDF, sends it to the Server, and offers the returned EPUB for download. It performs no Conversion work itself.
_Avoid_: frontend, UI, browser app

**Server**:
The backend that performs the Conversion: PDF text extraction, Bionic Reading transformation, and EPUB assembly. It receives a PDF from the Client and returns the resulting EPUB in the same HTTP response. It retains neither after the request completes.
_Avoid_: backend, API, service

**Synchronous Conversion**:
A Conversion that completes within a single HTTP request-response cycle. The Client sends the PDF and waits; the Server returns the EPUB as the response. There is no job ID, no polling, and no second endpoint.
_Avoid_: blocking, inline

**Text Page**:
A PDF page that contains an extractable text layer. Only Text Pages are processed into the EPUB; pages without a text layer are skipped silently.
_Avoid_: text layer page, OCR page
