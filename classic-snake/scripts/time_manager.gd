extends Node
class_name TimeManager

func get_time_stamp(time_in_ms : int) -> String:
	var times : Array[int] = get_hours_minutes_seconds_miliseconds(time_in_ms)
	var hours : int 		= times[0]
	var minutes : int 		= times[1]
	var seconds : int 		= times[2]
	var miliseconds : int 	= times[3]
	
	var result : String = ""
	
	if miliseconds != 0:
		result += ":%d"%miliseconds
	else:
		result += ":000"
		
	if seconds == 0:
		result = ":00" + result
	elif seconds  < 10:
		result = ":0%d"%seconds + result
	else:
		result = ":%d"%seconds + result
		
	if minutes == 0:
		result = "00" + result
	elif minutes  < 10:
		result = "0%d"%minutes + result
	else:
		result = "%d"%minutes + result
		
	if hours == 0:
		result = "00:" + result
	elif hours  < 10:
		result = "0%d:"%hours + result
	else:
		result = "%d:"%hours + result
	
	
	return result.replace("00:","")

func get_hours_minutes_seconds_miliseconds(time_in_ms : int) -> Array[int]:
	var result : Array[int] = []
	
	result.insert(0,time_in_ms%1000)
	time_in_ms /= 1000
	result.insert(0,time_in_ms%60)
	time_in_ms /= 60
	result.insert(0,time_in_ms%60)
	time_in_ms /= 60
	result.insert(0,time_in_ms%24)
	
	return result
