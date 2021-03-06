FROM ubuntu:latest

# Install cron
RUN apt-get update
RUN apt-get install -y cron
RUN apt-get install -y curl

# Add crontab file in the cron directory
ADD ./services/cron.scheduler-tick/crontab /etc/cron.d/tick-cron

# Add shell script and grant execution rights
ADD ./services/cron.scheduler-tick/script.sh /script.sh
RUN chmod +x /script.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/tick-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log