echo Building...
docker build -t echoteas-api-production -f ./src/api/Dockerfile --build-arg APP_ENV=production ./src/api
docker build -t echoteas-worker-production -f ./src/worker/Dockerfile --build-arg APP_ENV=production ./src/worker
