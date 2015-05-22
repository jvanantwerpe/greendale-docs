=====
Goals
=====

Key requirements for our platform is that all communication is **encrypted**, **authenticated** and **authorized**. While these
three topics are based on very different concepts the integration must be seamless

In addition, we want to open up our network, meaning that all 'internally
public' network endpoints (like REST HTTP services) are accessible by the whole company (and possibly by the whole
internet in the future). The idea is that everyone (with the according permissions) can directly access all services
from their desktops.

------
Theory
------

What do the terms actually mean?

* **Authentication** is the act of identifying a subject. There are numerous ways how a subject could be identified. If
  the subject is a human, she could be authenticated by looking at her passport. Another way of authenticating a subject
  is to share a secret. This secret could be a password, that a user gave you when she registered. If she can tell you
  the password again, you know that she is the one who initially registered the account.
* **Authorization** is about granting permission to do or get something. You can authorize someone to enter your home or
  not.
* **Encryption**, in context of cryptography is a process which aims to ensure the confidentiality all bytes so that 
  only authorized parties can access these. Encryption cannot ensure that the data send via a channel is not intercepted
  but an attacker can't read the actual content and its confidentially is retained.

It is important to distinguish these terms as they have very different purposes. 

In a Nutshell 
-   authentication determines who you are
-   authorization what you are able to do 
-   encryption ensures that only you can see the information

Example
    Let's assume I want to travel to Mexico, I show my passport to the border agent, I authenticate myself. The agent reads all the information and verifies them, depending on the process using a computer or telephone. However, the simple presentation of
    my identification does not ensure that I can actually gain access to Mexi co. For this I need permission, a visa, which proves that I am authorized to enter Mexico. Which goes to show that even if I am authenticated it does not
    necessary mean that I am also authorized.
    
    It should also be noted to get the order right - I want to authenticate someone first as a base for my decision if I authorize somebody to enter for example Mexico.
