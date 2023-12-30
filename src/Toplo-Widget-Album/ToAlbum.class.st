Class {
	#name : #ToAlbum,
	#superclass : #ToElement,
	#traits : 'TAlbInfiniteDecorator + TBlAnnouncerProvider + TToElementWithPlaceholder',
	#classTraits : 'TAlbInfiniteDecorator classTrait + TBlAnnouncerProvider classTrait + TToElementWithPlaceholder classTrait',
	#instVars : [
		'next',
		'editsFeedbackLayer',
		'edited'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'styler configuration' }
ToAlbum >> codeFontName [ 

	^ self userData at: #codeFontName ifAbsentPut: [ self defaultCodeFontName  ]
]

{ #category : #'styler configuration' }
ToAlbum >> codeFontName: aFontName [

	^ self userData at: #codeFontName put: aFontName
]

{ #category : #initialization }
ToAlbum >> defaultBackground [

	^ Color white
]

{ #category : #initialization }
ToAlbum >> defaultBlurBorder [

	^ BlBorder
			 paint: self defaultBorderColor
			 width: self defaultBorderWidth
]

{ #category : #initialization }
ToAlbum >> defaultBorder [

	^ BlBorder
		  paint: self theme editor borderColor
		  width: self defaultBorderWidth
]

{ #category : #initialization }
ToAlbum >> defaultBorderColor [ 

	^ self theme editor borderColor
]

{ #category : #initialization }
ToAlbum >> defaultBorderWidth [ 

	^ 1
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

	^ ToAlbumEventHandler new.

]

{ #category : #initialization }
ToAlbum >> defaultFocusBorder [

	^ BlBorder
			 paint: self defaultFocusBorderColor
			 width: self defaultBorderWidth
]

{ #category : #initialization }
ToAlbum >> defaultFocusBorderColor [

	^ self theme editor focusedBorderColor
]

{ #category : #initialization }
ToAlbum >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: 8
]

{ #category : #initialization }
ToAlbum >> defaultMargin [

	"setup to not depend on parent layout"
	^ BlInsets all: 0
]

{ #category : #initialization }
ToAlbum >> defaultOutskirts [

	^ BlOutskirts inside
]

{ #category : #initialization }
ToAlbum >> defaultPadding [

	^ BlInsets all: 3
		 " top: (6 + self defaultBorderWidth )
		  left: (3 + self defaultBorderWidth )
		  bottom: (2 + self defaultBorderWidth )
		  right: (3 + self defaultBorderWidth )"
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

{ #category : #'client - protocol' }
ToAlbum >> flash [

	self dispatchEvent: (ToAlbumFlashRequestedEvent new client: self)
]

{ #category : #initialization }
ToAlbum >> initialize [

	| sharedDistributor |
	super initialize.

	self next: self defaultEditorElement.
	self addChild: self next.

	self matchParent.

	self addEventHandler: self defaultEventHandler.
	self addEventHandler: (AlbTextEditorFocusHandler new element: self).

	sharedDistributor := BlSharedEventDistributor new.
	sharedDistributor
		adjustMousePosition: false;
		shareEvents: {
				AlbTextEditedEvent.
				AlbTextReplacedEvent.
				BlMouseDownEvent.
				BlDragEvent.
				BlDragStartEvent.
				BlDragEndEvent.
				BlDragEnterEvent.
				BlDragLeaveEvent.
				BlMouseEnterEvent.
				BlMouseLeaveEvent.
				BlMouseOverEvent.
				BlDoubleClickEvent.
				BlFocusEvent.
				BlBlurEvent }.
	self addEventHandler: sharedDistributor.
	self infinite addEventHandler: sharedDistributor.
	self editor addEventHandler: sharedDistributor.

	self geometry: self defaultGeometry.
	self outskirts: self defaultOutskirts.
	self margin: self defaultMargin.
	self padding: self defaultPadding.
	self border: self defaultBorder.
	self background: self defaultBackground.
	self addEventHandler: (AlbTextEditorFocusHandler new element: self).
	self addEventHandler:	(AlbTextEditorCursorIconHandler new element: self)
	"self addEventHandler:	(AlbTextEditorSelectionHandler new element: self infinite)"
]

{ #category : #'t - element with placeholder' }
ToAlbum >> newPlaceholder [

	^ self placeholderClass new
		  padding: self padding;
		  yourself
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

{ #category : #'transaction hook' }
ToAlbum >> requestCancel [

	self dispatchEvent: (ToAlbumCancelRequestedEvent new client: self)
]

{ #category : #'transaction hook' }
ToAlbum >> requestSave [

	self dispatchEvent: (ToAlbumSaveRequestedEvent new
			 client: self;
			 unacceptedEdits: self edited ;
			 yourself)
]

{ #category : #'styler configuration' }
ToAlbum >> requestTextStyle [

	self announce: ToTextStyleRequested new
]

{ #category : #'transaction hook' }
ToAlbum >> saveResult: aBoolean [

	| event |
	self edited: aBoolean not.
	event := aBoolean
		                ifTrue: [ ToAlbumSaveAcceptedEvent new client: self ]
		                ifFalse: [ ToAlbumSaveDeniedEvent new client: self ].
	self dispatchEvent: event
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

	self userData at: #styler put: aBlStyler.

	self styler ifNil: [ ^ self ].

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
	self edited: false
]

{ #category : #'transaction hook' }
ToAlbum >> whenCancelRequestedDo: aBlock [

	self addEventHandler: (BlEventHandler
			 on: ToAlbumCancelRequestedEvent
			 do: aBlock)
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveAcceptedDo: aBlock [

	self when: ToAlbumSaveAcceptedEvent do: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveDeniedDo: aBlock [

	self when: ToAlbumSaveDeniedEvent do: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveRequestedDo: aBlock [

	self addEventHandler: (BlEventHandler
			 on: ToAlbumSaveRequestedEvent
			 do: aBlock)
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

{ #category : #'styler configuration' }
ToAlbum >> whenTextStyleRequested: aToTextStyleRequested [

	self styler ifNotNil: [
		self styler announce: (BlStylerTextStyleRequested new
				 unstyledText: self text nextGeneration;
				 referentElement: self;
				 yourself) ]
]

{ #category : #layers }
ToAlbum >> withEditsFeedback [

	editsFeedbackLayer ifNotNil: [ ^ self ].
	editsFeedbackLayer := ToAlbumEditsFeedbackLayer new.
	editsFeedbackLayer attachTo: self.
	self addChild: editsFeedbackLayer
]

{ #category : #initialization }
ToAlbum >> withSaveCapability [

	self withEditsFeedback.

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

{ #category : #layers }
ToAlbum >> withoutEditsFeedback [

	editsFeedbackLayer ifNil: [ ^ self ].

	editsFeedbackLayer detach.
	self removeChild: editsFeedbackLayer.

	editsFeedbackLayer := nil
]

{ #category : #layers }
ToAlbum >> withoutPlaceholder [ 

	self hidePlaceholder 
]
