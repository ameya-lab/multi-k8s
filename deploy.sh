docker build -t ameyad22/multi-client:latest -t ameyad22/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ameyad22/multi-server:latest -t ameyad22/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ameyad22/multi-worker:latest -t ameyad22/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ameyad22/multi-client:latest
docker push ameyad22/multi-server:latest
docker push ameyad22/multi-worker:latest

docker push ameyad22/multi-client:$SHA
docker push ameyad22/multi-server:$SHA
docker push ameyad22/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ameyad22/multi-server:$SHA
kubectl set image deployments/client-deployment client=ameyad22/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ameyad22/multi-worker:$SHA