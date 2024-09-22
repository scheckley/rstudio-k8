# Use the RStudio image from the Rocker Project
FROM rocker/rstudio:latest

# Switch to root to set permissions
USER root

# Create the necessary directories with proper permissions
RUN mkdir -p /var/run/s6 /etc/s6 \
    && chmod -R 777 /var/run/s6 /etc/s6

# Ensure that RStudio directories are writable
RUN chmod -R 777 /home/rstudio /var/lib/rstudio-server

# Expose the RStudio server port
EXPOSE 8787

# Switch to a non-root user (OpenShift uses random UIDs)
USER 1000

# Start RStudio Server using the default command from the base image
ENTRYPOINT ["/init"]
