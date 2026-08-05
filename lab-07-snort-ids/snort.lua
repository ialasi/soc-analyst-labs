-- Lab 07 Snort Configuration
-- Author: Ibitayo Alasi

-- Network variables
HOME_NET = '172.17.0.0/24'
EXTERNAL_NET = 'any'

-- Include rules
ips =
{
    enable_builtin_rules = false,
    rules = [[
        include /lab07/rules/local.rules
    ]]
}

-- Alert output
alert_fast =
{
    file = true,
    packet = false,
}
