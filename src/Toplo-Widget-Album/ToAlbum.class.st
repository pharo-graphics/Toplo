Class {
	#name : #ToAlbum,
	#superclass : #ToElement,
	#traits : 'TAlbInfiniteDecorator + TBlAnnouncerProvider + TToElementWithPlaceholder',
	#classTraits : 'TAlbInfiniteDecorator classTrait + TBlAnnouncerProvider classTrait + TToElementWithPlaceholder classTrait',
	#instVars : [
		'next',
		'edited',
		'autocompleteRule'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #layers }
ToAlbum >> addEditsFeedbackLayer [

	| layer |
	self editsFeedbackLayer ifNotNil: [ ^ self ].
	layer := ToAlbumEditsFeedbackLayer new.
	layer id: #editsFeedbackLayer.
	layer attachTo: self.
	self addChild: layer
]

{ #category : #initialization }
ToAlbum >> autocompleteRule [

	^ autocompleteRule 
]

{ #category : #initialization }
ToAlbum >> autocompleteRule: anAutocompleteRule [

	autocompleteRule := anAutocompleteRule
]

{ #category : #'styler configuration' }
ToAlbum >> codeFontName [ 

	^ self userData at: #codeFontName ifAbsentPut: [ self defaultCodeFontName  ]
]

{ #category : #'styler configuration' }
ToAlbum >> codeFontName: aFontName [

	^ self userData at: #codeFontName put: aFontName
]

{ #category : #initialization }
ToAlbum >> defaultCodeFontName [

	^ AeFontManager defaultCodeFontFamilyName
	
]

{ #category : #initialization }
ToAlbum >> defaultEditorElement [

	^ AlbEditorElement new
]

{ #category : #initialization }
ToAlbum >> defaultEventHandler [

	^ ToAlbumEventHandler new
]

{ #category : #initialization }
ToAlbum >> defaultStyler [

	^ nil 
]

{ #category : #accessing }
ToAlbum >> edited [

	^ edited ifNil: [ edited := false ]
]

{ #category : #accessing }
ToAlbum >> edited: aBoolean [

	edited = aBoolean ifTrue: [ ^ self ].
	edited := aBoolean
]

{ #category : #layers }
ToAlbum >> editsFeedbackLayer [

	^ self childWithId: #editsFeedbackLayer ifNone: []
]

{ #category : #'client - protocol' }
ToAlbum >> flash [

	self dispatchEvent: ToAlbumFlashRequestedEvent new
]

{ #category : #'focus requesting' }
ToAlbum >> focusHolder [

	^ self infinite focusHolder
]

{ #category : #initialization }
ToAlbum >> initialize [

	| sharedDistributor |
	super initialize.

	self next: self defaultEditorElement.
	self rootAlbumElement: self.
	self next primarySelectionElementClass: self primarySelectionElementClass.
	self addChild: self next.
	self matchParent.
	self addEventHandler: (self defaultEventHandler
	target: self;
	yourself).
	sharedDistributor := BlSharedEventDistributor new.
	sharedDistributor
		adjustMousePosition: false;
		shareEvents: {
				BlDragStartEvent.
				BlDragEvent.
				AlbTextDeletedEvent.
				AlbTextInsertedEvent.
				AlbTextEditedEvent.
				AlbTextReplacedEvent.
				BlFocusEvent.
				BlBlurEvent }.
	self addEventHandler: sharedDistributor.
	" for the focus events "
	self next addEventHandler: sharedDistributor.	
	self infinite addEventHandler: sharedDistributor.
	" for the styler "
	self editor addEventHandler: sharedDistributor
]

{ #category : #'t - element with placeholder' }
ToAlbum >> newPlaceholder [

	^ self placeholderClass new
		  padding: self padding;
		  yourself
]

{ #category : #skin }
ToAlbum >> newRawSkin [ 

	^ ToAlbumSkin new
]

{ #category : #'t - infinite editor accessing' }
ToAlbum >> next [

	^ next
]

{ #category : #'t - infinite editor accessing' }
ToAlbum >> next: aDecoratorOrInfinite [

	next := aDecoratorOrInfinite
]

{ #category : #'t - element with placeholder' }
ToAlbum >> placeholderClass [

	^ ToAlbumPlaceholder
]

{ #category : #initialization }
ToAlbum >> primarySelectionElementClass [

	^ ToAlbumPrimarySelectionElement 
]

{ #category : #layers }
ToAlbum >> removeEditsFeedbackLayer [

	| layer |
	layer := self editsFeedbackLayer ifNil: [ ^ self ].
	layer detach.
	self removeChild: layer
]

{ #category : #'transaction hook' }
ToAlbum >> requestCancel [

	self dispatchEvent:
		(ToAlbumCancelRequestedEvent new editorElement: self)
]

{ #category : #'transaction hook' }
ToAlbum >> requestSave [

	| request answer |
	request := ToAlbumSaveRequestedEvent new
		           editorElement: self;
		           unacceptedEdits: self edited;
		           yourself.

	self dispatchEvent: request.
	self edited: request accepted not.

	answer := request accepted
		          ifTrue: [ ToAlbumSaveAcceptedEvent new ]
		          ifFalse: [ ToAlbumSaveDeniedEvent new ].

	self dispatchEvent: (answer
			 editorElement: self;
			 yourself)
]

{ #category : #'styler configuration' }
ToAlbum >> requestTextStyle [

	self announce: ToTextStyleRequested new
]

{ #category : #'transaction hook' }
ToAlbum >> saveResult: aBoolean [

	| event |
	self deprecated:
		'Send #validated: to the event current target instead '.

	self edited: aBoolean not.
	event := aBoolean
		         ifTrue: [ ToAlbumSaveAcceptedEvent new ]
		         ifFalse: [ ToAlbumSaveDeniedEvent new ].
	self dispatchEvent: (event
			 editorElement: self;
			 yourself)
]

{ #category : #accessing }
ToAlbum >> styleTable: aStyleTable [

	self styler styleTable = aStyleTable ifTrue: [ ^ self ].
	self styler styleTable: aStyleTable.
	self styler announceStateChanged
]

{ #category : #'styler configuration' }
ToAlbum >> styler [

	^ self userData at: #styler ifAbsent: [  ]
]

{ #category : #'styler configuration' }
ToAlbum >> styler: aBlStyler [

	self styler ifNotNil: [ :styler |
		self styler unsubscribe: self.
		self unsubscribe: styler ].
	
	self removeStamp: #'code-editor'.
	self userData at: #styler put: aBlStyler.

	self styler ifNil: [ ^ self ].
	
	self addStamp: #'code-editor'.

	aBlStyler fontName: self codeFontName.
	aBlStyler
		whenAnnouncement: BlStylerStateChanged
		send: #whenStylerStateChanged:
		to: self.
	aBlStyler
		whenAnnouncement: BlStylerTextStyled
		send: #whenStylerTextStyled:
		to: self.
	self
		whenAnnouncement: ToTextStyleRequested
		send: #whenTextStyleRequested:
		to: self
]

{ #category : #accessing }
ToAlbum >> text: aBlText [

	aBlText == self text ifTrue: [ ^ self ].
	self next text: aBlText.
	self edited: false.
	self requestNewSkin 
]

{ #category : #'event handling' }
ToAlbum >> textChanged [

	self
		invalidate;
		requestLayout
]

{ #category : #'transaction hook' }
ToAlbum >> whenCancelRequestedDo: aBlock [

	^ self addEventHandlerOn: ToAlbumCancelRequestedEvent do: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenFlashRequestedDo: aBlock [

	^ self addEventHandlerOn: ToAlbumFlashRequestedEvent do: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveAcceptedDo: aBlock [

	^ self addEventHandlerOn: ToAlbumSaveAcceptedEvent do: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveDeniedDo: aBlock [

	^ self addEventHandlerOn: ToAlbumSaveDeniedEvent do: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveRequestedDo: aBlock [

	^ self addEventHandlerOn: ToAlbumSaveRequestedEvent do: aBlock
]

{ #category : #'styler configuration' }
ToAlbum >> whenStylerStateChanged: aBlStylerStateChangedAnnouncement [

	self requestTextStyle
]

{ #category : #'styler configuration' }
ToAlbum >> whenStylerTextStyled: aBlStylerTextStyledAnnouncement [

	| result |
	result := aBlStylerTextStyledAnnouncement styledText.
	" text just styled by the styler, check the generation (to be thread-safe) to ensure that 
			my text has not be changed elsewhere during the styling "
	(result isNextGenerationOf: self text) ifFalse: [ ^ self ].
	self text takeInternalRepresentationOf: result.
	self textInternalRepresentationChanged
]

{ #category : #'transaction hook' }
ToAlbum >> whenTextEditedDo: aBlock [

	^ self addEventHandlerOn: AlbTextEditedEvent do: aBlock
]

{ #category : #'styler configuration' }
ToAlbum >> whenTextStyleRequested: aToTextStyleRequested [

	self styler ifNotNil: [
		self styler announce: (BlStylerTextStyleRequested new
				 unstyledText: self text nextGeneration;
				 referentElement: self;
				 yourself) ]
]

{ #category : #layers }
ToAlbum >> withEditsFeedback: aBoolean [

	aBoolean
		ifTrue: [ self addEditsFeedbackLayer ]
		ifFalse: [ self removeEditsFeedbackLayer ]
]

{ #category : #initialization }
ToAlbum >> withSaveCapability [

	self addEditsFeedbackLayer.

	self addEditorShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination primaryS;
			 action: [ :aShortcutEvent :aShortcut | self requestSave ];
			 name: 'Save';
			 description: 'Apply changes and save the source code (compile).').
	self addEditorShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination primaryL;
			 action: [ :aShortcutEvent :aShortcut | self requestCancel ];
			 name: 'Cancel';
			 description: 'Cancel changes and rollback the previous accepted source code.')
]

{ #category : #initialization }
ToAlbum >> withoutLineWrapping [

	self infinite hFitContent.
	self next hFitContent
]
