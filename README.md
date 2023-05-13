# Ory-Integration

This is a simple [ory](https://ory.sh) stack integration for use in many other projects including this intends to make it much easier to get started with the ory stack.

## Usage

Just run `docker-compose up` and you should be good to go with a fully functional ory stack.
> **Warning**
> Please make sure to secure your admin endpoints properly and run behind a proxy that enables SSL
> without it all your users will be at risk
> for more information please visit Ory's Documentation on Self-Hosting

## Configuration

Use the `.env` file to configure the stack.

## Currently included

- [x] [Hydra](https://ory.sh/hydra/)
- [ ] [Oathkeeper](https://www.ory.sh/oathkeeper/)
- [x] [Kratos](https://www.ory.sh/kratos/)
- [ ] [Keto](https://www.ory.sh/keto/)
