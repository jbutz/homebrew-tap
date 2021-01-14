# -*- coding: utf-8 -*-

class AwsSamCli < Formula
  include Language::Python::Virtualenv

  desc "AWS SAM CLI 🐿 is a tool for local development and testing of Serverless applications"
  homepage "https://github.com/awslabs/aws-sam-cli/"
  url "https://api.github.com/repos/aws/aws-sam-cli/tarball/v1.12.0"
  sha256 "7be0497d24fc1539d6b8f8258a9756610a37f135ee42defd81049755e0bf00cd"
  head "https://github.com/awslabs/aws-sam-cli.git", :branch => "develop"

  conflicts_with 'aws-sam-cli-rc', :because => "both install the 'sam' binary"
  conflicts_with 'aws-sam-cli', :because => "both install the 'sam' binary"

  bottle do
    root_url "https://github.com/aws/aws-sam-cli/releases/download/v1.12.0/"
    cellar :any_skip_relocation
    sha256 "08c4c1e5713fa452d30c842230b7033099bd9694aa8b8023975d9854f6eaf96f" => :sierra
    sha256 "a8f74a580dfa67c51eaa9b5ac55850c631c377e08a66763da0fbc4d0a658d88a" => :x86_64_linux
  end

  depends_on "python@3.8"

  def install
    venv = virtualenv_create(libexec, "python3.8")
    system libexec/"bin/pip", "install", "pip==19.2.3"
    system libexec/"bin/pip", "install", "-v", "--ignore-installed", buildpath
    system libexec/"bin/pip", "uninstall", "-y", "aws-sam-cli"
    venv.pip_install_and_link buildpath
  end

  test do
    assert_match "Usage", shell_output("#{bin}/sam --help")
  end
end