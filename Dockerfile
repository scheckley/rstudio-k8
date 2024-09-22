# Use a base image for R and RStudio
FROM rocker/rstudio:latest

# Switch to root to install additional packages
USER root

# Install dependencies (example packages; modify as needed)
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user with an explicit UID/GID.
# OpenShift assigns random user IDs, but you still need a non-root user.
RUN useradd -m rstudio-user \
    && chown -R rstudio-user /home/rstudio-user

# Expose port for RStudio Server (8787 by default)
EXPOSE 8787

# Make sure that RStudio Server works in an OpenShift environment
# OpenShift runs containers as a random user in the 1000 range,
# so files must be group-readable and writable by others.
RUN chgrp -R 0 /home/rstudio-user && \
    chmod -R g=u /home/rstudio-user

# Switch back to non-root user
USER 1000

# Start RStudio Server
CMD ["/init"]
