import { saveAs } from 'file-saver'
import AnkiExport from 'anki-apkg-export'

global css html
	ff:sans
	details[open] p: 1.5em
		summary mb: 1.5em 
tag app

	css .open
		background: hotpink

	deckName = "your cool deck"
	toggles = []

	def loadValue key, defaultValue
		_v = window.localStorage.getItem(key)
		if _v
			return JSON.parse(_v)
		defaultValue

	def setup
		toggles = self.loadValue("toggles", [])
		deckName = window.localStorage.getItem("deckName") || "your cool deck"
	
	def createNewToggle event
		console.log event
		toggles.push({title: "Your title", content: "Your content"})
		window.localStorage.setItem("toggles", JSON.stringify(toggles))
	
	def deleteAllToggles event
		console.log event
		toggles = []
		window.localStorage.setItem("toggles", JSON.stringify(toggles))
	
	def downloadAPKG event
		window.localStorage.setItem('deckName', deckName)
		let apkg = AnkiExport(deckName)
		for toggle in toggles
			# TODO: handle images
			apkg.addCard(toggle.title, toggle.content)
		const output = await apkg.save()
		saveAs(output, `${deckName}.apkg`)

	<self>
		<header>
			<div[d: flex jc: space-between ai: center]>
				<h1 [m: 0]> "Toggles to Anki"
				<input placeholder="Your cool deck name" bind=deckName>
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
					<div [d: flex jc: space-around p: 2rem]>
						<button @click=downloadAPKG> "Download"
						<button @click=deleteAllToggles> "Delete"

imba.mount <app>
