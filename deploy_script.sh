#!/bin/bash

# Check if the environment (prod or stag) was passed as an argument
if [ "$1" != "prod" ] && [ "$1" != "stag" ]; then
  echo "Usage: $0 {prod|stag} {env-update|deploy} [...]"
  exit 1
fi

# Setting the environment based on the argument
ENVIRONMENT="$1"
shift
ACTION="$1"
shift

# Defining variables based on the environment
if [ "$ENVIRONMENT" = "prod" ]; then
    PROJECT_ID="dotmoovs-app-prod"
    IMAGE_REPOSITORY="europe-west1-docker.pkg.dev/$PROJECT_ID/services"
    SERVICE_NAME="brain-service"  
    ENV_FILE="env_vars/prod.env"
else
    PROJECT_ID="dotmoovs-app-dev"
    IMAGE_REPOSITORY="europe-west1-docker.pkg.dev/$PROJECT_ID/services"
    SERVICE_NAME="brain-service"
    ENV_FILE="env_vars/stag.env"
fi

# Other variables remain the same
LOCATION="europe-west1"

echo $PROJECT_ID
echo $IMAGE_REPOSITORY
echo $SERVICE_NAME
echo $ENV_FILE

# Function for new deployment
new_deploy() {
    # Get the short commit hash (first 7 characters)
    export COMMIT_HASH=$(git rev-parse --short=7 HEAD)
    echo $COMMIT_HASH

    gcloud auth configure-docker \
    europe-west1-docker.pkg.dev

    docker build -t $IMAGE_REPOSITORY/brain-service:${COMMIT_HASH} .

    # Push the image to Artifact Registry
    docker push $IMAGE_REPOSITORY/brain-service:$COMMIT_HASH

    # Deploy the service to Cloud Run (remove PORT from env vars)
    gcloud run deploy "$SERVICE_NAME" \
    --image $IMAGE_REPOSITORY/brain-service:$COMMIT_HASH \
    --platform managed \
    --region "$LOCATION" \
    --project "$PROJECT_ID" \
    --allow-unauthenticated

    # Update environment variables
    update_env_vars
}


# Function to update environment variables
update_env_vars() {
  ENV_VARS=""
  while IFS= read -r line; do
    ENV_VARS+="$line,"
  done < "$ENV_FILE"

  # Remove the last comma
  ENV_VARS=${ENV_VARS%?}

  echo "Updating environment variables for the service $SERVICE_NAME:"
  echo "$ENV_VARS"

  gcloud run services update "$SERVICE_NAME" --set-env-vars "$ENV_VARS" --region "$LOCATION" --project "$PROJECT_ID"

}


# Check the main argument passed
case "$ACTION" in # Now checks for action instead of environment
    env-update)
        update_env_vars
        ;;
    deploy)
        new_deploy
        ;;
    *)
        echo "Usage: $0 $ENVIRONMENT {env-update|deploy}"
        exit 1
        ;;
esac
