load("@io_bazel_rules_k8s//k8s:objects.bzl", "k8s_objects")
load("@k8s_deploy//:defaults.bzl", "k8s_deploy")
load("@username//:user.bzl", "USER_NAME")

def gen_targets():
    substitutions = {
        "{CLUSTER_NAME}": "cluster-" + USER_NAME,
        "{BUILD_USER}": USER_NAME,
    }

    all = [
        # Namespace has to come first!
        "spire-namespace",

        # OK now just alphabetical
        "agent-account",
        "agent-cluster-role",
        "agent-configmap",
        "agent-daemonset",
        "k8s-workload-registrar-certs",
        "k8s-workload-registrar-configmap",
        "k8s-workload-registrar-secret",
        #        "k8s-workload-registrar-server-key",
        "k8s-workload-registrar-webhook",
        "server-account",
        "server-cluster-role",
        "server-configmap",
        "server-service",
        "server-statefulset",
        "spire-bundle-configmap",
    ]

    for target in all:
        k8s_deploy(
            name = target,
            substitutions = substitutions,
            template = ":" + target + ".yaml",
        )

    k8s_objects(
        name = "k8s-all",
        objects = all,
        visibility = ["//visibility:public"],
    )
