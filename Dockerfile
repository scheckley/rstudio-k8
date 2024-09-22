# Use the RStudio image from the Rocker Project
FROM rocker/rstudio:latest

# Switch to root to set permissions
USER root

# Ensure that /var/run/s6 exists and is writable by any user
RUN mkdir -p /var/run/s6 /etc/s6 \
    && chown -R 1000:0 /var/run/s6 /etc/s6 \
    && chmod -R g=u /var/run/s6 /etc/s6

# Install necessary dependencies (if any)
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Ensure the non-root user has ownership of home directories and important paths
RUN chown -R 1000:0 /home/rstudio /var/lib/rstudio-server \
    && chmod -R g=u /home/rstudio /var/lib/rstudio-server

# Expose RStudio server port
EXPOSE 8787

# Switch back to non-root user
USER 1000

# Start RStudio Server using the default CMD from the base image
CMD ["/init"]
