#!/bin/bash
# Replaces all environment variables in kratos.yml with their values

# Set Postgres DSN
sed -i "s|dsn: memory|dsn: postgres://$POSTGRES_USER@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DBNAME?sslmode=disable|g" /home/kratos/config/kratos.yml

# Kratos configuration (kratos.yml)
## serve.public.base_url (String)
#PUBLIC_BASEURL: https://accounts.example.com/ # REPLACE_ME
## selfservice.default_browser_return_url (String)
#SELF_SERVICE_DEFAULT_BROWSER_RETURN_URL: https://accounts.example.com/auth/ # REPLACE_ME
## selfservice.allowed_return_urls (Array)
#SELF_SERVICE_ALLOWED_RETURN_URLS: https://accounts.example.com/ # REPLACE_ME, add more if needed separated with ; and no spaces
## selfservice.flows.error_ui_url (String)
#SELF_SERVICE_FLOWS_ERROR_UI_URL: https://accounts.example.com/auth/errors # REPLACE_ME
## selfservice.flows.settings_ui_url (String)
#SELF_SERVICE_FLOWS_SETTINGS_UI_URL: https://accounts.example.com/auth/settings # REPLACE_ME
## selfservice.flows.recovery_enabled (Boolean)
#SELF_SERVICE_FLOWS_RECOVERY_ENABLED: "true"
## selfservice.flows.recovery_ui_url (String)
#SELF_SERVICE_FLOWS_RECOVERY_UI_URL: https://accounts.example.com/auth/recovery # REPLACE_ME
## selfservice.flows.verification_enabled (Boolean)
#SELF_SERVICE_FLOWS_VERIFICATION_ENABLED: "true"
## selfservice.flows.verification_ui_url (String)
#SELF_SERVICE_FLOWS_VERIFICATION_UI_URL: https://accounts.example.com/auth/verification # REPLACE_ME
## selfservice.flows.verification.after.default_browser_return_url (String)
#SELF_SERVICE_FLOWS_VERIFICATION_AFTER: https://accounts.example.com/auth/ # REPLACE_ME
## selfservice.flows.logout.after.default_browser_return_url (String)
#SELF_SERVICE_FLOWS_LOGOUT_AFTER: https://accounts.example.com/auth/login # REPLACE_ME
## selfservice.flows.login.ui_url (String)
#SELF_SERVICE_FLOWS_LOGIN_UI_URL: https://accounts.example.com/auth/login # REPLACE_ME
## selfservice.flows.login.lifespan (Duration)
#SELF_SERVICE_FLOWS_LOGIN_LIFESPAN: 10m
## selfservice.flows.registration.ui_url (String)
#SELF_SERVICE_FLOWS_REGISTRATION_UI_URL: https://accounts.example.com/auth/registration # REPLACE_ME
## selfservice.flows.registration.lifespan (Duration)
#SELF_SERVICE_FLOWS_REGISTRATION_LIFESPAN: 10m

sed -i "s|base_url: http://127.0.0.1:4433/|base_url: $PUBLIC_BASEURL|g" /home/kratos/config/kratos.yml
sed -i "s|default_browser_return_url: http://127.0.0.1:4455/|default_browser_return_url: $SELF_SERVICE_DEFAULT_BROWSER_RETURN_URL|g" /home/kratos/config/kratos.yml
## MISSING: Implementation for Array
sed -i "s|- http://127.0.0.1:4455|- $SELF_SERVICE_ALLOWED_RETURN_URLS|g" /home/kratos/config/kratos.yml
sed -i "s|ui_url: http://127.0.0.1:4455/error|ui_url: $SELF_SERVICE_FLOWS_ERROR_UI_URL|g" /home/kratos/config/kratos.yml
sed -i "s|ui_url: http://127.0.0.1:4455/settings|ui_url: $SELF_SERVICE_FLOWS_SETTINGS_UI_URL|g" /home/kratos/config/kratos.yml
## MISSING: selfservice.flows.recovery_enabled (Boolean)
sed -i "s|ui_url: http://127.0.0.1:4455/recovery|ui_url: $SELF_SERVICE_FLOWS_RECOVERY_UI_URL|g" /home/kratos/config/kratos.yml
## MISSING: selfservice.flows.verification_enabled (Boolean)
sed -i "s|ui_url: http://127.0.0.1:4455/verification|ui_url: $SELF_SERVICE_FLOWS_VERIFICATION_UI_URL|g" /home/kratos/config/kratos.yml
sed -i "s|default_browser_return_url: http://127.0.0.1:4455/|default_browser_return_url: $SELF_SERVICE_FLOWS_VERIFICATION_AFTER|g" /home/kratos/config/kratos.yml
sed -i "s|default_browser_return_url: http://127.0.0.1:4455/login|default_browser_return_url: $SELF_SERVICE_FLOWS_LOGOUT_AFTER|g" /home/kratos/config/kratos.yml
sed -i "s|ui_url: http://127.0.0.1:4455/login|ui_url: $SELF_SERVICE_FLOWS_LOGIN_UI_URL|g" /home/kratos/config/kratos.yml
sed -i "s|lifespan: 10m|lifespan: $SELF_SERVICE_FLOWS_LOGIN_LIFESPAN|g" /home/kratos/config/kratos.yml
sed -i "s|ui_url: http://127.0.0.1:4455/registration|ui_url: $SELF_SERVICE_FLOWS_REGISTRATION_UI_URL|g" /home/kratos/config/kratos.yml
## selfservice.flows.registration.lifespan (Duration) is applied equal to login lifespan