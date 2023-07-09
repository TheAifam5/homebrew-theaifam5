class Kas < Formula
  include Language::Python::Virtualenv

  desc "Setup tool for bitbake based projects"
  homepage "https://github.com/siemens/kas"
  url "https://github.com/siemens/kas/archive/4.0.tar.gz"
  sha256 "9af6ef028cb3bb00fe11185eb911f3bb941ad6fb207594de1190e03398f5c5eb"
  license "MIT" # https://github.com/siemens/kas/issues/86
  head "https://github.com/siemens/kas.git", branch: "master"

  depends_on "python@3.11"
  depends_on "coreutils"

  patch :DATA

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/a0/a4/d63f2d7597e1a4b55aa3b4d6c5b029991d3b824b5bd331af8d4ab1ed687d/PyYAML-5.4.1.tar.gz"
    sha256 "607774cbba28732bfa802b54baa7484215f530991055bb562efbed5b2f20a45e"
  end

  resource "distro" do
    url "https://files.pythonhosted.org/packages/4b/89/eaa3a3587ebf8bed93e45aa79be8c2af77d50790d15b53f6dfc85b57f398/distro-1.8.0.tar.gz"
    sha256 "02e111d1dc6a50abb8eed6bf31c3e48ed8b0830d1ea2a1b78c61765c2513fdd8"
  end

  resource "jsonschema" do
    url "https://files.pythonhosted.org/packages/69/11/a69e2a3c01b324a77d3a7c0570faa372e8448b666300c4117a516f8b1212/jsonschema-3.2.0.tar.gz"
    sha256 "c8a85b28d377cc7737e46e2d9f2b4f44ee3c0e1deac6bf46ddefc7187d30797a"
  end

  resource "kconfiglib" do
    url "https://files.pythonhosted.org/packages/59/29/d557718c84ef1a8f275faa4caf8e353778121beefbe9fadfa0055ca99aae/kconfiglib-14.1.0.tar.gz"
    sha256 "bed2cc2216f538eca4255a83a4588d8823563cdd50114f86cf1a2674e602c93c"
  end

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/97/90/81f95d5f705be17872843536b1868f351805acf6971251ff07c1b8334dbb/attrs-23.1.0.tar.gz"
    sha256 "6279836d581513a26f1bf235f9acd333bc9115683f14f7e8fae46c98fc50e015"
  end

  resource "pyrsistent" do
    url "https://files.pythonhosted.org/packages/bf/90/445a7dbd275c654c268f47fa9452152709134f61f09605cf776407055a89/pyrsistent-0.19.3.tar.gz"
    sha256 "1a2994773706bbb4995c31a97bc94f1418314923bd1048c6d964837040376440"
  end

  def python3
    "python3.11"
  end

  def install
    virtualenv_install_with_resources
  end
end


__END__
diff --git a/kas-container b/kas-container
index 8fa2d16..3abe5f6 100755
--- a/kas-container
+++ b/kas-container
@@ -147,10 +147,10 @@ set_container_image_var() {
 	KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE:-${KAS_CONTAINER_IMAGE_DEFAULT}}"
 }
 
-KAS_WORK_DIR=$(readlink -fv "${KAS_WORK_DIR:-$(pwd)}")
+KAS_WORK_DIR=$(greadlink -fv "${KAS_WORK_DIR:-$(pwd)}")
 # KAS_WORK_DIR needs to exist for the subsequent code
 trace mkdir -p "${KAS_WORK_DIR}"
-KAS_BUILD_DIR=$(readlink -fv "${KAS_BUILD_DIR:-${KAS_WORK_DIR}/build}")
+KAS_BUILD_DIR=$(greadlink -fv "${KAS_BUILD_DIR:-${KAS_WORK_DIR}/build}")
 trace mkdir -p "${KAS_BUILD_DIR}"
 
 KAS_CONTAINER_ENGINE="${KAS_CONTAINER_ENGINE:-${KAS_DOCKER_ENGINE}}"
@@ -236,7 +236,7 @@ while [ $# -gt 0 ]; do
 		shift 2
 		;;
 	--ssh-agent)
-		KAS_SSH_AUTH_SOCK=$(readlink -fv "$SSH_AUTH_SOCK")
+		KAS_SSH_AUTH_SOCK=$(greadlink -fv "$SSH_AUTH_SOCK")
 		shift 1
 		;;
 	--aws-dir)
@@ -344,7 +344,7 @@ while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 		# SC2086: Double quote to prevent globbing and word splitting.
 		# shellcheck disable=2086
 		for FILE in $(IFS=':'; echo $1); do
-			if ! KAS_REAL_FILE="$(realpath -qe "$FILE")"; then
+			if ! KAS_REAL_FILE="$(grealpath -qe "$FILE")"; then
 				echo "Error: configuration file '${FILE}' not found"
 				exit 1
 			fi
@@ -365,7 +365,7 @@ while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 done
 
 if [ -n "${KAS_FIRST_FILE}" ]; then
-	KAS_FILE_DIR="$(dirname "${KAS_FIRST_FILE}")"
+	KAS_FILE_DIR="$(gdirname "${KAS_FIRST_FILE}")"
 	KAS_REPO_DIR=$(git -C "${KAS_FILE_DIR}" rev-parse --show-toplevel 2>/dev/null) \
 		|| KAS_REPO_DIR=$(hg --cwd "${KAS_FILE_DIR}" root 2>/dev/null) \
 		|| KAS_REPO_DIR=${KAS_FILE_DIR}
@@ -391,11 +391,11 @@ if [ "${KAS_CMD}" = "menu" ]; then
 	# on the host. This data is then added to the .config.yaml where it can
 	# be evaluated by the next invocation of kas-container.
 
-	if ! [ "$(realpath -qe "${KAS_REPO_DIR}")" = "$(realpath -qe "${KAS_WORK_DIR}")" ]; then
-		set -- "$@" -e _KAS_REPO_DIR_HOST="$(readlink -fv "${KAS_REPO_DIR}")"
+	if ! [ "$(grealpath -qe "${KAS_REPO_DIR}")" = "$(grealpath -qe "${KAS_WORK_DIR}")" ]; then
+		set -- "$@" -e _KAS_REPO_DIR_HOST="$(greadlink -fv "${KAS_REPO_DIR}")"
 	fi
 
-	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < ${KAS_FIRST_FILE} | \
+	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_FILE}" | \
 		sed -e 's/\(.*\fconfig KAS_BUILD_SYSTEM\f\(.*\)\|.*\)/\2/' \
 		    -e 's/\f\([[:alpha:]].*\|$\)//' \
 		    -e 's/.*default \"\(.*\)\".*/\1/')
@@ -427,7 +427,7 @@ if [ "$(id -u)" -eq 0 ] && [ "${KAS_ALLOW_ROOT}" != "yes" ] ; then
 	exit 1
 fi
 
-set -- "$@" -v "${KAS_REPO_DIR}":/repo:${KAS_REPO_MOUNT_OPT} \
+set -- "$@" -v "${KAS_REPO_DIR}":/repo:"${KAS_REPO_MOUNT_OPT}" \
 	-v "${KAS_WORK_DIR}":/work:rw -e KAS_WORK_DIR=/work \
 	-v "${KAS_BUILD_DIR}":/build:rw \
 	--workdir=/repo \
@@ -439,7 +439,7 @@ if [ -n "${KAS_SSH_DIR}" ] ; then
 		echo "Passed KAS_SSH_DIR '${KAS_SSH_DIR}' is not a directory"
 		exit 1
 	fi
-	set -- "$@" -v "$(readlink -fv "${KAS_SSH_DIR}")":/var/kas/userdata/.ssh:ro
+	set -- "$@" -v "$(greadlink -fv "${KAS_SSH_DIR}")":/var/kas/userdata/.ssh:ro
 fi
 
 if [ -n "${KAS_SSH_AUTH_SOCK}" ]; then
@@ -456,7 +456,7 @@ if [ -n "${KAS_AWS_DIR}" ] ; then
 		echo "Passed KAS_AWS_DIR '${KAS_AWS_DIR}' is not a directory"
 		exit 1
 	fi
-	set -- "$@" -v "$(readlink -fv "${KAS_AWS_DIR}")":/var/kas/userdata/.aws:ro \
+	set -- "$@" -v "$(greadlink -fv "${KAS_AWS_DIR}")":/var/kas/userdata/.aws:ro \
 		-e AWS_CONFIG_FILE="${AWS_CONFIG_FILE:-/var/kas/userdata/.aws/config}" \
 		-e AWS_SHARED_CREDENTIALS_FILE="${AWS_SHARED_CREDENTIALS_FILE:-/var/kas/userdata/.aws/credentials}"
 fi
@@ -469,7 +469,7 @@ if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
 		exit 1
 	fi
 	KAS_GIT_CREDENTIAL_HELPER_DEFAULT="store --file=/var/kas/userdata/.git-credentials"
-	set -- "$@" -v "$(readlink -fv "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
+	set -- "$@" -v "$(greadlink -fv "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
 fi
 
 GIT_CREDENTIAL_HELPER="${GIT_CREDENTIAL_HELPER:-${KAS_GIT_CREDENTIAL_HELPER_DEFAULT}}"
@@ -479,7 +479,7 @@ if [ -n "${GIT_CREDENTIAL_HELPER}" ] ; then
 fi
 
 if [ -f "${NETRC_FILE}" ]; then
-	set -- "$@" -v "$(readlink -fv "${NETRC_FILE}")":/var/kas/userdata/.netrc:ro \
+	set -- "$@" -v "$(greadlink -fv "${NETRC_FILE}")":/var/kas/userdata/.netrc:ro \
 		-e NETRC_FILE="/var/kas/userdata/.netrc"
 fi
 
@@ -490,14 +490,14 @@ fi
 if [ -n "${DL_DIR}" ]; then
 	trace mkdir -p "${DL_DIR}"
 	set -- "$@" \
-		-v "$(readlink -fv "${DL_DIR}")":/downloads:rw \
+		-v "$(greadlink -fv "${DL_DIR}")":/downloads:rw \
 		-e DL_DIR=/downloads
 fi
 
 if [ -n "${SSTATE_DIR}" ]; then
 	trace mkdir -p "${SSTATE_DIR}"
 	set -- "$@" \
-		-v "$(readlink -fv "${SSTATE_DIR}")":/sstate:rw \
+		-v "$(greadlink -fv "${SSTATE_DIR}")":/sstate:rw \
 		-e SSTATE_DIR=/sstate
 fi
 
@@ -507,7 +507,7 @@ if [ -n "${KAS_REPO_REF_DIR}" ]; then
 		exit 1
 	fi
 	set -- "$@" \
-		-v "$(readlink -fv "${KAS_REPO_REF_DIR}")":/repo-ref:rw \
+		-v "$(greadlink -fv "${KAS_REPO_REF_DIR}")":/repo-ref:rw \
 		-e KAS_REPO_REF_DIR=/repo-ref
 fi
 
@@ -559,4 +559,4 @@ while [ $KAS_EXTRA_BITBAKE_ARGS -gt 0 ]; do
 	KAS_EXTRA_BITBAKE_ARGS=$((KAS_EXTRA_BITBAKE_ARGS - 1))
 done
 
-trace ${KAS_CONTAINER_COMMAND} run "$@"
+trace "${KAS_CONTAINER_COMMAND}" run "$@"
