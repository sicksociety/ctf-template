# CTF Challenge Template

A Docker-based template for serving interactive CTF challenges with built-in security features and anti-bruteforce protection.

## Features

- **Interactive Q&A Format** - Players answer questions sequentially to get the flag
- **Anti-Bruteforce** - 3 wrong attempts per question before connection closes
- **Case-Insensitive Answers** - Accepts answers regardless of capitalization
- **Smart Format Hints** - Automatically generates format hints (e.g., `***.***.***.***` for IPs)
- **Question Progress** - Shows current question number (e.g., `[Question 3/7]`)
- **60-Second Timeout** - Automatic disconnection for idle connections
- **Secure Environment** - Read-only filesystem, non-root user, isolated container

## Quick Start

1. Edit `quest.sh` to add your questions and answers:
```bash
questions=(
    "Your question here?"
)

answers=(
    "Your answer here"
)
```

2. Build and run:
```bash
docker-compose up --build
```

3. Connect to the challenge:
```bash
nc localhost 8998
```

## Customization

- **Port**: Change `8998` in `docker-compose.yml` and `Dockerfile`
- **Timeout**: Modify timeout value in `launch.sh`
- **Max Attempts**: Change `MAX_ATTEMPTS` in `quest.sh`
- **Base Image**: Switch between `python:3.9-slim` or `ubuntu:22.04` in `Dockerfile`

## File Structure

- `quest.sh` - Challenge script with questions/answers
- `Dockerfile` - Container configuration
- `docker-compose.yml` - Service orchestration
- `launch.sh` - Entry point with timeout
- `ynetd` - Network daemon for handling connections

## License

MIT
