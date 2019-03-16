docker build -t nrjchnd2/multi-client:latest -t nrjchnd2/multi-client:$SHA -f ./client Dockerfile ./client
docker build -t nrjchnd2/multi-server:latest -t nrjchnd2/multi-server:$SHA -f ./server Dockerfile ./server
docker build -t nrjchnd2/multi-worker:latest -t nrjchnd2/multi-worker:$SHA -f ./worker Dockerfile ./worker

docker push nrjchnd2/multi-client:latest
docker push nrjchnd2/multi-server:latest
docker push nrjchnd2/multi-worker:latest

docker push nrjchnd2/multi-client:$SHA
docker push nrjchnd2/multi-server:$SHA
docker push nrjchnd2/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nrjchnd2/multi-server:$SHA
kubectl set image deployments/client-deployment client=nrjchnd2/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nrjchnd2/multi-worker:$SHA