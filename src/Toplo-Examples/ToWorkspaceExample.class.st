"
I'm a workspace example made with Album/Toplo
"
Class {
	#name : #ToWorkspaceExample,
	#superclass : #Object,
	#instVars : [
		'textModel',
		'bindings'
	],
	#category : 'Toplo-Examples'
}

{ #category : #'instance creation' }
ToWorkspaceExample class >> openInHost: aBlOSWindowHost [

	<script>
	| space |
	space := BlSpace new.
	space host: aBlOSWindowHost.
	self new openInSpace: space.
	space show
]

{ #category : #'instance creation' }
ToWorkspaceExample class >> openInMorphic [

	<script>
	self openInHost: BlMorphicWindowHost new
]

{ #category : #'instance creation' }
ToWorkspaceExample class >> openInSDL [

	<script>
	self openInHost: BlOSWindowSDL2Host new
]

{ #category : #binding }
ToWorkspaceExample >> bindingOf: aString [

	"I want to have workspace that force the user to declare  
	variables. Still subclasses may want to do something else"
	
	| key |
	key := aString asSymbol.
	(bindings includesKey: key) ifFalse: [ 
		bindings at: key put: (GlobalVariable key: key value: nil) ].
	^ bindings at: key
]

{ #category : #bindings }
ToWorkspaceExample >> bindings [

	^ bindings 
]

{ #category : #accessing }
ToWorkspaceExample >> correctFrom: start to: stop with: aString [

	('correctFrom: ', start asString, ' to: ', stop asString, ' with: ', aString asString) traceCr
]

{ #category : #accessing }
ToWorkspaceExample >> doIt [

	| toDo |
	toDo := textModel selectedText asString.
	toDo ifEmpty: [ toDo := textModel text asString ].
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
ToWorkspaceExample >> hasBindingOf: aString [
	^ bindings includesKey: aString asSymbol
]

{ #category : #initialization }
ToWorkspaceExample >> initialize [
	super initialize.
	bindings := Dictionary new.
	textModel := ToAlbum new.

]

{ #category : #'user interface' }
ToWorkspaceExample >> initializeCodeEditor [

	textModel
		withRowNumbers;
		placeholderBuilder: [ :thePlaceholder :e | | text lab |
			text := (('Workspace example' , String cr , '- doit: Cmd-d') asRopedText
				 fontSize: 24;
				 foreground: Color gray lighter;
				 yourself).
			lab := ToLabel new text: text.
			lab beMultiLine.
			thePlaceholder addChild: lab.
			thePlaceholder preventMeAndChildrenMouseEvents ];
		styler: (BlRBTextStyler new
				 isForWorkspace: true;
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
ToWorkspaceExample >> isScripting [

	^ true
]

{ #category : #bindings }
ToWorkspaceExample >> notify: aString at: anInteger in: aString3 [ 
	('parse error: ', aString, ' at: ', anInteger asString) traceCr.
]

{ #category : #'user interface' }
ToWorkspaceExample >> open [

	self openInSpace: BlSpace new
]

{ #category : #'user interface' }
ToWorkspaceExample >> openInSpace: aSpace [

	| frame |
	self initializeCodeEditor.
	textModel infinite requestFocus.
	textModel showPlaceholder.
	frame := ToInnerWindow new title: 'Workspace'.
	frame pane addChild: textModel.
	aSpace root addChild: frame
]

{ #category : #accessing }
ToWorkspaceExample >> text [

	^ textModel text
]
