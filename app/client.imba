global css html
	ff:sans
	details[open] p: 1.5em
		summary mb: 1.5em 
tag app

	css .open
		background: hotpink

	toggles = []

	def setup
		_toggles = window.localStorage.getItem("toggles")
		if _toggles
			toggles = JSON.parse(_toggles)

	def createNewToggle event
		console.log event
		toggles.push({title: "Your title", content: "Your content"})
		window.localStorage.setItem("toggles", JSON.stringify(toggles))
	
	def downloadAPKG event
		console.log event

	<self>
		<header>
			<div[d: flex jc: space-between ai: center]>
				<h1 [m: 0]> "Toggles to Anki"
				<div>
					<button @click=createNewToggle> "+"
			<hr>
		<main>
				<.toggles>
					for toggle in toggles
						<details[bd: 1px solid #aaa rd: 4px p: .5em .5em 0 m: 1rem] contentEditable=true> 
							<summary[fw: bold m: -.5em -.5em 0 p: .5em]> toggle.title
							toggle.content
				if toggles.length > 0
					<div [d: flex jc: center p: 2rem]>
						<button @click=downloadAPKG> "Download"

imba.mount <app>
