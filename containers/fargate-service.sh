#!/bin/bash

if [[ "$(aws ecs list-services --cluster default > 2>&1)" == "*serviceArns*" ]]; then
  echo "service already created!"
else
  aws ecs create-service --cluster default --service-name nginx --task-definition sample-fargate --launch-type "FARGATE"  --network-configuration "awsvpcConfiguration={subnets=[${AWS_SUBNET_ID}],securityGroups=[sg-0e11ea763d1da77fe],assignPublicIp=ENABLED}" --cli-input-json file:///root/project/containers/fargate-service.json
fi
