# polls_api

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]
[![Powered by Dart Frog](https://img.shields.io/endpoint?url=https://tinyurl.com/dartfrog-badge)](https://dartfrog.vgv.dev)

An API for a basic poll application built with dart_frog

```md
polls_api/              # Root directory of your Dart Frog project
├── db/                 # Database-related files
│   └── schema.sql            # SQL schema for the database
├── middleware/         # Middleware files
│   └── auth_middleware.dart  # Middleware to verify JWT tokens
├── routes/             # API route handlers
│   ├── _middelware.dart
│   ├── auth/           # Authentication-related endpoints
│   │   ├── login.dart        # Login endpoint (POST /auth/login)
│   │   └── register.dart     # Register endpoint (POST /auth/register)
│   ├── polls/          # Poll-related endpoints
│   │   ├── index.dart        # List all polls (GET /polls)
│   │   ├── [pollId]/         # Dynamic routes for specific polls
│   │   │   ├── index.dart    # Get poll details (GET /polls/:pollId)
│   │   │   ├── vote.dart     # Vote on a poll (POST /polls/:pollId/vote)
│   │   │   └── results.dart  # Get poll results (GET /polls/:pollId/results)
├── pubspec.yaml        # Dart project dependencies and metadata
├── seed.dart           # Seed db
```

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis