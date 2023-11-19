Class {
	#name : #ToTextField,
	#superclass : #ToAlbum,
	#category : 'Toplo-Widget-Album-TextField'
}

{ #category : #initialization }
ToTextField >> defaultEditorElement [

	^ AlbTextFieldElement new
]

{ #category : #initialization }
ToTextField >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: 4
]

{ #category : #initialization }
ToTextField >> initialize [

	| sharedDistributor |
	super initialize.
	self infinite vFitContent.
	self next vFitContent.
	self vFitContent.
	self withoutLineWrapping.
	self addEventHandler: (AlbTextEditorFocusHandler new element: self).
	"self addEventHandler:	(AlbTextEditorCursorIconHandler new element: self)."
	self addEventHandler:	(AlbTextEditorSelectionHandler new element: self infinite).
	self addEventHandler:	(AlbTextEditorDoubleClickHandler new element: self infinite).

	sharedDistributor := BlSharedEventDistributor new.
	sharedDistributor
		adjustMousePosition: false;
		shareEvents: {
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
	"self next addEventHandler: sharedDistributor."
	self infinite addEventHandler: sharedDistributor.

]

{ #category : #'t - element with placeholder' }
ToTextField >> placeholderClass [

	^ ToTextFieldPlaceholder
]

{ #category : #initialization }
ToTextField >> withLineWrapping [

	self next hMatchParent.
	self infinite hMatchParent
]

{ #category : #initialization }
ToTextField >> withSaveCapability [

	super withSaveCapability.
	self addEditorShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination return;
			 action: [ self requestSave ];
			 description: 'Accept edition';
			 name: 'Accept';
			 yourself).
	self addEditorShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination escape;
			 action: [ self requestCancel ];
			 description: 'Cancel edition';
			 name: 'Cancel';
			 yourself)
]

{ #category : #initialization }
ToTextField >> withoutLineBreak [

	self inputFilter: AlbTextEditorNoLineBreakInputFilter new
]

{ #category : #initialization }
ToTextField >> withoutLineWrapping [

	self infinite hFitContent.
	self next hFitContent
]
