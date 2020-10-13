docker build -t rsmadhavan/multi-client:latest -t rsmadhavan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rsmadhavan/multi-server:latest -t rsmadhavan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rsmadhavan/multi-worker:latest -t rsmadhavan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rsmadhavan/multi-client:latest
docker push rsmadhavan/multi-server:latest
docker push rsmadhavan/multi-worker:latest

docker push rsmadhavan/multi-client:$SHA
docker push rsmadhavan/multi-server:$SHA
docker push rsmadhavan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment server=rsmadhavan/multi-client:$SHA
kubectl set image deployments/server-deployment server=rsmadhavan/multi-server:$SHA
kubectl set image deployments/worker-deployment server=rsmadhavan/multi-server:$SHA
