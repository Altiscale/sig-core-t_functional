
# JUST A TEMPORARY SCRIPT. I WILL CREATE A VAGRANT PLUGIN FOR THIS

function quit () { 
  echo "error: ${PGM}: $1" 1>&2
  exit 1
}

[ -z "$1" ] && quit 'Prometheus image id missing'
[ -z "$AWS_ACCESS_KEY" ]  && quit 'AWS_ACCESS_KEY missing'
[ -z "$AWS_SECRET_KEY" ]  && quit 'AWS_SECRET_KEY missing'

script_dir=$(dirname $0)
local_path=".prometheus_path/prometheus_vagrantfile"
prometheus=$1
mkdir -p $(dirname $local_path) || quit "Can not create dir ${script_dir}/.vagrantfile"

echo "Downloading Vagrantfile $prometheus"
aws s3 cp s3://vcc-hostdb/Vagrantfile."$prometheus" $local_path || quit "Can not download Vagrantfile.$prometheus"

exit_status=0
vagrant up default
vagrant ssh default -c "sudo /t_functional/runtests.sh" || exit_status=1
vagrant destroy default --force
exit $exit_status
