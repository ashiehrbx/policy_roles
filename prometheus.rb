cookbook 'rblx_prometheus', '0.1.2', git: 'https://github.com/Roblox/rblx_prometheus.git', tag: 'v0.1.2'


run_list.push(
  'rblx_prometheus::default'
)

override['rblx_prometheus']['absent'] = false
override['rblx_prometheus']['collection']['scrape_list'] = []
override['rblx_prometheus']['collection']['scrape_discovery'] = true

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

override['rblx_prometheus']['serverSuperfarmInfo'] = {
  dependencies: [ 'hostname' ],
  query: superfarm_query,
}
