---
title: 软件包与工具
author: "沈维燕"
date: '2019-01-01'
---


## R 包

### DoAbsolute

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![GitHub
tag](https://img.shields.io/github/tag/ShixiangWang/DoAbsolute.svg?label=Github)](https://github.com/ShixiangWang/DoAbsolute)

**主页**: <https://github.com/ShixiangWang/DoAbsolute>

The goal of **DoAbsolute** is to automate ABSOLUTE calling for multiple
samples in parallel way.

[ABSOLUTE](https://www.nature.com/articles/nbt.2203) is a famous
software developed by Broad Institute, however, the **RunAbsolute**
function is designed for computing one sample each time and set no
default values. **DoAbsolute** helps user set default parameters
according to [ABSOLUTE
documentation](http://software.broadinstitute.org/cancer/software/genepattern/modules/docs/ABSOLUTE),
provides a uniform interface to input data easily and runs **RunAbsolute**
parallelly.

### metawho

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/metawho)](https://cran.r-project.org/package=metawho)
[![](http://cranlogs.r-pkg.org/badges/grand-total/metawho?color=blue)](https://cran.r-project.org/package=metawho)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/ShixiangWang/metawho?branch=master&svg=true)](https://ci.appveyor.com/project/ShixiangWang/metawho)
[![Travis build
status](https://travis-ci.org/ShixiangWang/metawho.svg?branch=master)](https://travis-ci.org/ShixiangWang/metawho)
[![Coverage
status](https://codecov.io/gh/ShixiangWang/metawho/branch/master/graph/badge.svg)](https://codecov.io/github/ShixiangWang/metawho?branch=master)

<!-- badges: end -->

**主页**: <https://github.com/ShixiangWang/metawho>

The goal of **metawho** is to provide simple R implementation of
"Meta-analytical method to Identify Who Benefits Most from Treatments".

**metawho** is powered by R package **metafor** and does not support
dataset contains individuals for now. Please use Stata package
**ipdmetan** if you are more familiar with Stata code.

### sigminer

<!-- badges: start -->
[![CRAN
status](https://www.r-pkg.org/badges/version/sigminer)](https://cran.r-project.org/package=sigminer)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/ShixiangWang/sigminer?branch=master&svg=true)](https://ci.appveyor.com/project/ShixiangWang/sigminer)
[![Travis build
status](https://travis-ci.org/ShixiangWang/sigminer.svg?branch=master)](https://travis-ci.org/ShixiangWang/sigminer)
[![Coverage
status](https://codecov.io/gh/ShixiangWang/sigminer/branch/master/graph/badge.svg)](https://codecov.io/github/ShixiangWang/sigminer?branch=master)
[![](http://cranlogs.r-pkg.org/badges/grand-total/sigminer?color=orange)](https://cran.r-project.org/package=sigminer)

<!-- badges: end -->

**主页**: <https://github.com/ShixiangWang/sigminer>

The goal of **sigminer** is to provide a uniform interface for genomic variation signature analysis and visualization.

### UCSCXenaTools

<!-- badges: start -->

[![CRAN](http://www.r-pkg.org/badges/version-last-release/UCSCXenaTools)](https://cran.r-project.org/package=UCSCXenaTools)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/ropensci/UCSCXenaTools?branch=master&svg=true)](https://ci.appveyor.com/project/ShixiangWang/UCSCXenaTools)
[![Travis build
status](https://travis-ci.org/ropensci/UCSCXenaTools.svg?branch=master)](https://travis-ci.org/ropensci/UCSCXenaTools)

![](http://cranlogs.r-pkg.org/badges/UCSCXenaTools)
![](http://cranlogs.r-pkg.org/badges/grand-total/UCSCXenaTools)
[![Coverage
Status](https://img.shields.io/codecov/c/github/ShixiangWang/UCSCXenaTools/master.svg)](https://codecov.io/github/ShixiangWang/UCSCXenaTools?branch=master)
[![GitHub
issues](https://img.shields.io/github/issues/ropensci/UCSCXenaTools.svg)](https://github.com/ropensci/UCSCXenaTools/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+)
[![Closed
issues](https://img.shields.io/github/issues-closed/ropensci/UCSCXenaTools.svg)](https://github.com/ropensci/UCSCXenaTools/issues?q=is%3Aissue+is%3Aclosed)
<!-- badges: end -->

**主页**: <https://github.com/ShixiangWang/UCSCXenaTools>

**UCSCXenaTools** is an R package for downloading and exploring data
from [**UCSC Xena data hubs**](https://xenabrowser.net/datapages/),
which are a collection of UCSC-hosted public databases such as TCGA,
ICGC, TARGET, GTEx, CCLE, and others. Databases are normalized so they
can be combined, linked, filtered, explored and downloaded.

**文档**:

- [Introduction and basic usage of **UCSCXenaTools**](../../en/tools/ucscxenatools-intro)
- [APIs of **UCSCXenaTools**](../../en/tools/ucscxenatools-api)

### UCSCXenaShiny

<!-- badges: start -->
[![CRAN
status](https://www.r-pkg.org/badges/version/UCSCXenaShiny)](https://cran.r-project.org/package=UCSCXenaShiny)
[![](http://cranlogs.r-pkg.org/badges/grand-total/UCSCXenaShiny?color=orange)](https://cran.r-project.org/package=UCSCXenaShiny)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/openbiox/XenaShiny.svg?branch=master)](https://travis-ci.org/openbiox/XenaShiny)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/openbiox/XenaShiny?branch=master&svg=true)](https://ci.appveyor.com/project/openbiox/XenaShiny)
[![Coverage
status](https://codecov.io/gh/openbiox/XenaShiny/branch/master/graph/badge.svg)](https://codecov.io/github/openbiox/XenaShiny?branch=master)
<!-- badges: end -->

**主页**: <https://github.com/openbiox/XenaShiny>

**UCSCXenaShiny** is Shiny app for [UCSC Xena](https://xenabrowser.net/), this package is built on the
top of **Shiny** and **UCSCXenaTools** etc..

### contribution

<!-- badges: start -->
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/ShixiangWang/contribution?branch=master&svg=true)](https://ci.appveyor.com/project/ShixiangWang/contribution)
[![Travis build status](https://travis-ci.org/ShixiangWang/contribution.svg?branch=master)](https://travis-ci.org/ShixiangWang/contribution)
[![Lifecycle: maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN status](https://www.r-pkg.org/badges/version/contribution)](https://cran.r-project.org/package=contribution)
[![](http://cranlogs.r-pkg.org/badges/grand-total/contribution?color=green)](https://cran.r-project.org/package=contribution)
<!-- badges: end -->

**主页**: <https://github.com/ShixiangWang/contribution>

The goal of **contribution** is to generate **contribution table** for credit assignment in a project. 
This is inspired by Nick Steinmetz (see twitter <https://twitter.com/SteinmetzNeuro/status/1147241138291527681>). 

**文档**:

- [A Tiny Contribution Table Generator Based on ggplot2](../../en/tools/contribution-table)


## Linux 工具

### sync-deploy

[![DOI](https://zenodo.org/badge/119467219.svg)](https://zenodo.org/badge/latestdoi/119467219) [![Open Source Love svg1](https://badges.frapsoft.com/os/v1/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/) [![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://raw.githubusercontent.com/ShixiangWang/sync-deploy/master/LICENSE) [![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/ShixiangWang/sync-deploy/graphs/commit-activity)

**主页**: <https://github.com/ShixiangWang/sync-deploy>

**sync-deploy** is a shell toolkit for deploying script/command task on a remote host, including up/download files, run script and more.

### Variants2Neoanitgen

**主页**: <https://github.com/ShixiangWang/Variants2Neoantigen>

**Variants2Neoanitgen** is a neoantigen calling pipeline begins from variants record file (MAF).

> Of note, VCF file as input is not supported
