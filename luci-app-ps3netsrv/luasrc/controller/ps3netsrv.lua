module("luci.controller.ps3netsrv",package.seeall)

function index()
	entry({"admin", "nas"}, firstchild(), _("NAS") , 45).dependent = false
if not nixio.fs.access("/etc/config/ps3netsrv")then
  return
end

entry({"admin", "nas"}, firstchild(), "NAS", 44).dependent = false
	
local page

page = entry({"admin", "nas","ps3netsrv"},cbi("ps3netsrv"),_("PS3 NET Server"),40)
page.dependent=true
page.acl_depends = { "luci-app-ps3netsrv" }
entry({"admin", "nas","ps3netsrv","status"},call("act_status")).leaf=true
end

function act_status()
  local e={}
  e.running=luci.sys.call("ps | grep ps3netsrv |grep -v grep >/dev/null") == 0
  luci.http.prepare_content("application/json")
  luci.http.write_json(e)
end
