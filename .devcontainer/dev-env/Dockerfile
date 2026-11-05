FROM mcr.microsoft.com/dotnet/sdk:10.0

# Install Node.js v26 and prerequisites
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    gpg \
    && curl -fsSL https://deb.nodesource.com/setup_26.x | bash - \
    && apt-get install -y nodejs \
    # Add GitHub CLI official repository and key
    && mkdir -p -m 755 /etc/apt/keyrings \
    && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Install the GitHub Copilot CLI globally
RUN npm install -g @github/copilot

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

WORKDIR /workspace