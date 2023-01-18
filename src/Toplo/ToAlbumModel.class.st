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
	#category : #'Toplo-View Models'
}

{ #category : #'api - shortcuts' }
ToAlbumModel >> addEditorShortcut: aTextEditorInteraction [

	self widgetDo: [ :widget | widget addEditorShortcut: aTextEditorInteraction ]
]

{ #category : #'view configuration' }
ToAlbumModel >> beEditable [

	self widgetDo: [ :widget | widget beEditable ]
]

{ #category : #'view configuration' }
ToAlbumModel >> beReadonlyWithSelection [

	self widgetDo: [ :widget | widget beReadonlyWithSelection ]
]

{ #category : #'view configuration' }
ToAlbumModel >> beReadonlyWithoutSelection [

	self widgetDo: [ :widget | widget beReadonlyWithoutSelection ]
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
ToAlbumModel >> defaultStyler [

	^ nil 
]

{ #category : #'view request' }
ToAlbumModel >> flash [

	self widgetDo: [ :widget | widget flash ]
]

{ #category : #'api - install/uninstall  hook' }
ToAlbumModel >> onInstalledIn: anAlbum [

	"Is sent when I am added to an element "

	super onInstalledIn: anAlbum.
	anAlbum whenTextReplacedDo: [ :t | self requestTextStyle ].
	anAlbum whenTextEditedDo: [ :t | self requestTextStyle ].
	
	self text: ''
]

{ #category : #'api - install/uninstall  hook' }
ToAlbumModel >> onUninstalledIn: anAlbum [

	"Is sent when I am added to an element "

	super onUninstalledIn: anAlbum.
	self unsubscribe: anAlbum next.
	self styler ifNotNil: [ :styler | 
		self styler unsubscribe: self.
		self unsubscribe: styler ]
]

{ #category : #'private - accessing - widget' }
ToAlbumModel >> privateWidgetClass [

	^ ToAlbum
]

{ #category : #'api - shortcuts' }
ToAlbumModel >> removeEditorShortcut: aTextEditorInteraction [

	self widgetDo: [ :widget | widget removeEditorShortcut: aTextEditorInteraction ]
]

{ #category : #'transaction hook' }
ToAlbumModel >> requestCancel [

	self widgetDo: [ :widget | widget requestCancel ]
]

{ #category : #'transaction hook' }
ToAlbumModel >> requestSave [

	self widgetDo: [ :widget | widget requestSave ]
]

{ #category : #'styler configuration' }
ToAlbumModel >> requestTextStyle [

	self announce: ToTextStyleRequested new
]

{ #category : #'transaction hook' }
ToAlbumModel >> saveResult: aBoolean [

	self widgetDo: [ :widget | widget saveResult: aBoolean ]
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
ToAlbumModel >> text: aBlText [

	self widgetDo: [ :album | album text: aBlText asRopedText]
]

{ #category : #'transaction hook' }
ToAlbumModel >> whenCancelRequestedDo: aBlock [

	self widgetDo: [ :widget | widget whenCancelRequestedDo: aBlock ]
]

{ #category : #'property change hook' }
ToAlbumModel >> whenEditedChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self widgetDo: [ :widget | widget whenEditedChangedDo: aBlock ]
]

{ #category : #'property change hook' }
ToAlbumModel >> whenModeChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self widgetDo: [ :widget | widget whenModeChangedDo: aBlock ] 
]

{ #category : #'transaction hook' }
ToAlbumModel >> whenSaveAcceptedDo: aBlock [

	self widgetDo: [ :widget | widget whenSaveAcceptedDo: aBlock ]
]

{ #category : #'transaction hook' }
ToAlbumModel >> whenSaveAcceptedSend: aSelector to: anObject [

	self widgetDo: [ :widget | widget whenSaveAcceptedSend: aSelector to: anObject ]
]

{ #category : #'transaction hook' }
ToAlbumModel >> whenSaveDeniedDo: aBlock [

	self widgetDo: [ :widget | widget whenSaveDeniedDo: aBlock ]
]

{ #category : #'transaction hook' }
ToAlbumModel >> whenSaveDeniedSend: aSelector to: anObject [

	self widgetDo: [ :widget | widget whenSaveDeniedSend: aSelector to: anObject ]
]

{ #category : #'transaction hook' }
ToAlbumModel >> whenSaveRequestedDo: aBlock [

	self widgetDo: [ :widget | widget whenSaveRequestedDo: aBlock ]
]

{ #category : #'transaction hook' }
ToAlbumModel >> whenSaveRequestedSend: aSelector to: anObject [

	self widgetDo: [ :widget | widget whenSaveRequestedSend: aSelector to: anObject ]
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
		(result isNextGenerationOf: album text) ifFalse: [ ^ self ].
		album text takeInternalRepresentationOf: result.
		album textInternalRepresentationChanged ]
]

{ #category : #'property change hook' }
ToAlbumModel >> whenTextReplacedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self widgetDo: [ :widget | widget whenTextReplacedDo: aBlock ]
]

{ #category : #'styler configuration' }
ToAlbumModel >> whenTextStyleRequested: aToTextStyleRequested [

	self widgetDo: [ :album | 
		self styler ifNotNil: [ 
			self styler announce: (BlStylerTextStyleRequested new
					 unstyledText: album text nextGeneration;
					 referentElement: album;
					 yourself) ] ]
]

{ #category : #'view configuration' }
ToAlbumModel >> withEditsFeedbackLayer [

	self widgetDo: [ :album | album withEditsFeedbackLayer ]
]

{ #category : #'view configuration' }
ToAlbumModel >> withGhostText: aText [

	self widgetDo: [ :album | album withGhostText: aText ]
]

{ #category : #'view configuration' }
ToAlbumModel >> withRowNumbers [

	self widgetDo: [ :album | album withRowNumbers ]
]

{ #category : #'view configuration' }
ToAlbumModel >> withSaveCapability [

	self widgetDo: [ :widget |  widget withSaveCapability ]
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
ToAlbumModel >> withoutRowNumbers [

	self widgetDo: [ :album | album withoutRowNumbers ]
]
