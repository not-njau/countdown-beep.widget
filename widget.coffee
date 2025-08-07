MILLIS_IN_DAY: 24 * 60 * 60 * 1000
MILLIS_IN_HOUR: 60 * 60 * 1000
MILLIS_IN_MINUTE: 60 * 1000
MILLIS_IN_SECOND: 1000

countdowns: [
	{ label: "Mum's Birthday", time: "Jun 12, 2026", icon: "🎂" }
	{ label: "Project Due Date", time: "Oct 1, 2025", icon: "⏳" }
	{ label: "New Year's Day", time: "Jan 1, 2026", icon: "🎇" }
	
]

command: ""

refreshFrequency: 1000

style: """
	*
		margin 0
		padding 0

	#container
		background rgba(#000, .4)
		position fixed
		bottom 10px
		left 20px
		width 300px
		padding 12px 18px
		border-radius 20px

		color rgba(#fff, .9)
		font-family Helvetica Neue 
	
	span
		font-size 14pt
		font-weight bold

	ul
		list-style none
		margin 0
		padding 0

	li
		padding 6px 0

	table
		width 100%
		table-layout fixed

	thead
		font-size 8pt
		font-weight bold

		td
			width 60px

	tbody
		font-size 13pt

	td
		text-align center
"""

render: -> """
	<div id="container">
		<audio id="tick-sound" src="beep.wav" preload="auto"></audio>
		<ul></ul>
	</div>
"""
afterRender: ->
	for countdown in @countdowns
		countdown.millis = new Date(countdown.time).getTime()

update: (output, domEl) ->
	# Play the beep sound at low volume
	tick = document.getElementById('tick-sound')
	if tick?
		tick.volume = 0.1     # Control volume (0.0 to 1.0)
		tick.play()
	$countdownList = $(domEl).find("#container").find("ul")
	$countdownList.empty()

	now = new Date().getTime()

	# $root.html new Date
	# $root.html new Date @countdowns[1].time
	for countdown in @countdowns
		millisUntil = countdown.millis - now
		timeUntil = {}

		timeUntil.days = millisUntil // @MILLIS_IN_DAY
		millisUntil %= @MILLIS_IN_DAY

		timeUntil.hours = millisUntil // @MILLIS_IN_HOUR
		millisUntil %= @MILLIS_IN_HOUR

		timeUntil.minutes = millisUntil // @MILLIS_IN_MINUTE
		millisUntil %= @MILLIS_IN_MINUTE

		timeUntil.seconds = millisUntil // @MILLIS_IN_SECOND
		millisUntil %= @MILLIS_IN_SECOND

		$countdownList.append("""
			<li>
				<span>#{countdown.icon} #{countdown.label}</span>
				<table>
					<thead>
						<tr>
							<td>DAYS</td>
							<td>HOURS</td>
							<td>MINUTES</td>
							<td>SECONDS</td>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td>#{timeUntil.days}</td>
							<td>#{timeUntil.hours}</td>
							<td>#{timeUntil.minutes}</td>
							<td>#{timeUntil.seconds}</td>
						</tr>
					</tbody>
				</table>
			</li>
		""")