# TODO

## k8s简介

* 1.1 kubernetes是什么
* 1.2 kubernetes不是什么
* 1.3 为什么用kubernetes
* 1.4 kubernetes基本概念和术语
* 1.5 简单demo应用

## 环境搭建

* 2.1 使用kubeadm + vagrant搭建开发环境
* 2.2 常用命令
* 2.3 demo验证

## 核心原理

* 3.1 架构原理
* 3.2 核心组件
* 3.3 资源对象

## 实践

* 4.1 如何将应用k8s化
    * 4.1.1 k8s化步骤
* 4.2 部署pod
    * 4.2.1 yaml
    * 4.2.2 部署 (create/apply)
    * 4.2.3 验证 (get/describe)
* 4.3 pod的生命周期
    * 4.3.1 pod解析
    * 4.3.2 init容器
    * 4.3.3 pause容器
    * 4.3.4 pod的生命周期(liveness/readiness)
* 4.4 集群资源管理
    * 4.4.1 Node
    * 4.4.2 Namespace
    * 4.4.3 Label
    * 4.4.4 Annotation
    * 4.4.5 Taint & Toleration
* 4.5 Controller
    * 4.5.1 Deployment
    * 4.5.2 StatefulSet
    * 4.5.3 DaemonSet
    * 4.5.4 Replica
    * 4.5.6 Job
    * 4.5.7 CronJob
* 4.6 Service
    * 4.6.1 yaml
    * 4.6.2 部署
    * 4.6.3 验证
    * 4.6.4 iptables
* 4.7 存储
    * 4.7.1 Secret
    * 4.7.2 ConfigMap (热更新)
    * 4.7.3 PV
    * 4.7.4 PVC

## 运维

* 5.1 RBAC
* 5.2 网络
* 5.3 监控
    * 5.3.1 prometheus
    * 5.3.2 exporter
    * 5.3.3 prometheus-operator
    * 5.3.4 heapster
* 5.4 日志(ELK + filebeat)
* 5.5 quota