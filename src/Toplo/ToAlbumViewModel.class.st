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
	#name : #ToAlbumViewModel,
	#superclass : #OBlViewModel,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#hasUnacceptedEdits => ObservableSlot',
		'#text',
		'#mode'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #accessing }
ToAlbumViewModel >> beEditable [

	self mode: AlbEditableMode new
]

{ #category : #accessing }
ToAlbumViewModel >> beReadonlyWithSelection [

	self mode: AlbReadonlyWithSelectionMode new
]

{ #category : #accessing }
ToAlbumViewModel >> beReadonlyWithoutSelection [

	self mode: AlbReadonlyWithoutSelectionMode new
]

{ #category : #'api - styling' }
ToAlbumViewModel >> codeFontName [ 

	^ self userData at: #codeFontName ifAbsentPut: [ self defaultCodeFontName  ]
]

{ #category : #'api - styling' }
ToAlbumViewModel >> codeFontName: aFontName [

	^ self userData at: #codeFontName put: aFontName
]

{ #category : #initialization }
ToAlbumViewModel >> defaultCodeFontName [

	^ AeFontManager defaultCodeFontFamilyName
	
]

{ #category : #initialization }
ToAlbumViewModel >> defaultStyler [

	^ nil 
]

{ #category : #initialization }
ToAlbumViewModel >> defaultText [

	^ '' asRopedText
	
]

{ #category : #'change hook' }
ToAlbumViewModel >> editStateChanged [


]

{ #category : #'view request' }
ToAlbumViewModel >> flash [

	self announce: (ToAlbumFlashRequested new client: self)
]

{ #category : #accessing }
ToAlbumViewModel >> hasUnacceptedEdits [

	^ hasUnacceptedEdits ifNil: [ hasUnacceptedEdits := false ]
]

{ #category : #accessing }
ToAlbumViewModel >> hasUnacceptedEdits: aBoolean [

	hasUnacceptedEdits = aBoolean ifTrue: [ ^ self ].
	hasUnacceptedEdits := aBoolean
]

{ #category : #initialization }
ToAlbumViewModel >> initialize [

	self class initializeSlots: self.
	super initialize.
	self text: self defaultText.
	
	" action when edit state change (Observable slot) "
	self whenEditStateChangedDo: [ :t | self editStateChanged ]
]

{ #category : #accessing }
ToAlbumViewModel >> mode [

	^ mode

	
]

{ #category : #accessing }
ToAlbumViewModel >> mode: anEditabilityMode [

	mode = anEditabilityMode ifTrue: [ ^ self ].
	mode := anEditabilityMode.
	self widgetDo: [ :album | album mode: anEditabilityMode ]
]

{ #category : #'change hook' }
ToAlbumViewModel >> modeChanged [


]

{ #category : #'view instanciation' }
ToAlbumViewModel >> onAlbum [

	| album |
	album := ToAlbum new.
	self onInstalledIn: album.
	^ album
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> onCancelRequestedDo: aBlock [

	self when: ToAlbumCancelRequested do: aBlock
]

{ #category : #'api - hooks' }
ToAlbumViewModel >> onInstalledIn: anAlbum [

	"Is sent when I am added to an element "

	super onInstalledIn: anAlbum.
	self mode: anAlbum mode.

	anAlbum whenTextChangedDo: [ :t | self privateText: t ].
	anAlbum whenModeChangedDo: [ :m | self privateMode: m ].
	anAlbum editorElement viewModel when: AlbTextModifiedByEditor send: #whenTextModified: to: self.

	self runPostponedAction.

]

{ #category : #'transaction hook' }
ToAlbumViewModel >> onSaveAcceptedDo: aBlock [

	self when: ToAlbumSaveAccepted do: aBlock
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> onSaveAcceptedSend: aSelector to: anObject [

	self when: ToAlbumSaveAccepted send: aSelector to: anObject
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> onSaveDeniedDo: aBlock [

	self when: ToAlbumSaveDenied do: aBlock
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> onSaveDeniedSend: aSelector to: anObject [

	self when: ToAlbumSaveDenied send: aSelector to: anObject
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> onSaveRequestedDo: aBlock [

	self when: ToAlbumSaveRequested do: aBlock
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> onSaveRequestedSend: aSelector to: anObject [

	self when: ToAlbumSaveRequested send: aSelector to: anObject
]

{ #category : #'change hook' }
ToAlbumViewModel >> onTextChangedDo: aBlock [

	self when: ToAlbumTextChanged do: aBlock
]

{ #category : #'change hook' }
ToAlbumViewModel >> onTextModifiedDo: aBlock [

	self when: ToAlbumTextModified do: aBlock
]

{ #category : #'api - hooks' }
ToAlbumViewModel >> onUninstalledIn: anAlbum [

	"Is sent when I am added to an element "

	super onUninstalledIn: anAlbum.
	anAlbum viewModel unsubscribe: self.
	self unsubscribe: anAlbum editorElement.
	self styler ifNotNil: [ :styler | 
		self styler unsubscribe: self.
		self unsubscribe: styler ]
]

{ #category : #private }
ToAlbumViewModel >> privateMode: anEditabilityMode [

	mode = anEditabilityMode ifTrue: [ ^ self ].
	mode := anEditabilityMode.
	self modeChanged
]

{ #category : #private }
ToAlbumViewModel >> privateText: aBlText [

	self hasUnacceptedEdits: false.
	self resetEditorHistory.
	aBlText == self text ifTrue: [ ^ self ].
	text := aBlText.
	self textChanged
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> requestCancel [

	self announce: (ToAlbumCancelRequested new client: self)
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> requestSave [

	self announce: (ToAlbumSaveRequested new
			 client: self;
			 unacceptedEdits: self hasUnacceptedEdits ;
			 yourself)
]

{ #category : #'api - styling' }
ToAlbumViewModel >> requestTextStyle [

	self announce: ToTextStyleRequested new
]

{ #category : #private }
ToAlbumViewModel >> resetEditorHistory [ 

	self widgetDo: [ :album | album resetEditorHistory ]
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> saveResult: aBoolean [

	| announcement |
	self hasUnacceptedEdits: aBoolean not.
	announcement := aBoolean
		                ifTrue: [ ToAlbumSaveAccepted new client: self ]
		                ifFalse: [ ToAlbumSaveDenied new client: self ].
	self announce: announcement
]

{ #category : #'api - styling' }
ToAlbumViewModel >> styler [

	^ self userData at: #styler ifAbsent: [  ]
]

{ #category : #'api - styling' }
ToAlbumViewModel >> styler: aBlStyler [

	self widgetDo: [ :album | 
		self styler ifNotNil: [ :styler | 
			self styler unsubscribe: self.
			self unsubscribe: styler ].

		self userData at: #styler put: aBlStyler.

		self styler ifNil: [ ^ self ].

		aBlStyler fontName: self codeFontName.
		aBlStyler when: BlStylerStateChanged send: #whenStylerStateChanged: to: self.
		aBlStyler when: BlStylerTextStyled send: #whenStylerTextStyled: to: self.
		self when: ToTextStyleRequested send: #whenTextStyleRequested: to: self ]
]

{ #category : #accessing }
ToAlbumViewModel >> text [

	^ text

	
]

{ #category : #accessing }
ToAlbumViewModel >> text: aBlText [

	self text == aBlText ifTrue: [ ^ self ].
	self widgetDo: [ :album | album text: aBlText asRopedText]
]

{ #category : #'change hook' }
ToAlbumViewModel >> textChanged [

	self announce: (ToAlbumTextChanged new client: self; text: self text; yourself).
	" ask the stylerHolder to style through its observal slot"
	self requestTextStyle

]

{ #category : #'change hook' }
ToAlbumViewModel >> textModified [

	self announce: (ToAlbumTextModified new client: self; text: self text; yourself).
	" ask the stylerHolder to style through its observal slot"
	self requestTextStyle
]

{ #category : #'change hook' }
ToAlbumViewModel >> unacceptedEditsDo: aBlock [

	aBlock value: self hasUnacceptedEdits
]

{ #category : #'private-change hook' }
ToAlbumViewModel >> whenEditStateChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #hasUnacceptedEdits whenChangedDo: aBlock
]

{ #category : #'api - styling' }
ToAlbumViewModel >> whenStylerStateChanged: aBlStylerStateChangedAnnouncement [

	self widgetDo: [ :album | self requestTextStyle ]
]

{ #category : #'api - styling' }
ToAlbumViewModel >> whenStylerTextStyled: aBlStylerTextStyledAnnouncement [

	self widgetDo: [ :album | 
		| result |
		result := aBlStylerTextStyledAnnouncement styledText.
		" text just styled by the styler, check the generation (to be thread-safe) to ensure that 
			my text has not be changed elsewhere during the styling "
		(result isNextGenerationOf: self text) ifFalse: [ ^ self ].
		self text takeInternalRepresentationOf: result.
		album editorElement textInternalRepresentationChanged ]
]

{ #category : #'event management' }
ToAlbumViewModel >> whenTextModified: aTextModifiedByEditorAnnouncement [

	self hasUnacceptedEdits: true.
	self textModified

]

{ #category : #'api - styling' }
ToAlbumViewModel >> whenTextStyleRequested: aToTextStyleRequested [

	self widgetDo: [ :album | 
		self styler ifNotNil: [ 
			self styler announce: (BlStylerTextStyleRequested new
					 unstyledText: self text nextGeneration;
					 referentElement: album;
					 yourself) ] ]
]

{ #category : #configuration }
ToAlbumViewModel >> withEditsFeedbackLayer [

	self widgetDo: [ :album | album withEditsFeedbackFrom: self. ]
]

{ #category : #configuration }
ToAlbumViewModel >> withGhostText: aText [

	self widgetDo: [ :album | album withGhostText: aText from: self ]
]

{ #category : #configuration }
ToAlbumViewModel >> withLineNumbers [

	self widgetDo: [ :album | album withLineNumbers ]
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> withSaveCapability [

	self withEditsFeedbackLayer.
	self widgetDo: [ :album | 
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
ToAlbumViewModel >> withoutEditsFeedbackLayer [

	self widgetDo: [ :album | album withoutEditsFeedback. ]
]

{ #category : #configuration }
ToAlbumViewModel >> withoutGhostText [

	self widgetDo: [ :album | album withoutGhostText ]
]

{ #category : #configuration }
ToAlbumViewModel >> withoutLineNumbers [

	self widgetDo: [ :album | album withoutLineNumbers ]
]
