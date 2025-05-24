"
I'm a workspace example made with Album/Toplo
"
Class {
	#name : #ToExWorkspace,
	#superclass : #Object,
	#instVars : [
		'bindings',
		'album'
	],
	#category : #'Toplo-Examples-TopLevel'
}

{ #category : #'instance creation' }
ToExWorkspace class >> open [

	<script>
	self openInHost: BlOSWindowSDL2Host new
]

{ #category : #'instance creation' }
ToExWorkspace class >> openInHost: aBlOSWindowHost [

	<script>
	| space |
	space := BlSpace new.
	space host: aBlOSWindowHost.
	self new openInSpace: space.
	space show
]

{ #category : #'instance creation' }
ToExWorkspace class >> openInMorphic [

	<script>
	self openInHost: BlMorphicWindowHost new
]

{ #category : #'instance creation' }
ToExWorkspace class >> openInSDL [

	<script>
	self openInHost: BlOSWindowSDL2Host new
]

{ #category : #binding }
ToExWorkspace >> bindingOf: aString [

	"I want to have workspace that force the user to declare  
	variables. Still subclasses may want to do something else"
	
	| key |
	key := aString asSymbol.
	(bindings includesKey: key) ifFalse: [ 
		bindings at: key put: (GlobalVariable key: key value: nil) ].
	^ bindings at: key
]

{ #category : #bindings }
ToExWorkspace >> bindings [

	^ bindings 
]

{ #category : #accessing }
ToExWorkspace >> correctFrom: start to: stop with: aString [

	('correctFrom: ', start asString, ' to: ', stop asString, ' with: ', aString asString) traceCr
]

{ #category : #accessing }
ToExWorkspace >> doIt [

	| toDo |
	toDo := album selectedText asString.
	toDo ifEmpty: [ toDo := album text asString ].
	[
	OpalCompiler new
		source: toDo readStream;
		requestor: self;
		failBlock: [ ^ Object new ];
		evaluate ]
		on: OCUndeclaredVariableWarning
		do: [ :warn | warn traceCr ]
]

{ #category : #bindings }
ToExWorkspace >> hasBindingOf: aString [
	^ bindings includesKey: aString asSymbol
]

{ #category : #initialization }
ToExWorkspace >> initialize [
	super initialize.
	bindings := Dictionary new.
	album := ToAlbum new.

]

{ #category : #'user interface' }
ToExWorkspace >> initializeCodeEditor [

	album
		withRowNumbers;
		placeholderBuilder: [ :thePlaceholder :e | | text lab |
			text := (('Workspace example' , String cr , '- doit: Cmd-d') asRopedText
				 fontSize: 24;
				 foreground: Color gray lighter;
				 yourself).
			lab := ToAttributedLabel new text: text.
			lab beMultiLine.
			thePlaceholder addChild: lab.
			thePlaceholder preventMeAndChildrenMouseEvents ];
		styler: (BlPharoCodeStyler new
				 isScripting: true;
				 workspace: self;
				 fontName: AeFontManager defaultCodeFontFamilyName;
				 yourself);
		addEditorShortcut: (BlShortcutWithAction new
				 combination: BlKeyCombination primaryD;
				 action: [ :aShortcutEvent :aShortcut | self doIt ];
				 name: 'Do it';
				 description: 'Run selected expression.')
]

{ #category : #accessing }
ToExWorkspace >> isScripting [

	^ true
]

{ #category : #bindings }
ToExWorkspace >> notify: aString at: anInteger in: aString3 [ 
	('parse error: ', aString, ' at: ', anInteger asString) traceCr.
]

{ #category : #'user interface' }
ToExWorkspace >> open [

	self openInSpace: BlSpace new
]

{ #category : #'user interface' }
ToExWorkspace >> openInSpace: aSpace [

	| frame |
	self initializeCodeEditor.
	album requestFocus.
	album showPlaceholder.
	frame := ToInnerWindow new title: 'Workspace'.
	frame pane addChild: album.
	aSpace root addChild: frame
]

{ #category : #accessing }
ToExWorkspace >> text [

	^ album text
]
