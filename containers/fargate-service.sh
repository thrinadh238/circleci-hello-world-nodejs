#!/bin/sh
# set -o errexit

case "$(aws ecs list-services --cluster default 2> /dev/null | grep serviceArn)" in
    *serviceArn*)
	    echo "ServiceArn Exists"
        ;;
     *)
  aws ecs create-service --cluster default --service-name nginx --task-definition sample-fargate --launch-type "FARGATE"  --network-configuration "awsvpcConfiguration={subnets=[${AWS_SUBNET_ID}],securityGroups=[sg-0e11ea763d1da77fe],assignPublicIp=ENABLED}" --cli-input-json file:///root/project/containers/fargate-service.json
    ;;
esac
