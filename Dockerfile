# Use the RStudio image from the Rocker Project
FROM rocker/rstudio:latest

# Switch to root to set permissions
USER root

# Create /var/run/s6 and /etc/s6 with full write permissions for all users
RUN mkdir -p /var/run/s6 /etc/s6 \
    && chmod -R 777 /var/run/s6 /etc/s6

# Ensure the RStudio directories are also writable by any user
RUN chmod -R 777 /home/rstudio /var/lib/rstudio-server

# Expose the RStudio server port
EXPOSE 8787

# Switch to non-root user (OpenShift uses random UIDs, this is just a placeholder)
USER 1000

# Start RStudio Server using the default CMD from the base image
CMD
