#!/bin/bash


# load the environment
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source ${SCRIPT_DIR}/env.sh

# make build dir
if [ ! -e ${INFERO_BUILD_DIR} ]; then
  echo "Creating dir ${INFERO_BUILD_DIR}.."
  mkdir -p ${INFERO_BUILD_DIR}
fi

echo "cd in ${INFERO_BUILD_DIR}.."
cd ${INFERO_BUILD_DIR}


echo "Executing Cmake.."

# Base command
INFERO_CMAKE_CMD="${ECBUILD_BUILD_EXE} \
-Deckit_ROOT=${ECKIT_BUILD_DIR} \
-DENABLE_MPI=${WITH_MPI}"

INFERO_CMAKE_CMD="${INFERO_CMAKE_CMD} -DENABLE_TF_LITE=${WITH_TFLITE_RUNTIME}"
if [ ${WITH_TFLITE_RUNTIME} == ON ]; then
  INFERO_CMAKE_CMD="${INFERO_CMAKE_CMD} \
  -DTENSORFLOWLITE_PATH=${TFLITE_SOURCE_DIR} \
  -DTENSORFLOWLITE_ROOT=${TFLITE_BUILD_DIR}"
fi

# TF_C
INFERO_CMAKE_CMD="${INFERO_CMAKE_CMD} -DENABLE_TF_C=${WITH_TF_C_RUNTIME}"
if [ ${WITH_TF_C_RUNTIME} == ON ]; then
  INFERO_CMAKE_CMD="${INFERO_CMAKE_CMD} -DTENSORFLOWC_ROOT=${ROOT_INSTALL_DIR}"
fi

# ONNX runtime
INFERO_CMAKE_CMD="${INFERO_CMAKE_CMD} -DENABLE_ONNX=${WITH_ONNX_RUNTIME}"
if [ ${WITH_ONNX_RUNTIME} == ON ]; then
  INFERO_CMAKE_CMD="${INFERO_CMAKE_CMD} -DONNX_ROOT=${ROOT_INSTALL_DIR}"
fi

# TENSORRT
INFERO_CMAKE_CMD="${INFERO_CMAKE_CMD} -DENABLE_TENSORRT=${WITH_TRT}"
if [ ${WITH_TRT} == ON ]; then
  INFERO_CMAKE_CMD="${INFERO_CMAKE_CMD} -DTENSORRT_ROOT=${ROOT_INSTALL_DIR}"
fi

# FCKIT
INFERO_CMAKE_CMD="${INFERO_CMAKE_CMD} -DENABLE_FCKIT=${WITH_FCKIT}"
if [ ${WITH_FCKIT} == ON ]; then
  INFERO_CMAKE_CMD="${INFERO_CMAKE_CMD} -DFCKIT_ROOT=${ROOT_INSTALL_DIR}"
fi

# Infero sources
INFERO_CMAKE_CMD="${INFERO_CMAKE_CMD} ${INFERO_SRC_DIR}"

if [ ${INFERO_VERBOSE_COMPILATION} == "0" ]; then
  INFERO_MAKE_CMD="make" 
else
  INFERO_MAKE_CMD="make VERBOSE=1" 
fi

#execute cmake and make
${INFERO_CMAKE_CMD} && ${INFERO_MAKE_CMD}

echo "all done."
