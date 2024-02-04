# Use an official Ruby runtime as a parent image
FROM ruby:3.2.0

# Set the working directory in the container
WORKDIR /app

# Copy Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install any needed gems
RUN bundle install

# Copy the current directory contents into the container
COPY . .

# Make port 3000 available to the world outside this container
EXPOSE 3000

# Define environment variable
ENV RAILS_ENV=development

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Run app when the container launches
CMD ["rails", "server", "-b", "0.0.0.0"]