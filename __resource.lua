resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

description "license"

dependencies {
	'vrp',
	'vrp_mysql'
}

client_scripts{ 
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  '@mysql-async/lib/MySQL.lua',
  "sql.lua"
}
