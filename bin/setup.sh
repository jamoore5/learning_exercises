#!/bin/bash

project=$1

mkdir -p $project"/test"
mkdir -p $project"/lib"

cp bin/rakefile.rb $project"/rakefile.rb"
cp bin/test_helper.rb $project"/test/test_helper.rb"
