cookbook 'rblx_prom_alertmanager', '0.1.0', git: 'https://github.com/Roblox/rblx_prom_alertmanager.git', tag: 'v0.1.0'


run_list.push(
  'rblx_prom_alertmanager::default'
)

override['rblx_prom_alertmanager']['absent'] = false
override['rblx_prom_alertmanager']['collection']['alert_list'] = ['localhost:9090']

# Used only for the bootstrap_mode, but unfortunately necessary for that.
superfarm_query = %(
{
  Server(HostName: "\#{hostname}") {
    SuperFarm {
      Name
      Servers {
        HostName
        DataCenter {
          ID
        }
        Environment {
          ID
        }
        ServerStatus {
          Name
          ID
        }
      }
    }
    Environment {
      ExclusiveComponentSuperFarms
      Abbreviation
      ID
    }
    DataCenter {
      Name
      ID
    }
  }
}
)

override['rblx_prom_alertmanager']['serverSuperfarmInfo'] = {
  dependencies: [ 'hostname' ],
  query: superfarm_query,
}

