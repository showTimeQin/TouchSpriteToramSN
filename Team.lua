local count_SN = 0
local count_delete = -1
local out_time = 5*60*2

function clearBlackboard()
	local count = 0
	while count~=2 do

		x,y = findMultiColorInRegionFuzzy( 0x1b84ff, "2|23|0x1b84ff", 90, 1028,  126, 1156,  696)
		if(x ~= -1) then
			tap(x, y)
			mSleep(3000)
			if (isColor( 348,  590, 0x1b84ff, 85)) then
				tap(741,  591)
			end
			mSleep(3000)
			
			
		else
			touchDown(391, 629)
			for i=629,178, -1 do
				touchMove(391, i)
				mSleep(5)
			end
			touchUp(391, 178)
			mSleep(3000)
			if (isColor(1271,  690, 0xffc63e, 85) and count == 0) then
				count = 1
			elseif(isColor(1271,  690, 0xffc63e, 85) and count == 1) then
				count = 2
			end
			
		end
	end
end

function sell(thing, cost)
	tap(55,   62) -- 返回
	mSleep(3000)
	tap(665,  268)
	mSleep(3000)
	local count = 0
	while (count~=2) do
		toast("0", 0.3)
		x,y = findMultiColorInRegionFuzzy(0x1b84ff, "6|29|0x1b84ff", 90, 446,  148, 656,  707)
		if x ~= -1 then
			toast("1", 0.3)
			tap(x, y)
			mSleep(2000)
			tap(593,  216)
			mSleep(2000)
			local i = 0
			while i<=3 do
				toast("1.1", 0.3)
				if(thing == "dm") then
					x1, y1 = findMultiColorInRegionFuzzy(0x8f918f, "-36|26|0x3b3d3f,-13|44| 0x6e7171,11|26|0x8f938d", 90, 729, 92, 1239,  705); 
				elseif thing == "fl" then
					x1, y1 = findMultiColorInRegionFuzzy(0xd688db, "13|1|0x820283,8|-11|0x756658,5|-37|0x52514e", 90, 729, 92, 1239,  705); 
				end
				if x1 ~= -1 then
					toast("2", 0.3)
					tap(x1, y1)	--	点击物品
					mSleep(2000)
					tap(225,  264)	-- 选择
					mSleep(2000)
					tap(920,  336)	-- 最大
					mSleep(2000)
					tap(647,  523) -- 选择
					mSleep(2000)
					tap(705,  558) -- 设定卖价
					mSleep(2000)
					tap(554,  311) -- 点击总价
					mSleep(2000)
	--				tap(83,   68)	-- 点击价格区域
	--				mSleep(2000)
					inputText(cost)	--输入价格
					mSleep(2000)
					tap(931,   70)	-- OK
					mSleep(2000)
					tap(646,  616) -- 确认
					mSleep(2000)
					tap(983,  219)	-- 上架
					mSleep(2000)
					tap(751,  599) -- 确认
					mSleep(2000)
					break
				else
					toast("2.1", 0.3)
					i = i + 1
					tap(654,  589)
					mSleep(2000)
				end
			end
			if i == 4 then
				tap(55,   62) -- 返回
				mSleep(2000)
				tap(55,   62) -- 返回
				mSleep(2000)
				return
			end
		else
			toast("3", 0.3)
			touchDown(391, 629)
			for i=629,178, -1 do
				touchMove(391, i)
				mSleep(5)
			end
			touchUp(391, 178)
			mSleep(3000)
			if (isColor(1271,  690, 0xffc63e, 85) and count == 0) then
				count = 1
			elseif(isColor(1271,  690, 0xffc63e, 85) and count == 1) then
				count = 2
			end
		end
	end
end

function JRW(count_JRW)
	nLog("交任务")
	while true do
		if not isColor(628,  629, 0x1b84ff, 95) then
			tap(698,  621)
			count_JRW = count_JRW + 1
			nLog("得到防裂："..count_JRW)
			mSleep(6000  )
		else 
			mSleep(1000)
			--二次判断
			if isColor(628,  629, 0x1b84ff, 95) then
				tap(628,  629)
				count_JRW = count_JRW + 1
				nLog("得到防裂："..count_JRW)
				mSleep(1000)
				break
			end
		end
	end
	return count_JRW
end

function goToBlackboard()
	moveToDN(2)
	mSleep(5000)
	tap(1092,  670) -- 下一步
	mSleep(2000)
	tap(637,  331)	-- 使用
	mSleep(2000)
	tap(567,  266) -- 上架
	mSleep(2000)
end

function deleteJS()
	for i=1, 3 do
		local point = {}
		point = findMultiColorInRegionFuzzyExt(0x8f918f, "-36|26|0x3b3d3f,-13|44| 0x6e7171,11|26|0x8f938d", 90, 729, 92, 1239,  705); 
		if #point ~= 0 then  --如返回的table不为空（至少找到一个符合条件的点）
			for var = 1,#point do
				nLog(point[var].x..":"..point[var].y)
				tap(point[var].x, point[var].y)
				count_delete = count_delete + 1
				mSleep(500)
				if isColor(95,  440, 0xffffff, 95) then
					nLog("牛王")
				elseif isColor(95,  440, 0x3f3225, 95) then
					nLog("大马")
					tap(point[var].x, point[var].y)
					count_delete = count_delete - 1
					mSleep(500)
				end
			end
		end
		touch(659,  549, 0x1b84ff, 95)
		mSleep(1000)
		nLog("抓取成功")
	end
end

function deleteWQ()
	for i=1, 3 do
		local pointQT = {}
		local pointQT1 = {}
		local pointJ = {}
		local pointJ1 = {}
		local pointFZ = {}
		local pointFZ1 = {}
		pointQT = findMultiColorInRegionFuzzyExt(0x4c3526, "2|27|0xaf837e,27|23| 0xdab26c,44|-3|0x534a34", 100, 729,   92, 1239,  705);
		pointQT1 = findMultiColorInRegionFuzzyExt(0x50463b, "8|30|0x583714,40|30| 0x554032,19|10|0xb18481", 100, 729,   92, 1239,  705);
		pointJ = findMultiColorInRegionFuzzyExt(0x767677, "39|0|0x514732,17|31| 0x8e6ca9,-18|29|0x3d3626", 100, 729,   92, 1239,  705); 
		pointJ1 = findMultiColorInRegionFuzzyExt(0x717172, "17|24|0xe0d1e1,64|11| 0x342616,28|44|0x747473", 100, 729,   92, 1239,  705); 
		pointFZ = findMultiColorInRegionFuzzyExt(0xaf96b6, "-13|22|0x786159,0|42|0x967b9c,29|34|0xa68ab2", 97, 729,   92, 1239,  705);
		--pointFZ1 = findMultiColorInRegionFuzzyExt(0xac93b3, "58|8|0x1a1408,24|35|0x63483f,68|26|0x3e2f1a", 97, 729,   92, 1239,  705);
		if #pointQT ~= 0 then  --如返回的table不为空（至少找到一个符合条件的点）
			for var = 1,#pointQT do
				nLog("拳套位置："..pointQT[var].x..":"..pointQT[var].y)
				tap(pointQT[var].x, pointQT[var].y)
				count_delete = count_delete + 1
				mSleep(500)
			end
		end
		if #pointQT1 ~= 0 then  --如返回的table不为空（至少找到一个符合条件的点）
			for var = 1,#pointQT1 do
				nLog("拳套单孔位置："..pointQT1[var].x..":"..pointQT1[var].y)
				tap(pointQT1[var].x, pointQT1[var].y)
				count_delete = count_delete + 1
				mSleep(500)
			end
		end
		if #pointJ ~= 0 then  --如返回的table不为空（至少找到一个符合条件的点）
			for var = 1,#pointJ do
				nLog("拔刀位置："..pointJ[var].x..":"..pointJ[var].y)
				tap(pointJ[var].x, pointJ[var].y)
				count_delete = count_delete + 1
				mSleep(500)
			end
		end
		if #pointJ1 ~= 0 then  --如返回的table不为空（至少找到一个符合条件的点）
			for var = 1,#pointJ1 do
				nLog("拔刀单孔位置："..pointJ1[var].x..":"..pointJ1[var].y)
				tap(pointJ1[var].x, pointJ1[var].y)
				count_delete = count_delete + 1
				mSleep(500)
			end
		end
		if #pointFZ ~= 0 then  --如返回的table不为空（至少找到一个符合条件的点）
			for var = 1,#pointFZ do
				nLog("法杖位置："..pointFZ[var].x..":"..pointFZ[var].y)
				tap(pointFZ[var].x, pointFZ[var].y)
				count_delete = count_delete + 1
				mSleep(500)
			end
		end
--		if #pointFZ1 ~= 0 then  --如返回的table不为空（至少找到一个符合条件的点）
--			for var = 1,#pointFZ1 do
--				nLog("法杖单孔位置："..pointFZ1[var].x..":"..pointFZ1[var].y)
--				tap(pointFZ1[var].x, pointFZ1[var].y)
--				count_delete = count_delete + 1
--				mSleep(500)
--			end
--		end
		touch(659,  549, 0x1b84ff, 95)
		mSleep(1000)
		nLog("抓取成功")
	end
end

function arrived()
	findColorStop(822,  600, 0x1a84fe, 90)
	local x, y, x1, y1, x2, y2, x3, y3, x4, y4 = -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
	x,y = findMultiColorInRegionFuzzy( 0x1cb6e3, "35|-1|0x1dbce5,5|26|0x0934a9,35|31|0x0724a1,18|14|0xcfcfcf", 90, 704,  262, 766,  325)
	if x==-1 then return "队员" end-- 不是队长
	local timer = 0
	while timer < out_time do
		x2,y2 = findMultiColorInRegionFuzzy( 0x2a1b0f, "17|2|0x2b1b0f,0|31|0x2b1b0f,16|33|0x2b1b0f", 90, 158,  241, 227,  293)
		x3,y3 = findMultiColorInRegionFuzzy( 0x2b1b0f, "16|0|0x2b1b0f,-1|32|0x28190e,15|30|0x2b1b0f", 90, 159,  337, 227,  392)
		x4,y4 = findMultiColorInRegionFuzzy( 0x2a1b0f, "14|-1|0x26180d,-4|32|0x2b1b0f,20|31|0x291a0e", 90, 160,  441, 224,  493)
		if (num == "0" and x2==-1) then toast("2号没到", 0.3) end
		if (num == "1" and x2==-1) then 
			toast("2号没到", 0.3)
		elseif (num == "1" and x3==-1) then
			toast("3号没到", 0.3)
		end
		if (num == "2" and x2==-1) then 
			toast("2号没到", 0.3)
		elseif (num == "2" and x3==-1) then
			toast("3号没到", 0.3)
		elseif (num == "2" and x4==-1) then
			toast("4号没到", 0.3)
		end
		if (num == "0" and x2~=-1) or 
			(num == "1" and x2~=-1 and x3~=-1) or 
			(num == "2" and x2~=-1 and x3~=-1 and x4~=-1) then
			nLog("到齐")
			return "到齐"
		end 
		mSleep(500)
		timer = timer + 1
	end
	return "超时"
end

function goToCityJRW(count_JRW)
	local x = -1
	local y = -1
	goToCity(0)
	moveToDN(3) -- 找到NPC
	mSleep(1000)
	touchN(2) -- 交任务
	mSleep(1000)
	-- 下划
	for i=1, 2 do
		touchDown(661,  459);    --在坐标 按下
		mSleep(1000);
		for j=459, 113, -10 do
			touchMove(674,  j);    --移动到坐标 ，注意一次滑动的坐标间隔不要太大，不宜超过 50 像素
			mSleep(30)
		end
		mSleep(1000);
		touchUp(674,  113);    --在坐标 抬起
		mSleep(2000)
	end
	
	mSleep(2000)
	tap(634,  308)	-- 点击任务
	mSleep(1000)
	touch(1217,   64, 0x8a8253, 95) -- 跳过
	mSleep(1000)
	touch(827,  298, 0x978062, 95) -- 遵命
	mSleep(1000)
	touch(1217,   64, 0x8a8253, 95) -- 跳过
	mSleep(1000)
	touch(827,  298, 0x978062, 95) -- 直接回报
	nextNStalk(2)
	while true do
		if isColor(641,  626, 0x000000, 95) and isColor(698,  621, 0x1b84ff, 95) then
			tap(698,  621)
			count_JRW = count_JRW + 1
			nLog("得到防裂："..count_JRW)
			mSleep(1000)
		elseif isColor(628,  629, 0x1b84ff, 95) then
			tap(628,  629)
			count_JRW = count_JRW + 1
			nLog("得到防裂："..count_JRW)
			mSleep(1000)
			break
		end
	end
	mSleep(3000)
	return count_JRW
end

-- base 为1表示不组队
-- num表示组队人数，0为2人，1为3人，2为4人
-- position表示传送点位置，0为第一个，1为第二个，2为第三个
-- time 为休息时间
-- version 为0时为正常版本， 为1时为bug版
-- 计数君，计算刷牛次数
function team(base, num, position, time, version)
	-- 确认是否在刷牛的地图
	local map = false -- 确认是否在本地图的标示
	local bag = false -- 识别背包是否满了的标志
	local js = false -- 判断金属坐标
	if version == 1 then
		touch(53,   54, 0x837b70, 95) -- 选单
	end
	touch(53,   54, 0x837b70, 95) -- 选单
	nLog("选单完成")
	mSleep(1000)
	touch(188,  561, 0x936b38, 95) -- 地图
	mSleep(1000)
	nLog("地图完成")
	findColorStop(272,  664, 0x1b84ff, 95)
	local cattle_map = {
		{  704,  643, 0xffffff},
		{  706,  651, 0x978062},
		{  706,  657, 0xffffff},
		{  704,  664, 0x978062},
	}
	local position_table = {
		{ 116,  161, 0x978062},
		{ 111,  237, 0x978062},
		{ 112,  322, 0x978062},
	}
	nLog("开始识别地图")
	if multiColor(cattle_map,95) then
		toast("人物在目标地图")
		map = true
	else
		toast("人物不在目标地图")
	end
	touchDown(1226, 64)
	mSleep(50)
	touchUp(1226, 64)
	nLog("关闭菜单完成")
	mSleep(1000)
	-- 如果不在刷牛地图，则传送
	if map == false then
		nLog("开始传送")
		touch(53,   54, 0x837b70, 95) -- 选单
		mSleep(1000)
		touch(188,  561, 0x936b38, 95) -- 地图
		mSleep(1000)
		findColorStop(272,  664, 0x1b84ff, 95)
		tap(position_table[position+1][1], 
			position_table[position+1][2])
		mSleep(1000)
		touch( 284,  175, 0x1676ca, 95)
		mSleep(1000)
		map = true
	end
	
	while not bag do
		-- 传送完毕或在此地图
		findColorStop(1039,  367, 0xb23e32, 95)
		moveToN(2)
		
		-- 识别人是否到齐
		if base == "1" then
			local arrive = arrived()
			if arrive == "队员" then
				nLog("队员准备好了，开始战斗")
				touch(822,  600, 0x1b84ff, 95)
				local timer = 0
				local x1, y1, x2, y2, x3, y3, x4, y4 = -1, -1, -1, -1, -1, -1, -1, -1
				while (timer < out_time) do
					x1,y1 = findMultiColorInRegionFuzzy( 0x2b1b0f, "16|0|0x2b1b0f,0|30|0x2b1b0f,16|30|0x2b1b0f", 90, 162,  135, 225,  196)
					x2,y2 = findMultiColorInRegionFuzzy( 0x2a1b0f, "17|2|0x2b1b0f,0|31|0x2b1b0f,16|33|0x2b1b0f", 90, 158,  241, 227,  293)
					x3,y3 = findMultiColorInRegionFuzzy( 0x2b1b0f, "16|0|0x2b1b0f,-1|32|0x28190e,15|30|0x2b1b0f", 90, 159,  337, 227,  392)
					x4,y4 = findMultiColorInRegionFuzzy( 0x2a1b0f, "14|-1|0x26180d,-4|32|0x2b1b0f,20|31|0x291a0e", 90, 160,  441, 224,  493)
					if (num == "0" and x~=-1 and x2~=-1) or 
						(num == "1" and x~=-1 and x2~=-1 and x3~=-1) or 
						(num == "2" and x~=-1 and x2~=-1 and x3~=-1 and x4~=-1) then
						nLog("到齐")
						break
					end
					mSleep(500)
					timer = timer + 1
				end
				if timer == out_time then
					mSleep(1000)
					tap(52,   68) --点击返回
					mSleep(1000)
					tap(52,   68) --点击返回
					mSleep(1000)
					return 2
				end
			end
			if arrive == "超时" then
				mSleep(1000)
				tap(52,   68) --点击返回
				mSleep(1000)
				return 2
			end
			if arrive == "到齐" then
				nLog("准备好了，开始战斗")
				mSleep(3000)
				touch(822,  600, 0x1b84ff, 95)
			end
		end
		
		if base == "0" then
			nLog("准备好了，开始战斗")
			touch(822,  600, 0x1b84ff, 95)
		end
		falg = false
		mSleep(2000)
		findNotColorStart(822,  600, 0x1b84ff, 95) -- 检查准备好了战斗按钮
		-- 检查发言按钮
		local i = 0;
		while not isColor(1216,   57, 0xd0e1ec, 95) do
			mSleep(1000)
			i = i + 1
			if i>30 then
				local x1, y1, x2, y2 = -1, -1, -1, -1
				x1,y1 = findMultiColorInRegionFuzzy( 0x2b1b0f, "16|-1|0x2b1b0f,2|32|0x2b1b0f,20|35|0x150d07", 90, 208,  448, 267,  503)
				x2,y2 = findMultiColorInRegionFuzzy( 0x1ebee6, "27|0|0x1ebee6,28|29|0x0726a2,-4|29|0x0726a2", 90, 689,  221, 746,  277)
				if x1~=-1 or x2~=-1 then
					count_SN = count_SN + 1
					toast("战斗结束， 已刷牛次数："..count_SN,0.5)
					nLog("战斗结束， 已刷牛次数："..count_SN)
					falg = true
					break
				end
			end	
		end
		-- 检查返回按钮旁边的颜色
		if not falg then
			i = 0;
			while not isColor(139,   45, 0xbc934d, 95) do
				mSleep(1000)
				i = i + 1
				if i>30 then
					local x1, y1, x2, y2 = -1, -1, -1, -1
					x1,y1 = findMultiColorInRegionFuzzy( 0x2b1b0f, "16|-1|0x2b1b0f,2|32|0x2b1b0f,20|35|0x150d07", 90, 208,  448, 267,  503)
					x2,y2 = findMultiColorInRegionFuzzy( 0x1ebee6, "27|0|0x1ebee6,28|29|0x0726a2,-4|29|0x0726a2", 90, 689,  221, 746,  277)
					if x1~=-1 or x2~=-1 then
						count_SN = count_SN + 1
						toast("战斗结束， 已刷牛次数："..count_SN,0.5)
						nLog("战斗结束， 已刷牛次数："..count_SN)
						falg = true
						break
					end
				end	
			end
		end
		nLog("加载地图完成")
		
		if not falg then
			local x1, y1, x2, y2 = -1, -1, -1, -1
			while true do
				-- 点击技能
				tap(1174,  283)
				tap(1055,  373)
				-- 破盾
				tap(715,  182)
				tap(525,  183)
				tap(620,  183)
				tap(791,  335)
				tap(646,  335)
				tap(508,  341)
				if base == "0" and not isColor(1225, 58, 0xd0e1ec, 95) then
					count_SN = count_SN + 1
					toast("战斗结束， 已刷牛次数："..count_SN,0.5)
					nLog("战斗结束, 已刷牛次数："..count_SN)
					break
				end
				x1,y1 = findMultiColorInRegionFuzzy( 0x2b1b0f, "16|-1|0x2b1b0f,2|32|0x2b1b0f,20|35|0x150d07", 90, 208,  448, 267,  503)
				x2,y2 = findMultiColorInRegionFuzzy( 0x1ebee6, "27|0|0x1ebee6,28|29|0x0726a2,-4|29|0x0726a2", 90, 689,  221, 746,  277)
				if x1~=-1 or x2~=-1 then
					count_SN = count_SN + 1
					toast("战斗结束， 已刷牛次数："..count_SN,0.5)
					nLog("战斗结束， 已刷牛次数："..count_SN)
					break
				end
				-- 破盾
				tap(715,  182)
				tap(525,  183)
				tap(620,  183)
				tap(791,  335)
				tap(646,  335)
				tap(508,  341)
				if base == "0" and not isColor(1225, 58, 0xd0e1ec, 95) then
					count_SN = count_SN + 1
					toast("战斗结束， 已刷牛次数："..count_SN,0.5)
					nLog("战斗结束， 已刷牛次数："..count_SN)
					break
				end
				x1,y1 = findMultiColorInRegionFuzzy( 0x2b1b0f, "16|-1|0x2b1b0f,2|32|0x2b1b0f,20|35|0x150d07", 90, 208,  448, 267,  503)
				x2,y2 = findMultiColorInRegionFuzzy( 0x1ebee6, "27|0|0x1ebee6,28|29|0x0726a2,-4|29|0x0726a2", 90, 689,  221, 746,  277)
				if x1~=-1 or x2~=-1 then
					count_SN = count_SN + 1
					toast("战斗结束， 已刷牛次数："..count_SN,0.5)
					nLog("战斗结束， 已刷牛次数："..count_SN)
					break
				end
			end
		end
		
		x1, y1, x2, y2 = -1, -1, -1, -1
		if base == "1" then
			local timer = 0
			while x1==-1 and x2==-1 do
				x1,y1 = findMultiColorInRegionFuzzy( 0x2b1b0f, "16|-1|0x2b1b0f,2|32|0x2b1b0f,20|35|0x150d07", 90, 208,  448, 267,  503)
				x2,y2 = findMultiColorInRegionFuzzy( 0x1ebee6, "27|0|0x1ebee6,28|29|0x0726a2,-4|29|0x0726a2", 90, 689,  221, 746,  277)
				mSleep(500)
				timer = timer + 1
				toast("timer:"..timer,0.3)
				if timer == 36 then
					closeApp("com.xiaoyou.ToramOnline")
					mSleep(3000)
					runApp("com.xiaoyou.ToramOnline")
					mSleep(3000)
					touch(764,  569, 0x1b84ff, 95)
					mSleep(3000)
					tap(770,  317)
					mSleep(3000)
					touch(727,  668, 0x1a84fe, 95)
					mSleep(3000)
					return 1
				end
			end
			while true do
				mSleep(3000)
				tap(63, 64)
				mSleep(50)
				tap(63, 64) -- 双击
				mSleep(1000)
				toast("点击返回", 0.5)
				mSleep(3000)
				
				x1,y1 = findMultiColorInRegionFuzzy( 0x2b1b0f, "16|-1|0x2b1b0f,2|32|0x2b1b0f,20|35|0x150d07", 90, 208,  448, 267,  503)
				x2,y2 = findMultiColorInRegionFuzzy( 0x1ebee6, "27|0|0x1ebee6,28|29|0x0726a2,-4|29|0x0726a2", 90, 689,  221, 746,  277)
				if x1==-1 or x2==-1 then
					break
				end
			end
		end
		findMutiColorStop(0x1eb3dd, "35|0|0x1eb3dd,17|17|0x5d3c11,-13|32|0x3585da", 90, 0, 0, 103,  112)
		toast("看见选单，重新回到地图",0.5)
		nLog("看见选单，重新回到地图")
		tap(1175,  176)
		mSleep(time)
		tap(1049,  253)
		mSleep(1000)
		touch(53,   54, 0x837b70, 95) -- 选单
		mSleep(1000)
		touch(1089,  164, 0x9a0104, 95) -- 通知
		mSleep(2000)
		local x = -1
		local y = -1
		x, y = findMultiColorInRegionFuzzy(0x8c6029, "16|10|0x351d03,15|20| 0x613406,-3|20|0x875924", 95, 678,  138, 1230,  572);
		if x~=-1 and y~=-1 then
			tap(x,  y)
			findColorStop(296,  222, 0x35a9b7, 95)
			touch(645,  119, 0x269e5e, 95) -- 多选
			mSleep(500)
			deleteJS()
			deleteWQ()
			touch(309,  193, 0xcdcbcd, 95)
			touch(791,  601, 0x1b84ff, 95) -- 删除确认
			mSleep(1000)
			toast("背包剩余空位："..count_delete+1)
			findColorStop(296,  222, 0x35a9b7, 95)
	
		end
		touch(1223,   65, 0xeebb6f, 95) -- 关闭
		
		if count_delete~=-1 and count_delete <= 3 then
			count_delete = -1
			nLog("回城交任务")
			return 2
		end
		
		count_delete = -1
	end
	
end

function showCount(count_JRW)
	toast("刷牛次数：".. count_SN.."\n\n得到防裂瓶数:"..count_JRW)
end



