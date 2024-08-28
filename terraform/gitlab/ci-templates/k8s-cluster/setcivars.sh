export GITLAB_CURRENT_PROJECT_ID=$CI_PROJECT_ID
export GITLAB_PROVIDER_TOKEN=$GITLAB_CI_PAT
export GITLAB_PROVIDER_URL=$CI_SERVER_URL
export TF_CONTROL_STATE_TOKEN=$GITLAB_CI_PAT
export TF_CONTROL_STATE_USER=gitlab-ci-token
export TF_CONTROL_STATE_ADDRESS=$CI_API_V4_URL/projects/$BOOTSTRAP_PROJECT_ID/terraform/state/control-center-deploy
export cluster_name=$CI_PROJECT_NAME
#export CLUSTER_DOMAIN=$DOMAIN
export GITLAB_PROJECT_URL=$CI_PROJECT_URL
export GITLAB_SERVER_URL=$CI_SERVER_URL
export GITLAB_TOKEN=$GITLAB_CI_PAT
export GITLAB_USERNAME=root
export GITLAB_KEY_GITLAB_CI_PAT=GITLAB_CI_PAT
export GITLAB_API_URL=$CI_API_V4_URL
export GITLAB_CURRENT_GROUP_NAME=$CI_PROJECT_NAMESPACE
export ARGO_CD_ROOT_APP_PATH=apps
export movek8s_output_dir="$ANSIBLE_BASE_OUTPUT_DIR/k8s-deploy"
export KUBECONFIG_LOCATION=$movek8s_output_dir/kubeconfig
export K8S_STATE_NAMESPACE=kube-system