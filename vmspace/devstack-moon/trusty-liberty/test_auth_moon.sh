#!/usr/bin/env bash

curl -i \
  -H "Content-Type: application/json" \
  -d '
{ "auth": {
    "identity": {
      "methods": ["password"],
      "password": {
        "user": {
          "name": "admin",
          "domain": { "id": "default" },
          "password": "password"
        }
      }
    }
  }
}' \
  http://localhost:5000/v3/auth/tokens ; echo