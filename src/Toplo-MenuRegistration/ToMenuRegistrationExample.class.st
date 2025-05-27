"
I'm here to show you how to use the menu registration. See class side methods and try it with:
----------------
(PragmaMenuBuilder pragmaKeyword: 'worldMenuExample' model: nil) menu popUpInWorld
----------------

"
Class {
	#name : #ToMenuRegistrationExample,
	#superclass : #Object,
	#category : #'Toplo-MenuRegistration-Old'
}

{ #category : #examples }
ToMenuRegistrationExample class >> example1 [
	<script>
	| items |
	items := ((ToPragmaMenuBuilder
		           pragmaKeyword: #toploWorldMenuExample
		           model: WorldState new)
		          menuSpec) items.
	MenubarMorph new
		menuBarItems: items;
		open
]

{ #category : #examples }
ToMenuRegistrationExample class >> example2 [

	<script>
	| b |
	b := ToPragmaMenuBuilder
		     pragmaKeyword: #toploWorldMenuExample
		     model: WorldState new.
	(b menuEntitled: 'World') popUpInWorld.
	b inspect
]

{ #category : #'menu declaring' }
ToMenuRegistrationExample class >> mostUsedToolsOn: aBuilder [

	<toploWorldMenuExample>
	
	(aBuilder group: #Tools)
		withSeparatorAfter;
		order: 0;
		target: Smalltalk tools;
		with: [
			(aBuilder item: #'System browser')
				selector: #openClassBrowser;
				icon:
					(aBuilder iconNamed: Smalltalk tools browser taskbarIconName).
			(aBuilder item: #Playground)
				selector: #openPlayground;
				icon:
					(aBuilder iconNamed: Smalltalk tools workspace taskbarIconName) ]
]

{ #category : #'menu declaring' }
ToMenuRegistrationExample class >> myOwnCoolMenuRegistrationOn: aBuilder [
	<toploWorldMenuExample>
	(aBuilder item: #MyOwnCoolMenu)
		parent: #Tools; "place me as a child of the #Tools node (declared by #toolsOn:)"
		label: 'The coolest tool here';
		with: [
			(aBuilder item: #MyOwnCoolTool)
				label: 'My own cool tool also here';
				target: Smalltalk tools workspace;
				selector: #openContents: ;
				arguments: #('yep, my own cool tool can be also opened from a world sub-menu ! :)')]
]

{ #category : #'menu declaring' }
ToMenuRegistrationExample class >> myOwnCoolToolRegistrationOn: aBuilder [
	<toploWorldMenuExample2>
	(aBuilder item: #MyOwnCoolTool)
		parent: #Tools;
		label: 'My own cool tool';
		target: Smalltalk tools workspace;
		selector: #openContents: ;
		arguments: #('yep, my own cool tool can be opened from the world menu ! :)')
]

{ #category : #'menu declaring' }
ToMenuRegistrationExample class >> pharoItemsOn: aBuilder [

	<toploWorldMenuExample>

	(aBuilder group: #QuitPharo)
		order: 9999;
		with: [
			{
				{
					'Save'.
					{
						Smalltalk.
						#saveSession }.
					'save the current version of the image on disk' }.
				{
					'Save as...'.
					{
						self.
						#saveAs }.
					'save the current version of the image on disk under a new name.' }.
				{
					'Save and quit'.
					{
						self.
						#saveAndQuit }.
					'save the current image on disk, and quit Pharo.' }.
				{
					'Quit'.
					{
						self.
						#quitSession }.
					'quit Pharo.' } } do: [ :triplet |
					(aBuilder item: triplet first asSymbol)
						target: triplet second first;
						selector: triplet second second;
						help: (triplet size > 2
								 ifTrue: [ triplet third ]
								 ifFalse: [ nil ]) ] ]
]

{ #category : #'menu declaring' }
ToMenuRegistrationExample class >> pragmaKeyword [
	^ #toploWorldMenuExample
]

{ #category : #'menu actions' }
ToMenuRegistrationExample class >> quitSession [

	Smalltalk
		snapshot: (MorphicUIManager new
				 confirm: 'Save changes before quitting?' translated
				 orCancel: [ ^ self ])
		andQuit: true
]

{ #category : #'menu actions' }
ToMenuRegistrationExample class >> saveAndQuit [
	Smalltalk snapshot: true andQuit: true
]

{ #category : #'menu actions' }
ToMenuRegistrationExample class >> saveAs [
	Smalltalk saveAs
]

{ #category : #'menu declaring' }
ToMenuRegistrationExample class >> theme [
	"Answer the ui theme that provides controls."

	^ Smalltalk ui theme
]

{ #category : #'menu declaring' }
ToMenuRegistrationExample class >> toolsOn: aBuilder [
	<toploWorldMenuExample>
	(aBuilder item: #Tools)
		order: 1.0;
		target: Smalltalk tools;
		iconName: #smallDoIt;
		withSeparatorAfter;
		with: [
			(aBuilder item: #Transcript)
				selector: #openTranscript;
				icon: (aBuilder iconNamed: Smalltalk tools transcript  taskbarIconName).
			(aBuilder item: #'File Browser')
				selector: #openFileList;
				icon: (aBuilder iconNamed: Smalltalk tools fileList taskbarIconName).
			(aBuilder item: #'Process Browser')
				selector: #openProcessBrowser;
				icon: (aBuilder iconNamed: Smalltalk tools processBrowser taskbarIconName);
				withSeparatorAfter]
]
