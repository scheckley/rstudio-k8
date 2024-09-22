# Use the RStudio image from the Rocker Project
FROM rocker/rstudio:latest

# Switch to root to set permissions
USER root

# Create /var/run/s6 and /etc/s6, and set the proper permissions
# Allow any user to write to these directories (g=u allows OpenShift's random UID)
RUN mkdir -p /var/run/s6 /etc/s6 \
    && chown -R 0:0 /var/run/s6 /etc/s6 \
    && chmod -R 777 /var/run/s6 /etc/s6

# Ensure that other important directories are also writable
RUN chown -R 0:0 /home/rstudio /var/lib/rstudio-server \
    && chmod -R 777 /home/rstudio /var/lib/rstudio-server

# Expose RStudio server port
EXPOSE 8787

# Switch to a non-root user (OpenShift uses random UIDs)
USER 1000

# Start RStudio Server using the default CMD from the base image
CMD ["/init"]
