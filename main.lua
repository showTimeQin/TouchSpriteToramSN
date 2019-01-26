require("TSLib")
require("Tools")
require("Team")
init(1);
os.execute("settings put secure default_input_method com.touchsprite.android/.core.TSInputMethod")  
width, height = getScreenSize();
local count_JRW = 0 -- 交任务次数
setScreenScale(true, 720, 1280)
if width ~= 720 or height ~= 1280 then
	toast("width = "..width.."\nheight = "..height)
	toast("本脚本不能在该设备运行")
end

MyJsonString = [[
{
  "style": "default",
  "width": ]]..width..[[,
  "height": ]]..height..[[,
  "config": "save_111.dat",
  "timer": 60,
  "views": [
    {
      "type": "Label",
      "text": "Kami桑的刷牛脚本",
      "size": 25,
      "align": "center",
      "color": "0,0,255"
    },
	{
      "type": "Label",
      "text": "密码",
      "size": 15,
      "align": "center",
      "color": "0,0,0"
    },
	{
      "type": "Edit",
      "text": "1",
      "size": 15,
      "align": "left",
      "color": "0,0,0"
    },
	{
      "type": "ComboBox",
      "list": "正常版本,测试版本,交任务,自动上架",
      "select": "0"
    },
	{
      "type": "Label",
      "text": "基础配置",
      "size": 15,
      "align": "center",
      "color": "0,0,0"
    },
    {
      "type": "ComboBox",
      "list": "个人,组队",
      "select": "1"
    },
	{
      "type": "Label",
      "text": "组队人数",
      "size": 15,
      "align": "center",
      "color": "0,0,0"
    },
	{
      "type": "ComboBox",
      "list": "2,3,4",
      "select": "0"
    },
	{
      "type": "Label",
      "text": "传送点位置",
      "size": 15,
      "align": "center",
      "color": "0,0,0" 
    },
	{
      "type": "ComboBox",
      "list": "第一个,第二个,第三个",
      "select": "1"
    },
	{
      "type": "Label",
      "text": "缓冲时间（售卖价格）",
      "size": 15,
      "align": "center",
      "color": "0,0,0"
    },
	{
      "type": "Edit",
      "text": "3000",
      "size": 15,
      "align": "left",
      "color": "0,0,0"
    }
  ]
}
]]

function beforeUserExit()
	showCount(count_JRW)
end

ret, password, version, base, num, position, time = showUI(MyJsonString);
-- 用户点击退出
if ret == 0 or password ~= "1024" then
	lua_exit();     --退出脚本
	mSleep(10)      --lua 的机制是调用此函数之后的下一行结束，如果不希望出现此情况可以在调用函数之后加入一行无意义代码。
end
mSleep(2000)
if version == "2" then
	count_JRW = JRW(count_JRW)
	mSleep(2000)
	goToBlackboard()
	nLog("自动售卖大马防裂")
	mSleep(1000)
	cost = strSplit(time)
	clearBlackboard()
	mSleep(2000)
	sell("dm", cost[1])
	mSleep(2000)
	sell("fl", cost[2])
elseif version == "3" then
	nLog("自动售卖大马防裂")
	mSleep(1000)
	cost = strSplit(time)
	clearBlackboard()
	mSleep(2000)
	sell("dm", cost[1])
	mSleep(2000)
	sell("fl", cost[2])
else
	while (true) do
		if team(base, num, tonumber(position), tonumber(time), tonumber(version)) == 2 then
			count_JRW = goToCityJRW(count_JRW)
		end
	end
end






