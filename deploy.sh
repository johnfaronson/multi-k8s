docker build -t johnfaronson/multi-client:latest -t johnfaronson/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t johnfaronson/multi-server:latest -t johnfaronson/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t johnfaronson/multi-worker:latest -t johnfaronson/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push johnfaronson/multi-client:latest
docker push johnfaronson/multi-server:latest 
docker push johnfaronson/multi-worker:latest
docker push johnfaronson/multi-client:$SHA
docker push johnfaronson/multi-server:$SHA
docker push johnfaronson/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=johnfaronson/multi-client:$SHA
kubectl set image deployments/server-deployment server=johnfaronson/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=johnfaronson/multi-worker:$SHA
