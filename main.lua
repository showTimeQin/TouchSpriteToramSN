require("TSLib")
require("Tools")
require("Team")
init(1);
os.execute("settings put secure default_input_method com.touchsprite.android/.core.TSInputMethod");
--子协程会在协程停止后，自动停止
local thread = require('thread')
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
      "list": "正常版本,BUG版本,交任务,自动上架",
      "select": "0"
    },
	{
      "type": "Label",
      "text": "销售金额",
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
      "text": "缓冲时间",
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
    },
	{
      "type": "Label",
      "text": "牛星数",
      "size": 15,
      "align": "center",
      "color": "0,0,0" 
    },
	{
      "type": "ComboBox",
      "list": "一星,二星,三星,四星",
      "select": "1"
    }
  ]
}
]]

function beforeUserExit()
	showCount(count_JRW)
end

ret, password, version, sellMoney, num, position, time, cattleStar = showUI(MyJsonString);
cattleStarTemp = cattleStar;	--	储存星数数据

admin = 0;

-- 用户点击退出
if ret ~= 0 and password == "1024" then
	-- 不删金属
	admin = 1;
elseif ret ~= 0 and password == "9527" then
	-- 全删
	admin = 2;
else
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
	cost = strSplit(sellMoney)
	clearBlackboard()
	mSleep(2000)
	sell("dm", cost[1])
	mSleep(2000)
	sell("fl", cost[2]);
	mSleep(1000);
	closeApp("com.xiaoyou.ToramOnline")
	lua_exit();     --退出脚本
	mSleep(5000)
	mSleep(10)      --lua 的机制是调用此函数之后的下一行结束，如果不希望出现此情况可以在调用函数之后加入一行无意义代码。
elseif version == "3" then
	nLog("自动售卖大马防裂")
	mSleep(1000)
	goToBlackboard();
	mSleep(1000);
	cost = strSplit(sellMoney)
	clearBlackboard()
	mSleep(2000)
	sell("dm", cost[1])
	mSleep(2000)
	sell("fl", cost[2]);
	mSleep(1000);
	closeApp("com.xiaoyou.ToramOnline")
	mSleep(5000)
	lua_exit();     --退出脚本
	mSleep(10)      --lua 的机制是调用此函数之后的下一行结束，如果不希望出现此情况可以在调用函数之后加入一行无意义代码。
else
	while (true) do
		-- version = "-1"; -- 为脚本自动重启软件做标记
		checkTimes = 0;
		-- 为了解决软件闪退问题
		local checkST_thread = thread.create(function()
			--创建刷牛协程
			local sn_thread = thread.createSubThread(function()
				while (true) do
					if team(num, tonumber(position), tonumber(time), tonumber(version), admin, tonumber(cattleStar)) == 2 then
						count_JRW = goToCityJRW(count_JRW)
					end
					cattleStar = -1;
				end
			end)
			-- 每30秒检测一次选单按钮，从没有找到时开始计时，持续10分钟则重启软件
			while (checkTimes <= 10) do
				mSleep(30000)
				--x1, y1 = findMultiColorInRegionFuzzy( 0x2b1b0f, "16|-1|0x2b1b0f,2|32|0x2b1b0f,20|35|0x150d07", 90, 208,  448, 267,  503);
				--x2, y2 = findMultiColorInRegionFuzzy( 0x1ebee6, "27|0|0x1ebee6,28|29|0x0726a2,-4|29|0x0726a2", 90, 689,  221, 746,  277);
				-- 闲置30分钟
				if (isColor(440,  594, 0x1b84ff, 95)) then
					toast("检查出掉线..."..checkTimes,1)
					checkTimes = checkTimes + 1;
				else
					checkTimes = 0;
				end
			end
		end)
		thread.waitAllThreadExit()--等待所有协程结束，只能用于主线程
		restart(tonumber(position))
		cattleStar = cattleStarTemp;
	end
end






