# Serverless social media app with Flutter and AWS Amplify

+++ This template is currently under construction and does not contain all the features listed below! +++

This template implements a generic social media app using following cloud capabilities:

- Authentication / authorization
- Cloud storage with GraphQL schema
- Analytics
- Lambda function calls via REST API

The app's features include:

- Profile creation
- Buddylist management
- Feed with posts
- Chat

## Getting Started

### Prerequisites

In order to use the AWS Amplify service, you need an [AWS account](https://aws.amazon.com/de/console/).

Install following tools:

- [Flutter](https://flutter.dev/)
- [Amplify](https://docs.amplify.aws/lib/project-setup/prereq/q/platform/flutter)

### Project Setup

Configure your Amplify resources with following commands:

`amplify init`

`amplify add analytics`

`amplify add auth`

`amplify add api` (GraphQL)

If everything is configured as desired, execute `amplify push` to create the respective resources in AWS.

Before running this project the first time, make sure to call `flutter create .`.

### Run Project

`flutter run`

## How to modify the app

### Datamodel / GraphQL

The GraphQL schema is defined in [schema.graphql](amplify/backend/api/socialmediaapp/schema.graphql). Whenever changes
have been made to that schema, execute `amplify codegen models` in order to generate the respective dart classes within
the [lib/models](lib/models) folder. Fully restart the app so that all changes take effect.
