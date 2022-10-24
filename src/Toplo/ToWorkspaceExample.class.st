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
	
	(bindings includesKey: aString) ifFalse: [ 
		bindings at: aString put: nil ].
	^ bindings associationAt: aString
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

{ #category : #accessing }
ToWorkspaceExample >> doItContext [

	^ self
]

{ #category : #accessing }
ToWorkspaceExample >> doItReceiver [

	^ nil
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

{ #category : #'user interface' }
ToWorkspaceExample >> open [
	| space |
	space := OBlSpace new.
	space root addChild: self codeEditor.
	space show.
]
