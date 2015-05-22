===============
API & Endpoints
===============

* Deliveries must always undergo a security review
* Use HTTP methods as primary verbs:
* Allowed are: GET, POST, PUT and DELETE
* Disallowed are: HEAD, OPTIONS, TRACE, CONNECT 
* Deliver JSON or XML in response body (JSON first)
* API keys should not appear in the URL
* Use only one session identifier to maintain session state
* Always validate input and encode output - Always!
* Every API/Endpoint must be well documented (hence DoD)
* Apply Section 5 of: http://tools.ietf.org/html/rfc6819

Input Validation
^^^^^^^^^^^^^^^^

* Always validate input (functional and contextual) 
* Consider all input as tainted and treat it accordingly
* Everything you know about input validation applies to APIs too becasue they are prime targets because automated tools can easily fuzz
* If input does not pass validation - reject that input.
* Also always encode your output!
* Log input validation failures
* Anyone can call our web services assume that someone who is performing hundreds of failed input validations per second is up to no good.
* Rate limit the API to a certain number of requests per hour or day

Input Validation - Content Type
"""""""""""""""""""""""""""""""

* All incoming content-types must be validated
* POST or PUT Methods will specify the Content-Type (e.g. application/xml or application/json) of the incoming data
* The client should never assume the Content-Type
* Always check the Content-Type so that header and the content are the same type
* A lack of Content-Type header or an unexpected Content-Type header must result in the server rejecting the content with a 406 Not Acceptable response

Input Validation - Response Type
""""""""""""""""""""""""""""""""

* REST services usually allow multiple response types (e.g. application/xml or application/json) and the client specifies the preferred order of response types by the Accept header in the request.
* Do NOT copy the Accept header to the Content-type header of the response. 
* Reject the request with a 406 Not Acceptable response if the Accept header does not specifically contain one of the allowable types

Input Validation - XML
======================

* XML-based services must ensure that they are protected against common XML based attacks by using secure XML-parsing
* If you need to use XML, the parser must must not be vulnerable to XML External Entity as well as similar attacks
* Implement protecting against

  * XML External Entity attacks
  * XML-signature wrapping etc.

Output Encoding
^^^^^^^^^^^^^^^

* JSON encoding

  * JSON encoder prevent arbitrary JavaScript remote code execution or in case of node.js, on the server
  * Serialize proper JSON to encode data properly to prevent the execution

* XML encoding

  * XML must never be built by string concatenation
  * Always use constructed an XML serializer
  * Consider Response-Type text/plain

