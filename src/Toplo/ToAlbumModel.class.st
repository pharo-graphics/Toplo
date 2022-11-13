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
	#name : #ToAlbumModel,
	#superclass : #ToViewModel,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#text => ObservableSlot',
		'#mode => ObservableSlot',
		'#edited => ObservableSlot'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #'view configuration' }
ToAlbumModel >> beEditable [

	self mode: AlbEditableMode new
]

{ #category : #'view configuration' }
ToAlbumModel >> beReadonlyWithSelection [

	self mode: AlbReadonlyWithSelectionMode new
]

{ #category : #'transaction hook' }
ToAlbumModel >> beReadonlyWithoutSelection [

	self mode: AlbReadonlyWithoutSelectionMode new
]

{ #category : #'styler configuration' }
ToAlbumModel >> codeFontName [ 

	^ self userData at: #codeFontName ifAbsentPut: [ self defaultCodeFontName  ]
]

{ #category : #'styler configuration' }
ToAlbumModel >> codeFontName: aFontName [

	^ self userData at: #codeFontName put: aFontName
]

{ #category : #initialization }
ToAlbumModel >> defaultCodeFontName [

	^ AeFontManager defaultCodeFontFamilyName
	
]

{ #category : #initialization }
ToAlbumModel >> defaultDresser [

	^ ToAlbumBasicDresser new
	
]

{ #category : #initialization }
ToAlbumModel >> defaultStyler [

	^ nil 
]

{ #category : #initialization }
ToAlbumModel >> defaultText [

	^ '' asRopedText
	
]

{ #category : #'change hook' }
ToAlbumModel >> editStateChanged [


]

{ #category : #accessing }
ToAlbumModel >> edited [

	^ edited ifNil: [ edited := false ]
]

{ #category : #accessing }
ToAlbumModel >> edited: aBoolean [

	edited = aBoolean ifTrue: [ ^ self ].
	edited := aBoolean
]

{ #category : #'view request' }
ToAlbumModel >> flash [

	self announce: (ToAlbumFlashRequested new client: self)
]

{ #category : #initialization }
ToAlbumModel >> initialize [

	self class initializeSlots: self.
	super initialize.

	" action when edit state change (Observable slot) "
	self whenEditedChangedDo: [ self editStateChanged ].
	self whenTextReplacedDo: [ self textReplaced ].
	self whenModeChangedDo: [ self modeChanged ]
]

{ #category : #accessing }
ToAlbumModel >> mode [

	^ mode

	
]

{ #category : #accessing }
ToAlbumModel >> mode: anEditabilityMode [

	mode = anEditabilityMode ifTrue: [ ^ self ].
	mode := anEditabilityMode.
	self widgetDo: [ :album | album mode: anEditabilityMode ]
]

{ #category : #'change hook' }
ToAlbumModel >> modeChanged [


]

{ #category : #'api - hooks' }
ToAlbumModel >> onInstalledOnlyMeIn: anAlbum [

	"Is sent when I am added to an element "

	super onInstalledOnlyMeIn: anAlbum.

	self mode: anAlbum mode.

	anAlbum whenTextReplacedDo: [ :t | self privateText: t ].
	anAlbum whenModeChangedDo: [ :m | self privateMode: m ].
	anAlbum onTextEditedDo: [ self textEdited ].
	
	self text: ''
]

{ #category : #'api - hooks' }
ToAlbumModel >> onUninstalledOnlyMeIn: anAlbum [

	"Is sent when I am added to an element "

	super onUninstalledOnlyMeIn: anAlbum.
	self unsubscribe: anAlbum innerElement.
	self styler ifNotNil: [ :styler | 
		self styler unsubscribe: self.
		self unsubscribe: styler ]
]

{ #category : #private }
ToAlbumModel >> privateMode: anEditabilityMode [

	mode = anEditabilityMode ifTrue: [ ^ self ].
	mode := anEditabilityMode
]

{ #category : #private }
ToAlbumModel >> privateText: aBlText [

	aBlText == self text ifTrue: [ ^ self ].
	self edited: false.
	text := aBlText.
	self announce: (ToAlbumTextReplaced new client: self; text: self text; yourself).
	" ask the stylerHolder to style through its observal slot"
	self requestTextStyle

]

{ #category : #'private - accessing - widget' }
ToAlbumModel >> privateWidgetClass [

	^ ToAlbum
]

{ #category : #'transaction hook' }
ToAlbumModel >> requestCancel [

	self announce: (ToAlbumCancelRequested new client: self)
]

{ #category : #'transaction hook' }
ToAlbumModel >> requestSave [

	self announce: (ToAlbumSaveRequested new
			 client: self;
			 unacceptedEdits: self edited ;
			 yourself)
]

{ #category : #'styler configuration' }
ToAlbumModel >> requestTextStyle [

	self announce: ToTextStyleRequested new
]

{ #category : #'transaction hook' }
ToAlbumModel >> saveResult: aBoolean [

	| announcement |
	self edited: aBoolean not.
	announcement := aBoolean
		                ifTrue: [ ToAlbumSaveAccepted new client: self ]
		                ifFalse: [ ToAlbumSaveDenied new client: self ].
	self announce: announcement
]

{ #category : #'styler configuration' }
ToAlbumModel >> styler [

	^ self userData at: #styler ifAbsent: [  ]
]

{ #category : #'styler configuration' }
ToAlbumModel >> styler: aBlStyler [

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
ToAlbumModel >> text [

	^ text

	
]

{ #category : #accessing }
ToAlbumModel >> text: aBlText [

	self text == aBlText ifTrue: [ ^ self ].
	self widgetDo: [ :album | album text: aBlText asRopedText]
]

{ #category : #'change hook' }
ToAlbumModel >> textEdited [

	self edited: true.
	self announce: (ToAlbumTextEdited new client: self; text: self text; yourself).
	" ask the stylerHolder to style through its observal slot"
	self requestTextStyle
]

{ #category : #'change hook' }
ToAlbumModel >> textReplaced [
]

{ #category : #'transaction hook' }
ToAlbumModel >> whenCancelRequestedDo: aBlock [

	self whenAnnouncement: ToAlbumCancelRequested do: aBlock
]

{ #category : #'property change hook' }
ToAlbumModel >> whenEditedChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #edited whenChangedDo: aBlock
]

{ #category : #'property change hook' }
ToAlbumModel >> whenModeChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #mode whenChangedDo: aBlock
]

{ #category : #'transaction hook' }
ToAlbumModel >> whenSaveAcceptedDo: aBlock [

	self whenAnnouncement: ToAlbumSaveAccepted do: aBlock
]

{ #category : #'transaction hook' }
ToAlbumModel >> whenSaveAcceptedSend: aSelector to: anObject [

	self whenAnnouncement: ToAlbumSaveAccepted send: aSelector to: anObject
]

{ #category : #'transaction hook' }
ToAlbumModel >> whenSaveDeniedDo: aBlock [

	self whenAnnouncement: ToAlbumSaveDenied do: aBlock
]

{ #category : #'transaction hook' }
ToAlbumModel >> whenSaveDeniedSend: aSelector to: anObject [

	self whenAnnouncement: ToAlbumSaveDenied send: aSelector to: anObject
]

{ #category : #'transaction hook' }
ToAlbumModel >> whenSaveRequestedDo: aBlock [

	self whenAnnouncement: ToAlbumSaveRequested do: aBlock
]

{ #category : #'transaction hook' }
ToAlbumModel >> whenSaveRequestedSend: aSelector to: anObject [

	self whenAnnouncement: ToAlbumSaveRequested send: aSelector to: anObject
]

{ #category : #'styler configuration' }
ToAlbumModel >> whenStylerStateChanged: aBlStylerStateChangedAnnouncement [

	self widgetDo: [ :album | self requestTextStyle ]
]

{ #category : #'styler configuration' }
ToAlbumModel >> whenStylerTextStyled: aBlStylerTextStyledAnnouncement [

	self widgetDo: [ :album | 
		| result |
		result := aBlStylerTextStyledAnnouncement styledText.
		" text just styled by the styler, check the generation (to be thread-safe) to ensure that 
			my text has not be changed elsewhere during the styling "
		(result isNextGenerationOf: self text) ifFalse: [ ^ self ].
		self text takeInternalRepresentationOf: result.
		album innerElement textInternalRepresentationChanged ]
]

{ #category : #'property change hook' }
ToAlbumModel >> whenTextReplacedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #text whenChangedDo: aBlock
]

{ #category : #'styler configuration' }
ToAlbumModel >> whenTextStyleRequested: aToTextStyleRequested [

	self widgetDo: [ :album | 
		self styler ifNotNil: [ 
			self styler announce: (BlStylerTextStyleRequested new
					 unstyledText: self text nextGeneration;
					 referentElement: album;
					 yourself) ] ]
]

{ #category : #'view configuration' }
ToAlbumModel >> withEditsFeedbackLayer [

	self widgetDo: [ :album | album withEditsFeedbackFrom: self. ]
]

{ #category : #'view configuration' }
ToAlbumModel >> withGhostText: aText [

	self widgetDo: [ :album | album withGhostText: aText from: self ]
]

{ #category : #'view configuration' }
ToAlbumModel >> withLineNumbers [

	self widgetDo: [ :album | album withLineNumbers ]
]

{ #category : #'view configuration' }
ToAlbumModel >> withSaveCapability [

	self withEditsFeedbackLayer.
	self widgetDo: [ :album | 
		album innerElement addEditorShortcut: (BlShortcutWithAction new
				 combination: BlKeyCombination primaryS;
				 action: [ :aShortcutEvent :aShortcut | self requestSave ];
				 name: 'Save';
				 description: 'Apply changes and save the source code (compile).').
		album innerElement addEditorShortcut: (BlShortcutWithAction new
				 combination: BlKeyCombination primaryL;
				 action: [ :aShortcutEvent :aShortcut | self requestCancel ];
				 name: 'Cancel';
				 description: 'Cancel changes and rollback the previous accepted source code.') ]
]

{ #category : #'view configuration' }
ToAlbumModel >> withoutEditsFeedbackLayer [

	self widgetDo: [ :album | album withoutEditsFeedback. ]
]

{ #category : #'view configuration' }
ToAlbumModel >> withoutGhostText [

	self widgetDo: [ :album | album withoutGhostText ]
]

{ #category : #'view configuration' }
ToAlbumModel >> withoutLineNumbers [

	self widgetDo: [ :album | album withoutLineNumbers ]
]
