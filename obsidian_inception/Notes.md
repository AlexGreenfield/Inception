## Images
- The latest tag is prohibited.
- It is mandatory to use environment variables. Also, it is mandatory to use a .env file to store environment variables. 
## Other
- No password must be present in your Dockerfiles. It is strongly recommended that you use Docker secrets to store any confidential information. Any credentials, API keys, or passwords found in your Git repository (outside of properly configured secrets) will result in project failure.
- For obvious security reasons, any credentials, API keys, passwords, etc., must be saved locally in various ways/files and ignored by git. Publicly stored credentials will lead you directly to a failure of the project.
## Network
- When making the Dockerfile or Docker Compose File, remember to only expose port 443. That means that all the networking between the different containers must be handle inside the YAML file, and there's no need to expose another port besides 443 in NGINX.
	>Your NGINX container must be the only entrypoint into yourinfrastructure via the port 443 only, using the TLSv1.2 or TLSv1.3 protocol.`
