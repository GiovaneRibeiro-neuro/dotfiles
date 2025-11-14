#!/bin/bash

# up - A utility script for common system tasks
# Usage: ./up <command>

command=$1

case "$command" in
  grade)
    echo "🔄 Starting system upgrade..."
    if command -v apt-get &> /dev/null; then
      ubuntu-update.sh
    elif command -v pacman &> /dev/null; then
      arch-update.sh
    else
      echo "❌ Package manager not detected"
      exit 1
    fi
    echo "✅ System upgrade complete"
    ;;

  mysql)
    echo "🚀 Starting MySQL container..."
    docker run -d \
      --name mysql \
      -e MYSQL_ROOT_PASSWORD=root \
      -p 3306:3306 \
      mysql:latest
    echo "✅ MySQL container started on port 3306"
    echo "   Root password: root"
    ;;

  redis)
    echo "🚀 Starting Redis container..."
    docker run -d \
      --name redis \
      -p 6379:6379 \
      redis:latest
    echo "✅ Redis container started on port 6379"
    ;;

  *)
    echo "Usage: $0 {grade|mysql|redis}"
    echo ""
    echo "Commands:"
    echo "  grade  - Upgrade system"
    echo "  mysql  - Start MySQL Docker container"
    echo "  redis  - Start Redis Docker container"
    exit 1
    ;;
esac
