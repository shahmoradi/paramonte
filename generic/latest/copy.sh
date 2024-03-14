#!/bin/bash
####################################################################################################################################
####################################################################################################################################
####                                                                                                                            ####
####    ParaMonte: Parallel Monte Carlo and Machine Learning Library.                                                           ####
####                                                                                                                            ####
####    Copyright (C) 2012-present, The Computational Data Science Lab                                                          ####
####                                                                                                                            ####
####    This file is part of the ParaMonte library.                                                                             ####
####                                                                                                                            ####
####    LICENSE                                                                                                                 ####
####                                                                                                                            ####
####       https://github.com/cdslaborg/paramonte/blob/main/LICENSE.md                                                          ####
####                                                                                                                            ####
####################################################################################################################################
####################################################################################################################################

# This script copies the example and build script files that are
# automatically loaded into markdown files upon building the website.

CURRENT_DIR=$(pwd)
doc_dir="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"
caller_name="generic include"; source ../../../../auxil/install.init.sh
if ! [ -f "${paramonte_dir}/install.sh" ]; then
    echo >&2 "${pmfatal} The ParaMonte root directory is compromised: ${paramonte_dir}"
    exit 1
fi

doc_include_dir="${doc_dir}/_includes"
doc_include_paramonte_dir="${doc_include_dir}/paramonte"
doc_include_paramonte_src_dir="${doc_include_paramonte_dir}/src"
doc_include_paramonte_auxil_dir="${doc_include_paramonte_dir}/auxil"

echo >&2 "${pmnote} doc_include_dir: ${doc_include_dir}"
echo >&2 "${pmnote} doc_include_paramonte_dir: ${doc_include_paramonte_dir}"
echo >&2 "${pmnote} The ParaMonte root directory: ${paramonte_dir}"
echo >&2 "${pmnote} documentation directory: $doc_dir"
echo >&2 "${pmnote} current directory: $CURRENT_DIR"

if [ -d "${doc_include_paramonte_dir}" ]; then
    echo >&2 "${pmnote} Removing existing data at: \"${doc_include_paramonte_dir}\""
    rm -rf "${doc_include_paramonte_dir}"
fi

if ! [ -d "${doc_include_paramonte_src_dir}" ]; then
    mkdir -p "${doc_include_paramonte_src_dir}"
fi

if ! [ -d "${doc_include_paramonte_auxil_dir}" ]; then
    mkdir -p "${doc_include_paramonte_auxil_dir}"
fi

####
#### Copy the root files.
####

fname_list=(CHANGES.md ACKNOWLEDGMENT.md QUICKSTART.md CMakeLists.md install.md install.bat.md install.config.md install.sh.md)
for fname in ${fname_list[@]}; do
    echo >&2 "${pmnote} Copying ${fname} file..."
    origin="${paramonte_dir}/${fname}"
    destin="${doc_include_paramonte_dir}/${fname}"
    echo >&2 "${pmnote} origin: ${origin}"
    echo >&2 "${pmnote} destin: ${destin}"
    cp -arf "${origin}" "${destin}"
done

####
#### Copy the auxil files.
####

fname="shields.html"
echo >&2 "${pmnote} Copying ${fname} file..."
origin="${paramonte_auxil_dir}/${fname}"
destin="${doc_include_paramonte_auxil_dir}/${fname}"
echo >&2 "${pmnote} origin: ${origin}"
echo >&2 "${pmnote} destin: ${destin}"
cp -arf "${origin}" "${destin}"

####
#### Copy the example files.
####

fname="input.nml"
echo >&2 "${pmnote} Copying ${fname} file..."
origin="${paramonte_dir}/example/generic/pm_sampling/mvn"
destin="${doc_include_paramonte_dir}/example/generic/pm_sampling/mvn"
if ! [ -d "${destin}" ]; then
    mkdir -p "${destin}"
fi
echo >&2 "${pmnote} origin: ${origin}/${fname}"
echo >&2 "${pmnote} destin: ${destin}/${fname}"
cp -arf "${origin}/${fname}" "${destin}/${fname}"

####
#### Copy the CHANGES files.
####

for lang in ${paramonte_lang_list[@]}; do

    paramonte_src_lang_dir="${paramonte_src_dir}/${lang}"
    doc_include_paramonte_src_lang_dir="${doc_include_paramonte_src_dir}/${lang}"
    if ! [ -d "${doc_include_paramonte_src_lang_dir}" ]; then
        mkdir -p "${doc_include_paramonte_src_lang_dir}"
    fi
    origin="${paramonte_src_lang_dir}/CHANGES.md"
    destin="${doc_include_paramonte_src_lang_dir}/CHANGES.md"

    if [ -f "${origin}" ]; then
        echo >&2 "${pmnote} Copying ${lang} CHANGES.md file..."
        echo >&2 "${pmnote} origin: ${origin}"
        echo >&2 "${pmnote} destin: ${destin}"
        cp -arf "${origin}" "${destin}"
    fi

done