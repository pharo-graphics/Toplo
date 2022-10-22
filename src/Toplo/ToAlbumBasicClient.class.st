"
I implement a typical Album user with a styler.
I'm a kind of model but without any association from the widget to the client (no reference to the client is stored in widget).
It can be used and subclassed to support comment and code editing, workspace implementation...

The different kind of Album using should use the available basic client class or subclass it for specific purpose.


Here is an example of a basic client to open an Album on the Collection>>#difference

| client |
client := ToAlbumBasicClient new.
client styler: BlRBTextStyler new.
client classOrMetaClass: self class.
client withLineNumbers.
client text: (Collection sourceCodeAt: #difference:).
client withGhostText: (('Styled code') asRopedText fontSize: 30; foreground: Color veryLightGray).
client withEditsFeedbackLayer.

client onAlbum openInOBlSpace.

"
Class {
	#name : #ToAlbumBasicClient,
	#superclass : #OBlElementCompanion,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#hasUnacceptedEdits => ObservableSlot',
		'#text',
		'#mode'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #'accessing - album' }
ToAlbumBasicClient >> albumDo: aBlock [

	self announce: (ToActionRequiredInAlbum new
			 valuable: aBlock;
			 yourself)
]

{ #category : #accessing }
ToAlbumBasicClient >> beEditable [

	self mode: AlbEditableMode new
]

{ #category : #accessing }
ToAlbumBasicClient >> beReadonlyWithSelection [

	self mode: AlbReadonlyWithSelectionMode new
]

{ #category : #accessing }
ToAlbumBasicClient >> beReadonlyWithoutSelection [

	self mode: AlbReadonlyWithoutSelectionMode new
]

{ #category : #'api - styling' }
ToAlbumBasicClient >> codeFontName [ 

	^ self userData at: #codeFontName ifAbsentPut: [ self defaultCodeFontName  ]
]

{ #category : #'api - styling' }
ToAlbumBasicClient >> codeFontName: aFontName [

	^ self userData at: #codeFontName put: aFontName
]

{ #category : #initialization }
ToAlbumBasicClient >> defaultCodeFontName [

	^ AeFontManager defaultCodeFontFamilyName
	
]

{ #category : #initialization }
ToAlbumBasicClient >> defaultStyler [

	^ nil 
]

{ #category : #initialization }
ToAlbumBasicClient >> defaultText [

	^ '' asRopedText
	
]

{ #category : #'change hook' }
ToAlbumBasicClient >> editStateChanged [


]

{ #category : #'view request' }
ToAlbumBasicClient >> flash [

	self announce: (ToAlbumFlashRequested new client: self)
]

{ #category : #accessing }
ToAlbumBasicClient >> hasUnacceptedEdits [

	^ hasUnacceptedEdits ifNil: [ hasUnacceptedEdits := false ]
]

{ #category : #accessing }
ToAlbumBasicClient >> hasUnacceptedEdits: aBoolean [

	hasUnacceptedEdits = aBoolean ifTrue: [ ^ self ].
	hasUnacceptedEdits := aBoolean
]

{ #category : #initialization }
ToAlbumBasicClient >> initialize [

	self class initializeSlots: self.
	super initialize.
	
	self startPostponedActionsStorage.
	self text: self defaultText.
	
	" action when edit state change (Observable slot) "
	self whenEditStateChangedDo: [ :t | self editStateChanged ]
]

{ #category : #accessing }
ToAlbumBasicClient >> mode [

	^ mode

	
]

{ #category : #accessing }
ToAlbumBasicClient >> mode: anEditabilityMode [

	mode = anEditabilityMode ifTrue: [ ^ self ].
	mode := anEditabilityMode.
	self albumDo: [ :album | album mode: anEditabilityMode ]
]

{ #category : #'change hook' }
ToAlbumBasicClient >> modeChanged [


]

{ #category : #'accessing - album' }
ToAlbumBasicClient >> onAlbum [

	^ self onAlbum: ToAlbum new
]

{ #category : #'accessing - album' }
ToAlbumBasicClient >> onAlbum: anAlbum [

	self onInstalledIn: anAlbum.
	^ anAlbum
]

{ #category : #'transaction hook' }
ToAlbumBasicClient >> onCancelRequestedDo: aBlock [

	self when: ToAlbumCancelRequested do: aBlock
]

{ #category : #'api - hooks' }
ToAlbumBasicClient >> onInstalledIn: anAlbum [

	"Is sent when I am added to an element "

	super onInstalledIn: anAlbum.
	
	self stopPostponedActionsStorage.	
	self when: ToActionRequiredInAlbum send: #whenActionRequired: to: anAlbum.

	self mode: anAlbum mode.

	anAlbum whenTextChangedDo: [ :t | self privateText: t ].
	anAlbum whenModeChangedDo: [ :m | self privateMode: m ].
	anAlbum viewModel when: AlbTextModifiedByEditor send: #whenTextModifiedByTextEditor: to: self.

	self runPostponedAction.

]

{ #category : #'transaction hook' }
ToAlbumBasicClient >> onSaveAcceptedDo: aBlock [

	self when: ToAlbumSaveAccepted do: aBlock
]

{ #category : #'transaction hook' }
ToAlbumBasicClient >> onSaveAcceptedSend: aSelector to: anObject [

	self when: ToAlbumSaveAccepted send: aSelector to: anObject
]

{ #category : #'transaction hook' }
ToAlbumBasicClient >> onSaveDeniedDo: aBlock [

	self when: ToAlbumSaveDenied do: aBlock
]

{ #category : #'transaction hook' }
ToAlbumBasicClient >> onSaveDeniedSend: aSelector to: anObject [

	self when: ToAlbumSaveDenied send: aSelector to: anObject
]

{ #category : #'transaction hook' }
ToAlbumBasicClient >> onSaveRequestedDo: aBlock [

	self when: ToAlbumSaveRequested do: aBlock
]

{ #category : #'transaction hook' }
ToAlbumBasicClient >> onSaveRequestedSend: aSelector to: anObject [

	self when: ToAlbumSaveRequested send: aSelector to: anObject
]

{ #category : #'change hook' }
ToAlbumBasicClient >> onTextChangedDo: aBlock [

	self when: ToAlbumTextChanged do: aBlock
]

{ #category : #'change hook' }
ToAlbumBasicClient >> onTextModifiedDo: aBlock [

	self when: ToAlbumTextModified do: aBlock
]

{ #category : #'api - hooks' }
ToAlbumBasicClient >> onUninstalledIn: anAlbum [

	"Is sent when I am added to an element "

	super onUninstalledIn: anAlbum.
	anAlbum viewModel unsubscribe: self.
	self unsubscribe: anAlbum editorElement.
	self unsubscribe: anAlbum.
	self styler ifNotNil: [ :styler | 
		self styler unsubscribe: self.
		self unsubscribe: styler ]
]

{ #category : #'private-postponed actions' }
ToAlbumBasicClient >> postponedActions [

	^ self userData at: #postponedActions ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #private }
ToAlbumBasicClient >> privateMode: anEditabilityMode [

	mode = anEditabilityMode ifTrue: [ ^ self ].
	mode := anEditabilityMode.
	self modeChanged
]

{ #category : #private }
ToAlbumBasicClient >> privateText: aBlText [

	self hasUnacceptedEdits: false.
	self resetEditorHistory.
	aBlText == self text ifTrue: [ ^ self ].
	text := aBlText.
	self textChanged
]

{ #category : #'private-postponed actions' }
ToAlbumBasicClient >> removePostponedActions [

	self userData removeKey: #postponedActions ifAbsent: [  ]
]

{ #category : #'transaction hook' }
ToAlbumBasicClient >> requestCancel [

	self announce: (ToAlbumCancelRequested new client: self)
]

{ #category : #'transaction hook' }
ToAlbumBasicClient >> requestSave [

	self announce: (ToAlbumSaveRequested new
			 client: self;
			 unacceptedEdits: self hasUnacceptedEdits ;
			 yourself)
]

{ #category : #'api - styling' }
ToAlbumBasicClient >> requestTextStyle [

	self announce: ToTextStyleRequested new
]

{ #category : #private }
ToAlbumBasicClient >> resetEditorHistory [ 

	self albumDo: [ :album | album resetEditorHistory ]
]

{ #category : #'private-postponed actions' }
ToAlbumBasicClient >> runPostponedAction [

	self postponedActions do: [ :announcement | self announce: announcement ].
	self removePostponedActions
]

{ #category : #'transaction hook' }
ToAlbumBasicClient >> saveResult: aBoolean [

	| announcement |
	self hasUnacceptedEdits: aBoolean not.
	announcement := aBoolean
		                ifTrue: [ ToAlbumSaveAccepted new client: self ]
		                ifFalse: [ ToAlbumSaveDenied new client: self ].
	self announce: announcement
]

{ #category : #'private-postponed actions' }
ToAlbumBasicClient >> startPostponedActionsStorage [

	self when: ToActionRequiredInAlbum send: #whenActionRequiredInAlbum: to: self
]

{ #category : #'private-postponed actions' }
ToAlbumBasicClient >> stopPostponedActionsStorage [

	self unsubscribe: self.

]

{ #category : #'api - styling' }
ToAlbumBasicClient >> styler [

	^ self userData at: #styler ifAbsent: [  ]
]

{ #category : #'api - styling' }
ToAlbumBasicClient >> styler: aBlStyler [

	self styler ifNotNil: [ :styler | 
		self styler unsubscribe: self.
		self unsubscribe: styler ].

	self userData at: #styler put: aBlStyler.

	self styler ifNil: [ ^ self ].

	aBlStyler fontName: self codeFontName.
	aBlStyler when: BlStylerStateChanged send: #whenStylerStateChanged: to: self.
	aBlStyler when: BlStylerTextStyled send: #whenStylerTextStyled: to: self.
	self when: ToTextStyleRequested send: #whenTextStyleRequested: to: self
]

{ #category : #accessing }
ToAlbumBasicClient >> text [

	^ text

	
]

{ #category : #accessing }
ToAlbumBasicClient >> text: aBlText [

	self text == aBlText ifTrue: [ ^ self ].
	self albumDo: [ :album | album text: aBlText asRopedText]
]

{ #category : #'change hook' }
ToAlbumBasicClient >> textChanged [

	self announce: (ToAlbumTextChanged new client: self; text: self text; yourself).
	" ask the stylerHolder to style through its observal slot"
	self requestTextStyle

]

{ #category : #'change hook' }
ToAlbumBasicClient >> textModified [

	self announce: (ToAlbumTextModified new client: self; text: self text; yourself).
	" ask the stylerHolder to style through its observal slot"
	self requestTextStyle
]

{ #category : #'change hook' }
ToAlbumBasicClient >> unacceptedEditsDo: aBlock [

	aBlock value: self hasUnacceptedEdits
]

{ #category : #private }
ToAlbumBasicClient >> whenActionRequiredInAlbum: anActionRequired [

	self postponedActions add: anActionRequired.
]

{ #category : #'private-change hook' }
ToAlbumBasicClient >> whenEditStateChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #hasUnacceptedEdits whenChangedDo: aBlock
]

{ #category : #'api - styling' }
ToAlbumBasicClient >> whenStylerStateChanged: aBlStylerStateChangedAnnouncement [

	self albumDo: [ :album | self requestTextStyle ]
]

{ #category : #'api - styling' }
ToAlbumBasicClient >> whenStylerTextStyled: aBlStylerTextStyledAnnouncement [

	self albumDo: [ :album | 
		| result |
		result := aBlStylerTextStyledAnnouncement styledText.
		" text just styled by the styler, check the generation (to be thread-safe) to ensure that 
			my text has not be changed elsewhere during the styling "
		(result isNextGenerationOf: self text) ifFalse: [ ^ self ].
		self text takeInternalRepresentationOf: result.
		album editorElement textInternalRepresentationChanged ]
]

{ #category : #'event management' }
ToAlbumBasicClient >> whenTextModifiedByTextEditor: aTextModifiedByEditorAnnouncement [

	self hasUnacceptedEdits: true.
	self textModified

]

{ #category : #'api - styling' }
ToAlbumBasicClient >> whenTextStyleRequested: aToTextStyleRequested [

	self albumDo: [ :album | 
		self styler ifNotNil: [ 
			self styler announce: (BlStylerTextStyleRequested new
					 unstyledText: self text nextGeneration;
					 referentElement: album;
					 yourself) ] ]
]

{ #category : #configuration }
ToAlbumBasicClient >> withEditsFeedbackLayer [

	self albumDo: [ :album | album withEditsFeedbackFrom: self. ]
]

{ #category : #configuration }
ToAlbumBasicClient >> withGhostText: aText [

	self albumDo: [ :album | album withGhostText: aText from: self ]
]

{ #category : #configuration }
ToAlbumBasicClient >> withLineNumbers [

	self albumDo: [ :album | album withLineNumbers ]
]

{ #category : #'transaction hook' }
ToAlbumBasicClient >> withSaveTransaction [

	self withEditsFeedbackLayer.
	self albumDo: [ :album | 
		album editorElement addEditorShortcut: (BlShortcutWithAction new
				 combination: BlKeyCombination primaryS;
				 action: [ :aShortcutEvent :aShortcut | self requestSave ];
				 name: 'Save';
				 description: 'Apply changes and save the source code (compile).').
		album editorElement addEditorShortcut: (BlShortcutWithAction new
				 combination: BlKeyCombination primaryL;
				 action: [ :aShortcutEvent :aShortcut | self requestCancel ];
				 name: 'Cancel';
				 description: 'Cancel changes and rollback the previous accepted source code.') ]
]

{ #category : #configuration }
ToAlbumBasicClient >> withoutEditsFeedbackLayer [

	self albumDo: [ :album | album withoutEditsFeedback. ]
]

{ #category : #configuration }
ToAlbumBasicClient >> withoutGhostText [

	self albumDo: [ :album | album withoutGhostText ]
]

{ #category : #configuration }
ToAlbumBasicClient >> withoutLineNumbers [

	self albumDo: [ :album | album withoutLineNumbers ]
]
