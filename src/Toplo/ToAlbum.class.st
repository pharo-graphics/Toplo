Class {
	#name : #ToAlbum,
	#superclass : #ToWidget,
	#traits : 'TOBlLayoutResizable + TToWidgetWithLayers',
	#classTraits : 'TOBlLayoutResizable classTrait + TToWidgetWithLayers classTrait',
	#instVars : [
		'#editsFeedbackLayer',
		'#ghostTextLayer',
		'#innerElement',
		'#edited => ObservableSlot'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #'api - shortcuts' }
ToAlbum >> addEditorShortcut: aTextEditorInteraction [
	self innerElement addEditorShortcut: aTextEditorInteraction
]

{ #category : #'view configuration' }
ToAlbum >> beEditable [

	self innerElement beEditable
]

{ #category : #'view configuration' }
ToAlbum >> beReadonlyWithSelection [

	self innerElement beReadonlyWithSelection
]

{ #category : #'view configuration' }
ToAlbum >> beReadonlyWithoutSelection [

	self innerElement beReadonlyWithoutSelection
]

{ #category : #initialization }
ToAlbum >> defaultDresser [

	^ ToAlbumBasicDresser new
	
]

{ #category : #initialization }
ToAlbum >> defaultEditorElement [

	^ AlbEditorElement new
]

{ #category : #initialization }
ToAlbum >> defaultViewModel [

	^ ToAlbumModel new
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

	self announce: (ToAlbumFlashRequested new client: self)
]

{ #category : #initialization }
ToAlbum >> initialize [

	super initialize.
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	self innerElement: self defaultEditorElement.
	self innerElement whenAnnouncement: AlbTextEdited do: [ self edited: true ].
]

{ #category : #accessing }
ToAlbum >> innerElement [

	^ innerElement
]

{ #category : #accessing }
ToAlbum >> innerElement: anEditorElement [
	innerElement ifNotNil: [ 
		innerElement removeFromParent ].
	innerElement := anEditorElement.
	self addChild: anEditorElement
]

{ #category : #'api-layers' }
ToAlbum >> layerReferentElement [

		^ self innerElement 
]

{ #category : #accessing }
ToAlbum >> mode [

	^ self innerElement mode
]

{ #category : #accessing }
ToAlbum >> mode: anEditabilityMode [

	self innerElement mode: anEditabilityMode 
]

{ #category : #'api - shortcuts' }
ToAlbum >> removeEditorShortcut: aTextEditorShortcut [

	self innerElement removeEditorShortcut: aTextEditorShortcut
]

{ #category : #'transaction hook' }
ToAlbum >> requestCancel [

	self announce: (ToAlbumCancelRequested new client: self)
]

{ #category : #'transaction hook' }
ToAlbum >> requestSave [

	self announce: (ToAlbumSaveRequested new
			 client: self;
			 unacceptedEdits: self edited ;
			 yourself)
]

{ #category : #'transaction hook' }
ToAlbum >> saveResult: aBoolean [

	| announcement |
	self edited: aBoolean not.
	announcement := aBoolean
		                ifTrue: [ ToAlbumSaveAccepted new client: self ]
		                ifFalse: [ ToAlbumSaveDenied new client: self ].
	self announce: announcement
]

{ #category : #accessing }
ToAlbum >> selectionColor [

	^ self innerElement selectionColor
]

{ #category : #accessing }
ToAlbum >> text [

	^ self innerElement text
]

{ #category : #accessing }
ToAlbum >> text: aBlText [

	aBlText == self text ifTrue: [ ^ self ].
	self edited: false.
	self innerElement text: aBlText.
	self announce: (ToAlbumTextReplaced new client: self; text: self text; yourself)
]

{ #category : #'transaction hook' }
ToAlbum >> whenCancelRequestedDo: aBlock [

	self whenAnnouncement: ToAlbumCancelRequested do: aBlock
]

{ #category : #'property change hook' }
ToAlbum >> whenEditedChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #edited whenChangedDo: aBlock
]

{ #category : #'property change hook' }
ToAlbum >> whenModeChangedDo: aBlock [

	innerElement whenModeChangedDo: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveAcceptedDo: aBlock [

	self whenAnnouncement: ToAlbumSaveAccepted do: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveAcceptedSend: aSelector to: anObject [

	self whenAnnouncement: ToAlbumSaveAccepted send: aSelector to: anObject
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveDeniedDo: aBlock [

	self whenAnnouncement: ToAlbumSaveDenied do: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveDeniedSend: aSelector to: anObject [

	self whenAnnouncement: ToAlbumSaveDenied send: aSelector to: anObject
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveRequestedDo: aBlock [

	self whenAnnouncement: ToAlbumSaveRequested do: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveRequestedSend: aSelector to: anObject [

	self whenAnnouncement: ToAlbumSaveRequested send: aSelector to: anObject
]

{ #category : #'transaction hook' }
ToAlbum >> whenTextEditedDo: aBlock [

	self innerElement whenTextEditedDo: aBlock
]

{ #category : #'property change hook' }
ToAlbum >> whenTextReplacedDo: aBlock [

	innerElement 
		whenTextReplacedDo: [ :announcement | aBlock cull: announcement text cull: announcement ]
]

{ #category : #layers }
ToAlbum >> withEditsFeedbackLayer [

	editsFeedbackLayer ifNotNil: [ ^ self ].
	editsFeedbackLayer := ToAlbumEditsFeedbackLayer new.
	self addLayer: editsFeedbackLayer 
]

{ #category : #layers }
ToAlbum >> withGhostText: aText [

	ghostTextLayer ifNotNil: [ ^ self ].
	ghostTextLayer := ToAlbumGhostTextLayer new text: aText.
	self addLayer: ghostTextLayer
]

{ #category : #initialization }
ToAlbum >> withLineNumbers [

	self innerElement withLineNumbers
]

{ #category : #initialization }
ToAlbum >> withSaveCapability [

	self withEditsFeedbackLayer.

	self innerElement addEditorShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination primaryS;
			 action: [ :aShortcutEvent :aShortcut | self requestSave ];
			 name: 'Save';
			 description: 'Apply changes and save the source code (compile).').
	self innerElement addEditorShortcut: (BlShortcutWithAction new
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
ToAlbum >> withoutGhostText [ 

	ghostTextLayer ifNil: [ ^ self ].
	self removeLayer: ghostTextLayer.
	ghostTextLayer := nil
]

{ #category : #initialization }
ToAlbum >> withoutLineNumbers [

	self innerElement withoutLineNumbers
]
