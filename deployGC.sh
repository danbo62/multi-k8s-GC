docker build -t danbo62/multi-client:latest -t danbo62/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t danbo62/multi-server:latest -t danbo62/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t danbo62/multi-worker:latest -t danbo62/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push danbo62/multi-client:latest
docker push danbo62/multi-server:latest
docker push danbo62/multi-worker:latest

docker push danbo62/multi-client:$SHA
docker push danbo62/multi-server:$SHA
docker push danbo62/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=danbo62/multi-client:$SHA
kubectl set image deployments/server-deployment server=danbo62/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=danbo62/multi-worker:$SHA