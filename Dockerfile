# Use Ruby 3.2.6 as base image
FROM ruby:3.2.6-slim

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    cmake \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create app user
RUN useradd -ms /bin/bash app

# Set working directory
WORKDIR /app

# Install bundler
COPY Gemfile Gemfile.lock ./
COPY .tool-versions ./.tool-versions
RUN gem install bundler -v $(tail -1 Gemfile.lock | tr -d ' ') && \
    bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3

# Copy application code
COPY . .

# Create directories for pids and sockets, ensure entrypoint is executable, and set ownership
RUN mkdir -p tmp/pids tmp/sockets && \
    chmod +x /app/docker-entrypoint.sh && \
    chown -R app:app /app

USER app

# Set environment variables
ENV RAILS_ENV=production \
    RAILS_LOG_TO_STDOUT=true \
    RAILS_SERVE_STATIC_FILES=true

# Expose port 3000
EXPOSE 3000

# Entrypoint runs migrations before executing the given command
ENTRYPOINT ["/app/docker-entrypoint.sh"]

# Start Puma server by default
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]