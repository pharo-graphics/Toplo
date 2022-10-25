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
		'#text => ObservableSlot',
		'#mode => ObservableSlot',
		'#edited => ObservableSlot'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #'view configuration' }
ToAlbumViewModel >> beEditable [

	self mode: AlbEditableMode new
]

{ #category : #'view configuration' }
ToAlbumViewModel >> beReadonlyWithSelection [

	self mode: AlbReadonlyWithSelectionMode new
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> beReadonlyWithoutSelection [

	self mode: AlbReadonlyWithoutSelectionMode new
]

{ #category : #'styler configuration' }
ToAlbumViewModel >> codeFontName [ 

	^ self userData at: #codeFontName ifAbsentPut: [ self defaultCodeFontName  ]
]

{ #category : #'styler configuration' }
ToAlbumViewModel >> codeFontName: aFontName [

	^ self userData at: #codeFontName put: aFontName
]

{ #category : #initialization }
ToAlbumViewModel >> defaultCodeFontName [

	^ AeFontManager defaultCodeFontFamilyName
	
]

{ #category : #initialization }
ToAlbumViewModel >> defaultDresser [

	^ ToAlbumBasicDresser new
	
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

{ #category : #accessing }
ToAlbumViewModel >> edited [

	^ edited ifNil: [ edited := false ]
]

{ #category : #accessing }
ToAlbumViewModel >> edited: aBoolean [

	edited = aBoolean ifTrue: [ ^ self ].
	edited := aBoolean
]

{ #category : #'view request' }
ToAlbumViewModel >> flash [

	self announce: (ToAlbumFlashRequested new client: self)
]

{ #category : #initialization }
ToAlbumViewModel >> initialize [

	self class initializeSlots: self.
	super initialize.

	" action when edit state change (Observable slot) "
	self onEditedChangedDo: [ self editStateChanged ].
	self onTextReplacedDo: [ self textReplaced ].
	self onModeChangedDo: [ self modeChanged ]
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

	self whenAnnouncement: ToAlbumCancelRequested do: aBlock
]

{ #category : #'property change hook' }
ToAlbumViewModel >> onEditedChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #edited whenChangedDo: aBlock
]

{ #category : #'api - hooks' }
ToAlbumViewModel >> onInstalledOnlyMeIn: anAlbum [

	"Is sent when I am added to an element "

	super onInstalledOnlyMeIn: anAlbum.

	self mode: anAlbum mode.

	anAlbum onTextReplacedDo: [ :t | self privateText: t ].
	anAlbum onModeChangedDo: [ :m | self privateMode: m ].
	anAlbum onTextEditedDo: [ self textEdited ].
	
	self text: ''
]

{ #category : #'property change hook' }
ToAlbumViewModel >> onModeChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #mode whenChangedDo: aBlock
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> onSaveAcceptedDo: aBlock [

	self whenAnnouncement: ToAlbumSaveAccepted do: aBlock
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> onSaveAcceptedSend: aSelector to: anObject [

	self whenAnnouncement: ToAlbumSaveAccepted send: aSelector to: anObject
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> onSaveDeniedDo: aBlock [

	self whenAnnouncement: ToAlbumSaveDenied do: aBlock
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> onSaveDeniedSend: aSelector to: anObject [

	self whenAnnouncement: ToAlbumSaveDenied send: aSelector to: anObject
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> onSaveRequestedDo: aBlock [

	self whenAnnouncement: ToAlbumSaveRequested do: aBlock
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> onSaveRequestedSend: aSelector to: anObject [

	self whenAnnouncement: ToAlbumSaveRequested send: aSelector to: anObject
]

{ #category : #'property change hook' }
ToAlbumViewModel >> onTextReplacedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #text whenChangedDo: aBlock
]

{ #category : #'api - hooks' }
ToAlbumViewModel >> onUninstalledOnlyMeIn: anAlbum [

	"Is sent when I am added to an element "

	super onUninstalledOnlyMeIn: anAlbum.
	anAlbum viewModel unsubscribe: self.
	self unsubscribe: anAlbum editorElement.
	self styler ifNotNil: [ :styler | 
		self styler unsubscribe: self.
		self unsubscribe: styler ]
]

{ #category : #private }
ToAlbumViewModel >> privateMode: anEditabilityMode [

	mode = anEditabilityMode ifTrue: [ ^ self ].
	mode := anEditabilityMode
]

{ #category : #private }
ToAlbumViewModel >> privateText: aBlText [

	aBlText == self text ifTrue: [ ^ self ].
	self edited: false.
	text := aBlText.
	self announce: (ToAlbumTextReplaced new client: self; text: self text; yourself).
	" ask the stylerHolder to style through its observal slot"
	self requestTextStyle

]

{ #category : #'transaction hook' }
ToAlbumViewModel >> requestCancel [

	self announce: (ToAlbumCancelRequested new client: self)
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> requestSave [

	self announce: (ToAlbumSaveRequested new
			 client: self;
			 unacceptedEdits: self edited ;
			 yourself)
]

{ #category : #'styler configuration' }
ToAlbumViewModel >> requestTextStyle [

	self announce: ToTextStyleRequested new
]

{ #category : #'transaction hook' }
ToAlbumViewModel >> saveResult: aBoolean [

	| announcement |
	self edited: aBoolean not.
	announcement := aBoolean
		                ifTrue: [ ToAlbumSaveAccepted new client: self ]
		                ifFalse: [ ToAlbumSaveDenied new client: self ].
	self announce: announcement
]

{ #category : #'styler configuration' }
ToAlbumViewModel >> styler [

	^ self userData at: #styler ifAbsent: [  ]
]

{ #category : #'styler configuration' }
ToAlbumViewModel >> styler: aBlStyler [

	self widgetDo: [ :album | 
		self styler ifNotNil: [ :styler | 
			self styler unsubscribe: self.
			self unsubscribe: styler ].

		self userData at: #styler put: aBlStyler.

		self styler ifNil: [ ^ self ].

		aBlStyler fontName: self codeFontName.
		aBlStyler whenAnnouncement: BlStylerStateChanged send: #whenStylerStateChanged: to: self.
		aBlStyler whenAnnouncement: BlStylerTextStyled send: #whenStylerTextStyled: to: self.
		self whenAnnouncement: ToTextStyleRequested send: #whenTextStyleRequested: to: self ]
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
ToAlbumViewModel >> textEdited [

	self edited: true.
	self announce: (ToAlbumTextEdited new client: self; text: self text; yourself).
	" ask the stylerHolder to style through its observal slot"
	self requestTextStyle
]

{ #category : #'change hook' }
ToAlbumViewModel >> textReplaced [
]

{ #category : #'styler configuration' }
ToAlbumViewModel >> whenStylerStateChanged: aBlStylerStateChangedAnnouncement [

	self widgetDo: [ :album | self requestTextStyle ]
]

{ #category : #'styler configuration' }
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

{ #category : #'styler configuration' }
ToAlbumViewModel >> whenTextStyleRequested: aToTextStyleRequested [

	self widgetDo: [ :album | 
		self styler ifNotNil: [ 
			self styler announce: (BlStylerTextStyleRequested new
					 unstyledText: self text nextGeneration;
					 referentElement: album;
					 yourself) ] ]
]

{ #category : #'view configuration' }
ToAlbumViewModel >> withEditsFeedbackLayer [

	self widgetDo: [ :album | album withEditsFeedbackFrom: self. ]
]

{ #category : #'view configuration' }
ToAlbumViewModel >> withGhostText: aText [

	self widgetDo: [ :album | album withGhostText: aText from: self ]
]

{ #category : #'view configuration' }
ToAlbumViewModel >> withLineNumbers [

	self widgetDo: [ :album | album withLineNumbers ]
]

{ #category : #'view configuration' }
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

{ #category : #'view configuration' }
ToAlbumViewModel >> withoutEditsFeedbackLayer [

	self widgetDo: [ :album | album withoutEditsFeedback. ]
]

{ #category : #'view configuration' }
ToAlbumViewModel >> withoutGhostText [

	self widgetDo: [ :album | album withoutGhostText ]
]

{ #category : #'view configuration' }
ToAlbumViewModel >> withoutLineNumbers [

	self widgetDo: [ :album | album withoutLineNumbers ]
]
