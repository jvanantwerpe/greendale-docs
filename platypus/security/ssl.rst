==============
SSL encryption
==============

All internally and externally public endpoints have to use SSL for their communication. This basically means HTTPS
everywhere.

Requirements
^^^^^^^^^^^^
* Use TLS 1.2 with a strong cipher suite (Disallow and disable all others)
* No http communication, it must be via https 
* Use Zalando CA for internal communication
* For external communication use a valid TLS cert signed by a trusted CA (not Zalando)
* Leverage certificate key pinning to prevent SSL downgrade or MITM attacks
* Don’t use Transport Encryption certificates to authenticate endpoints

