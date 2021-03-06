User Guide
==========

On Tokens
---------

Access Tokens
^^^^^^^^^^^^^

According to the RFC of OAuth - Access tokens are credentials used to access protected resources - meaning they are to be treated like you would treat your passwords.

An access token is a string representing an authorization issued to the client, you can think of it like cash. They represent specific scopes and duration of access, granted by the resource owner, and enforced by the resource server and authorization server.

It is absolutely essential not to paste your access token into any form of electronic communication (Skype, E-mail, etc.) because anybody - and I really mean anybody - could pickup your access token and request access to a protected resource.

Refresh Tokens
^^^^^^^^^^^^^^

Refresh tokens are credentials used to obtain access tokens.  Refresh tokens are issued to the client by the authorization server and are used to obtain a new access token when the current access token becomes invalid or expires, or to obtain additional access tokens with identical or narrower scope 
(access tokens may have a shorter lifetime and fewer permissions than authorized by the resource owner).

The Grant-Types or Flows - Authorization and Client-Credentials - issue refresh tokens. However the Implicit Flow does not have a refresh token due to security concerns.

Because of this tokens nature they usually have a much larger validity period and therefore a much higher requirement on their confidentiality. You can think of them as your credit card, they can get you new money pretty much anywhere.

Let me quote Henning here:

    NEVER, NEVER publish any credentials (user/password or OAuth2 tokens)!

    Especially do not copy&paste "curl" command lines with Authorization header anywhere (no HipChat, no mail, no GitHub issues, etc)!

Getting an Access Token
-----------------------

Team Greendale is providing you with a need little service which gives you an access token in return for you AD credentials. Its called the Token API. This service is currently used by the Stups team for their ZIGN application which automates a lot of these processes.
So for the brave or the interested please feel free to check it out. It requires actually nothing more the curl and some header magic.

Create Authorization Header
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Because you need to provide your credentials somehow, we use currently basic Auth to do so. Basic Auth uses a base64 representation of you credentials::

                #Store your credentials in var for ease of use
                auth=$(echo -n <username>:<password> | base64)

Request your Token
^^^^^^^^^^^^^^^^^^

The most trivial example just gets you and access token and nothing more. So doing this::

        curl -XGET --header "Authorization: Basic $auth" "https://token.auth.zalando.com/access_token"

Will return you just a simple access token::

        60ad9d2b-d441-4299-99ba-0397893637f5

If you want to see the full token thats also easy. Just add the json=true parameter to the request::

        curl -XGET --header "Authorization: Basic $auth" "https://token.auth.zalando.com/access_token?json=true"

Return a little more data::

        {"access_token":"0989cd01-333d-4220-a699-539b452d019c","refresh_token":"e8e099cf-2bc7-43c4-9e80-0c8ba66e4141","scope":"uid cn","token_type":"Bearer","expires_in":3599}

Consulting the TokenInfoEndpoint
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

So great you have a token now but what can you actually do with it. Visit the token info endpoint and send the access_token along for some closure::


        token=$(curl -XGET --header "Authorization: Basic $auth" "https://token.auth.zalando.com/access_token")

This looks very ugly and not so ascetically pleasing::

        access_token":"d1f2bf18-16f9-4da5-8b0b-75d1a702122d","uid":"ckunert","grant_type":"password","scope":["uid","cn"],"realm":"employees","cn":"","token_type":"Bearer","expires_in":3467}

But using jq you get a much cleaner output::

       curl --request GET https://auth.zalando.com/oauth2/tokeninfo?access_token=$token | jq .
        {
          "access_token": "d1f2bf18-16f9-4da5-8b0b-75d1a702122d",
          "uid": "ckunert",
          "grant_type": "password",
          "scope": [
            "uid",
            "cn"
          ],
          "realm": "employees",
          "cn": "",
          "token_type": "Bearer",
          "expires_in": 2912
        }

Adding Scopes
^^^^^^^^^^^^^

For now we only have requested a trivial token which does not do much on its own so we want to add some scope to enrich the data a little::

        curl -XGET --header "Authorization: Basic $auth" "https://token.auth.zalando.com/access_token?scope=cn"

To be fair this reduces the scopes from the default scopes uid and cn to just the common name. Working with scopes for employees does currently not work so brilliantly because all attributes for a user are stores in AD, and we cannot write to AD unfortunalty.

Integrating Legacy Services
---------------------------

This section describes how existing legacy services will be integrated in Greendale. The goal here is to enable
OAuth 2.0 authentication and authorization even if a service doesn't provide it.

Reminder - What is a Legacy Service?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A legacy service is an application that, is **not** OAuth 2.0 compliant and* is **not** deployed in AWS.

Use Cases
^^^^^^^^^

Two use cases were identified where legacy services have a role. These are:

* An OAuth 2.0 enabled application wants to communicate with a legacy service;
* An application that uses a legacy - i.e. non OAuth 2.0 compliant - client communicates with a legacy service. A typical example is when an application gets their keys from the Config Service;

The following sections describe the aforementioned use cases, how to handle them, and the related technologies used.


Using OpenIG to enable OAuth 2.0 in Legacy Services
___________________________________________________


Configuration
^^^^^^^^^^^^^

ToDo

Deploying OpenIG - Service Side
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

ToDo

At the service OpenIG is deployed in a separate container
