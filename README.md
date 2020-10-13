# Terraform Trivadis LAB VCN for OCI

## Introduction

A reusable and extensible Terraform module that provisions a Trivadis LAB VCN on Oracle Cloud Infrastructure

It creates the following resources:

* A VCN with customizable CIDR block
* An optional internet gateway
* An optional NAT gateway
* An optional service gateway
* Optional n-number of VCNs. This is used to build several identical environments for a training and laboratory environment.

The module can be parametrized by the number of participants. This will then create n-VCNs.

![VCN architecture overview](https://github.com/Trivadis/terraform-oci-tvdlab-vcn/raw/main/doc/images/architecture.png)

## Documentation

### Pre-requisites

tbd

### Instructions

tbd

## Related Documentation, Blog

- [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/iaas/Content/home.htm)
- [Terraform OCI Provider Documentation](https://www.terraform.io/docs/providers/oci/index.html)

## Projects using this module

tbd

## Releases and Changelog

You find all releases and release information [here](https://github.com/Trivadis/terraform-oci-tvdlab-vcn/releases).

## Issues
Please file your bug reports, enhancement requests, questions and other support requests within [Github's issue tracker](https://help.github.com/articles/about-issues/).

* [Questions](https://github.com/Trivadis/terraform-oci-tvdlab-vcn/issues?q=is%3Aissue+label%3Aquestion)
* [Open enhancements](https://github.com/Trivadis/terraform-oci-tvdlab-vcn/issues?q=is%3Aopen+is%3Aissue+label%3Aenhancement)
* [Open bugs](https://github.com/Trivadis/terraform-oci-tvdlab-vcn/issues?q=is%3Aopen+is%3Aissue+label%3Abug)
* [Submit new issue](https://github.com/Trivadis/terraform-oci-tvdlab-vcn/issues/new)

## How to Contribute

1. Describe your idea by [submitting an issue](https://github.com/Trivadis/terraform-oci-tvdlab-vcn/issues/new)
2. [Fork this respository](https://github.com/Trivadis/terraform-oci-tvdlab-vcn/fork)
3. [Create a branch](https://help.github.com/articles/creating-and-deleting-branches-within-your-repository/), commit and publish your changes and enhancements
4. [Create a pull request](https://help.github.com/articles/creating-a-pull-request/)

## Acknowledgement

Code derived and adapted from [oracle-terraform-modules/terraform-oci-vcn](https://github.com/oracle-terraform-modules/terraform-oci-vcn) and Hashicorp's [Terraform 0.12 examples](https://github.com/terraform-providers/terraform-provider-oci/tree/master/examples).

## License

Copyright (c) 2019, 2020 Trivadis AG and/or its associates. All rights reserved.

The Trivadis Terraform modules are licensed under the Apache License, Version 2.0. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.
