# formatted-pull-request
easy way to pull-request with customized format

# Usage

1. install hub command.
2. set your repository name & default base branch in .pr_message.txt
3. customize pr format. edit pr_message.txt
3. execute pull-request:  `ruby pr.rb`

# options


### -i issue_number


```
ruby pr.rb -i 1234
```

### -b base_branch_name

if you change base branch from default, do following:

```
ruby pr.rb -b branch_name
```

Default is the branch you set in .pr_message.txt

### -h head_branch_name

if you change base branch from default, do following:

```
ruby pr.rb -h feature_branch_name
```

Default is current branch name.

### -m 'rull-reuqest message'

```
ruby pr.rb -m 'write pull-request title'
```
