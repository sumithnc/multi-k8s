docker build -t sumithnc143/multi-client:latest -t sumithnc143/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sumithnc143/multi-server:latest -t sumithnc143/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sumithnc143/multi-worker:latest -t sumithnc143/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sumithnc143/multi-client:latest
docker push sumithnc143/multi-server:latest
docker push sumithnc143/multi-worker:latest

docker push sumithnc143/multi-client:$SHA
docker push sumithnc143/multi-server:$SHA
docker push sumithnc143/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sumithnc143/multi-server:$SHA
kubectl set image deployments/client-deployment client=sumithnc143/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sumithnc143/multi-worker:$SHA