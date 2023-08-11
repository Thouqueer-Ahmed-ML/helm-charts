#!/bin/bash -x
export PATH=/opt/microsoft/powershell/7:~/.local/bin:~/bin:~/.dotnet/tools:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/istio-latest/bin:/usr/local/linkerd/bin:/usr/lib/golang/bin:/opt/mssql-tools18/bin:~/bundle/bin:~/bundle/gems/bin:/home/asraf/.local/share/powershell/Scripts

  ###Package required for interactive session for argocd login
  echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
  sudo apt-get -y install expect
  
  ###Installation of ArgoCD cli
  sudo curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
  sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
  sudo rm argocd-linux-amd64

  ###command to get ArgoCD server LoadBalancer IP
  argocdserver=$(kubectl get svc argocd-server -n argocd | awk NR==2'{print $4}')
  
  ###command to get ArgoCD initial password
  argocd admin initial-password -n argocd > test
  argocdpassword=$(sudo cat test | awk NR==1)

  ###Interactive session for ArgoCD login CLI
  echo "Session for ArgoCD login CLI"
  argocd login $argocdserver --username admin --password $argocdpassword --insecure

  sleep 10
  ###Interactive session for updating ArgoCD password
  echo "CLI to update ArgoCD password"
  argocd account update-password --current-password $argocdpassword --new-password admin@123 --server $argocdserver --insecure

  sleep 10
  ###Interactive session for ArgoCD login CLI
  echo "Session for ArgoCD login CLI with new password"
  argocd login $argocdserver --username admin --password admin@123 --insecure

  sleep 10
  sudo rm -rf test
