docker build -t jfaronson/multi-client:latest -t jfaronson/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jfaronson/multi-server:latest -t jfaronson/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jfaronson/multi-worker:latest -t jfaronson/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jfaronson/multi-client:latest
docker push jfaronson/multi-server:latest 
docker push jfaronson/multi-worker:latest
docker push jfaronson/multi-client:$SHA
docker push jfaronson/multi-server:$SHA
docker push jfaronson/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jfaronson/multi-client:$SHA
kubectl set image deployments/server-deployment server=jfaronson/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jfaronson/multi-worker:$SHA
