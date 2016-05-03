#!/bin/sh

input_plugins=(battery contextswitch cpu df disk entropy interface irq load memory numa processes protocols swap tcpconns uptime users vmem adsfgdfg)
output_plugins=(csv)
collectd_config='/opt/verticloud/etc/collectd.conf'
data_dir='/var/lib/collectd/csv'

function configure_plugins {
  plugins=$1
  config_file=$2
  for plugin in ${plugins[@]}
  do
    echo "LoadPlugin $plugin" >> $config_file
  done
}

function configure_csv_output {
  config_file=$1
  cat >> $config_file <<EOF
  <Plugin "csv">
    DataDir "$data_dir"
      StoreRates true
  </Plugin>
EOF
}

t_Log "Running $0 - Start/Stop test collectd"

# stop collectd if already running
t_ServiceControl collectd stop

# Start a fresh collectd config file
echo > $collectd_config

# configure input plugins
configure_plugins $input_plugins $collectd_config
echo >> $collectd_config

# configure output plugins
configure_plugins $input_plugins $collectd_config

# Configure csv output plugin
configure_csv_output $collectd_config

t_ServiceControl collectd start 2>/var/tmp/collectd_errors
t_CheckExitStatus $?

# collectd start script won't exit non-zero in case of plugin load failures
[ -s /var/tmp/collectd_errors ] || t_CheckExitStatus 1

# Lets wait for collectd to collect some data
sleep 10

# Collectd should generate outputs
for plugin in ${input_plugins[@]};
do
  for f in /var/lib/collectd/csv/prometheus-6.5.14.test.altiscale.com/$plugin*/*;
    do
      file $f >/dev/null 2>&1
      exit_status=$?
      [ $? -eq 0 ] || { t_log "Failure while checking the collectd result of $plugin output"; t_CheckExitStatus $exit_status; }
  done;
done;
