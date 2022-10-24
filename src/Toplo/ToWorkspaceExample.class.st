Class {
	#name : #ToWorkspaceExample,
	#superclass : #Object,
	#instVars : [
		'textModel',
		'announcer',
		'bindings',
		'mustDeclareVariables'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'instance creation' }
ToWorkspaceExample class >> open [
	<script>
	self new open
]

{ #category : #accessing }
ToWorkspaceExample >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #bindings }
ToWorkspaceExample >> bindingOf: aString [

	mustDeclareVariables
		ifTrue: [ ^ nil ].	"I want to have workspace that force the user to declare  
	variables. Still subclasses may want to do something else"
	bindings ifNil: [ self initializeBindings ].
	( bindings includesKey: aString )
		ifFalse: [ bindings at: aString put: nil ].
	^ bindings associationAt: aString
]

{ #category : #'user interface' }
ToWorkspaceExample >> codeEditor [

	| st |
	st := textModel
		      withLineNumbers;
		      withGhostText:
			      ('Workspace: a place where you can code and test scripts'
				       asRopedText
				       fontSize: 24;
				       foreground: Color gray lighter;
				       yourself);
		      styler: (BlRBTextStyler new workspace: self);
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
		self evaluate: selectedString onCompileError: [self halt] onError: [self halt]
		 ]
]

{ #category : #accessing }
ToWorkspaceExample >> doItContext [

	^ self
]

{ #category : #accessing }
ToWorkspaceExample >> doItReceiver [

	^ nil
]

{ #category : #accessing }
ToWorkspaceExample >> evaluate: aString onCompileError: compileErrorBlock onError: errorBlock [ 
	"evaluate aString. 
	 evaluate compileErrorBlock if there are compilation errors. 
	 evaluate errorBlock is anything happens *during* evaluation (code compiled, but it does not 
	 executes.). 
	 NOTE for future me. This is how I understand the evaluation works and why we need to catch 
	 differently the error: If there is a syntax error (avoiding compilation), it will evaluate 
	 requestor>>#notify:at:in: to notify the error and then it will call failBlock: *which is not 
	 intended to be used to throw an error*, since that should be handled (and it is) in the 
	 notification. Instead, most users of failBlock: use it to return execution without doing 
	 anything. 
	 Instead, the on:do: will catch all errors happening while executing the code once it is 
	 compiled. "
	| receiver result oldBindings |
	
	^ [
		self announcer announce: (SpCodeWillBeEvaluatedAnnouncement newContent: aString).
		oldBindings := bindings.
		receiver := self doItReceiver.
		result := receiver class compiler
			source: aString readStream;
			context: self doItContext;
			receiver: self doItReceiver;
			requestor: self;
			environment: self environment;
			failBlock:  [ 
				^ compileErrorBlock value ];
			evaluate.
		result ]
	on: Error 
	do: [ :e | errorBlock value: e ]
]

{ #category : #bindings }
ToWorkspaceExample >> hasBindingOf: aString [
	^ bindings includesKey: aString asSymbol
]

{ #category : #initialization }
ToWorkspaceExample >> initialize [
	super initialize.
	textModel := ToAlbumViewModel new.
	mustDeclareVariables := false
]

{ #category : #bindings }
ToWorkspaceExample >> initializeBindings [
	
	bindings := Dictionary new
]

{ #category : #'user interface' }
ToWorkspaceExample >> open [
	| space |
	space := OBlSpace new.
	space root addChild: self codeEditor.
	space show.
]
