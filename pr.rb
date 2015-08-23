#!/usr/bin/ruby
require 'optparse'

REPOSITORYNAME = "REPOSITORYNAME"

@default_base_branch = "master"
@opts = {}

OptionParser.new{|opt|
  opt.on('-i VAL') {|v| @opts[:i] = v}
  opt.on('-b VAL') {|v| @opts[:b] = v}
  opt.on('-h VAL') {|v| @opts[:h] = v }
  opt.on('-m VAL') {|v| @opts[:m] = v }
  opt.parse!(ARGV)
}

def issue_number
  @opts[:i] || branch_name
end

def base_branch
  @opts[:b] || @default_base_branch
end

def head_branch
  @opts[:h] || branch_name
end

def pull_request_title
  @opts[:m] || "fixed #{issue_number}"
end

def branch_name
  `git branch | grep '^\*' | cut -b 3-`.chomp
end

def commit_message(branch_name)
  branch_name.capitalize.gsub('_', ' ')
end


def update_pull_request_message
  `sed -e "s/issue-no/#{issue_number}/g" .pr_message.txt > .pr_message_temp.txt`
  `sed -i -e "s/pull-request-message/#{pull_request_title}/g" .pr_message_temp.txt`
end

def delete_tmp_file
  `rm .pr_message_temp.txt`
end

def execute_pull_request
  `hub pull-request --browse -f -F .pr_message_temp.txt -b #{REPOSITORYNAME}:#{base_branch} -h #{repos}:#{head_branch}`
end

def pr
  update_pull_request_message
  execute_pull_request
  delete_tmp_file
end

pr
