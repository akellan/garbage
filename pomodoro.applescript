property workInterval : 25
property shortRestInterval : 5
property longRestInterval : 20
property oneMinute : 60
property iterationCount : 4
property restSequence : {shortRestInterval, shortRestInterval, shortRestInterval, longRestInterval}

on waitWithProgress(interval)
	set progress total steps to interval
	set progress completed steps to 0
	repeat with step from 1 to interval
		delay oneMinute
		set progress completed steps to step
	end repeat
end waitWithProgress

on startWorking(interval, iteration)
	display dialog "Start working?"
	set progress description to "Working iteration " & iteration
	waitWithProgress(interval)
	display notification "Time to rest" with title "Pomodoro"
end startWorking

on startResting(interval, iteration)
	display dialog "Start resting?"
	set progress description to "Resting iteration" & iteration
	waitWithProgress(interval)
	display notification "Time to work" with title "Pomodoro"
end startResting

with timeout of iterationCount * workInterval * longRestInterval * oneMinute seconds
	repeat with iteration from 1 to iterationCount
		startWorking(workInterval, iteration)
		startResting(restSequence(iteration), iteration)
	end repeat
end timeout
