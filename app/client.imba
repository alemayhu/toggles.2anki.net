global css html
	ff:sans

tag app

	toggles = [{title: "Your title", content: "Your content"}]

	def createNewToggle event
		console.log event
		toggles.push({title: "Your title", content: "Your content"})

	<self>
		<header>
			<h1> "Toggles to Anki"
			<hr>
		<main>
			<div[d: flex jc: space-between]>
				<div>
					<button @click=createNewToggle> "+"
				<div>
					for toggle in toggles
						<details contentEditable=true> 
							<summary> toggle.title
							toggle.content

imba.mount <app>
