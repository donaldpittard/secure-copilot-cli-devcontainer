#!/bin/sh

if [ -n "${GH_TOKEN:-}" ]; then
	attempt=1
	max_attempts=5

	until printf '%s\n' "$GH_TOKEN" | gh auth login --with-token; do
		if [ "$attempt" -ge "$max_attempts" ]; then
			echo "Warning: GitHub CLI authentication failed after $max_attempts attempts; continuing without authentication." >&2
			break
		fi

		echo "GitHub CLI authentication failed; retrying in ${attempt}s ($attempt/$max_attempts)." >&2
		sleep "$attempt"
		attempt=$((attempt + 1))
	done
fi

exec "$@"