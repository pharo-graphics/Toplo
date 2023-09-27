Class {
	#name : #ToAlbum,
	#superclass : #ToPane,
	#traits : 'TToWidget + TToEnableable + TAlbInfiniteDecorator + TToWidgetWithViewModel + TToWidgetWithTooltip + TToWidgetWithContextMenu + TToWidgetWithLayers + TToWidgetWithPlaceholder',
	#classTraits : 'TToWidget classTrait + TToEnableable classTrait + TAlbInfiniteDecorator classTrait + TToWidgetWithViewModel classTrait + TToWidgetWithTooltip classTrait + TToWidgetWithContextMenu classTrait + TToWidgetWithLayers classTrait + TToWidgetWithPlaceholder classTrait',
	#instVars : [
		'#editsFeedbackLayer',
		'#innerElement',
		'#edited => ObservableSlot'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #initialization }
ToAlbum >> defaultBackground [

	^ Color white
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
	^ BlInsets all: 1
]

{ #category : #initialization }
ToAlbum >> defaultOutskirts [

	^ BlOutskirts inside
]

{ #category : #initialization }
ToAlbum >> defaultPadding [

	^ BlInsets
		  top: (6 + self defaultBorderWidth )
		  left: (3 + self defaultBorderWidth )
		  bottom: (2 + self defaultBorderWidth )
		  right: (3 + self defaultBorderWidth )
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

	super initialize.
	self matchParent.
	
	self editorDo: [ :ed |
		ed when: AlbTextEditedEvent do: [ :evt | self dispatchEvent: evt ].
		ed when: AlbTextReplacedEvent do: [ :evt | self dispatchEvent: evt ] ].
	self infiniteDo: [ :inf |
		inf when: BlBlurEvent do: [ :evt | self dispatchEvent: evt ].
		inf when: BlFocusEvent do: [ :evt | self dispatchEvent: evt ] ].
	self addEventHandler: self defaultEventHandler.

	self next geometry: self defaultGeometry.
	self next outskirts: self defaultOutskirts.
	self next margin: self defaultMargin.
	self next padding: self defaultPadding.
	self next border: self defaultBorder.
	self background: self defaultBackground 

]

{ #category : #accessing }
ToAlbum >> innerElement [

	^ self next
]

{ #category : #'t - widget with layers - accessing' }
ToAlbum >> layerReferentElement [

		^ self 
]

{ #category : #layers }
ToAlbum >> placeholderText: aText [

	self placeholder: (ToAlbumPlaceholder new text: aText).
	self text size isZero ifTrue: [ self showPlaceholder ]
]

{ #category : #'t - initialization dresser' }
ToAlbum >> preInitializeDresser [ 

	super preInitializeDresser.

	self next: self defaultEditorElement.
	self addChild: self next.

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

{ #category : #'transaction hook' }
ToAlbum >> saveResult: aBoolean [

	| event |
	self edited: aBoolean not.
	event := aBoolean
		                ifTrue: [ ToAlbumSaveAcceptedEvent new client: self ]
		                ifFalse: [ ToAlbumSaveDeniedEvent new client: self ].
	self dispatchEvent: event
]

{ #category : #accessing }
ToAlbum >> text: aBlText [

	aBlText == self text ifTrue: [ ^ self ].
	self next text: aBlText.
	self edited: false
]

{ #category : #'transaction hook' }
ToAlbum >> whenCancelRequestedDo: aBlock [

	self when: ToAlbumCancelRequestedEvent do: aBlock
]

{ #category : #'property change hook' }
ToAlbum >> whenEditedChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #edited whenChangedDo: aBlock
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

	self when: ToAlbumSaveRequestedEvent do: aBlock
]

{ #category : #layers }
ToAlbum >> withEditsFeedback [

	editsFeedbackLayer ifNotNil: [ ^ self ].
	editsFeedbackLayer := ToAlbumEditsFeedbackLayer new.
	self addLayer: editsFeedbackLayer 
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
	self removeLayer: editsFeedbackLayer.
	editsFeedbackLayer := nil
]

{ #category : #layers }
ToAlbum >> withoutPlaceholder [ 

	self hidePlaceholder 
]
