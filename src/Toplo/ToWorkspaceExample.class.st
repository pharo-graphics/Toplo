Class {
	#name : #ToWorkspaceExample,
	#superclass : #Object,
	#instVars : [
		'textModel',
		'bindings'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'instance creation' }
ToWorkspaceExample class >> open [
	<script>
	self new open
]

{ #category : #bindings }
ToWorkspaceExample >> bindingOf: aString [

	"I want to have workspace that force the user to declare  
	variables. Still subclasses may want to do something else"
	
	| key |
	key := aString asSymbol.
	(bindings includesKey: key) ifFalse: [ 
		bindings at: key put: (WorkspaceVariable key: key value: nil) ].
	^ bindings at: key
]

{ #category : #bindings }
ToWorkspaceExample >> bindings [

	^ bindings 
]

{ #category : #'user interface' }
ToWorkspaceExample >> codeEditor [

	| st |
	st := textModel
		      withLineNumbers;
		      withGhostText:
			      (('Workspace: a place where you can code and test scripts'
			        , String cr , 'doit: Cmd-d') asRopedText
				       fontSize: 24;
				       foreground: Color gray lighter;
				       yourself);
		      styler: (BlRBTextStyler new
				       isForWorkspace: true;
				       workspace: self;
				       fontName: AeFontManager defaultCodeFontFamilyName;
				       yourself);
		      yourself.
	st widgetDo: [ :album | 
		album editorElement addEditorShortcut: (BlShortcutWithAction new
				 combination: BlKeyCombination primaryD;
				 action: [ :aShortcutEvent :aShortcut | self doIt ];
				 name: 'Do it';
				 description: 'Run selected expression.') ].
	^ st onAlbum
]

{ #category : #accessing }
ToWorkspaceExample >> correctFrom: start to: stop with: aString [

	('correctFrom: ', start asString, ' to: ', stop asString, ' with: ', aString asString) traceCr
]

{ #category : #accessing }
ToWorkspaceExample >> doIt [

	textModel widgetDo: [ :widget | 
		| selectedString |
		selectedString := widget editorElement selectedText asString.
		^ OpalCompiler new
			  source: selectedString readStream;
			  requestor: self;
			  failBlock: [ ^ Object new ];
			  evaluate ]
]

{ #category : #bindings }
ToWorkspaceExample >> hasBindingOf: aString [
	^ bindings includesKey: aString asSymbol
]

{ #category : #initialization }
ToWorkspaceExample >> initialize [
	super initialize.
	bindings := Dictionary new.
	textModel := ToAlbumViewModel new.

]

{ #category : #bindings }
ToWorkspaceExample >> notify: aString at: anInteger in: aString3 [ 
	('parse error: ', aString, ' at: ', anInteger asString) traceCr.
]

{ #category : #'user interface' }
ToWorkspaceExample >> open [
	| space |
	space := OBlSpace new.
	space root addChild: self codeEditor.
	space show.
]

{ #category : #accessing }
ToWorkspaceExample >> text [

	^ textModel text
]
