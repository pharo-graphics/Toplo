Class {
	#name : 'ToTextField',
	#superclass : 'ToAlbum',
	#category : 'Toplo-Widget-Album-TextField',
	#package : 'Toplo-Widget-Album',
	#tag : 'TextField'
}

{ #category : 'initialization' }
ToTextField >> defaultEditorElement [

	^ AlbTextFieldElement new
]

{ #category : 'initialization' }
ToTextField >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: 4
]

{ #category : 'initialization' }
ToTextField >> defaultPadding [

	^ BlInsets
		  top: (3 + self defaultBorderWidth )
		  left: (3 + self defaultBorderWidth)
		  bottom: (0 + self defaultBorderWidth )
		  right: (3 + self defaultBorderWidth )
]

{ #category : 'initialization' }
ToTextField >> initialize [

	super initialize.
	self infinite vFitContent.
	self next vFitContent.
	self vFitContent.
	self withoutLineWrapping.
	self flag: 'Why these handlers ? ( ToAlbum do not have them )'.
	self addEventHandler: (AlbTextEditorCursorIconHandler new element: self).
	self addEventHandler: (AlbTextEditorSelectionHandler new element: self infinite).
	self addEventHandler: (AlbTextEditorDoubleClickHandler new element: self infinite)
]

{ #category : 'layers' }
ToTextField >> placeholderText: aText [

	self placeholder: (ToTextFieldPlaceholder new text: aText).
	self text size isZero ifTrue: [ self showPlaceholder ]
]

{ #category : 't - element with placeholder' }
ToTextField >> showPlaceholder [

	self placeholderLayer ifNil: [ ^ self ].
	self placeholderLayer parentDo: [ :p | ^ self ].
	self placeholderLayer padding: (BlInsets left: self textLeft).
	super showPlaceholder
]

{ #category : 'initialization' }
ToTextField >> withLineWrapping [

	self next hMatchParent.
	self infinite hMatchParent
]

{ #category : 'initialization' }
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

{ #category : 'initialization' }
ToTextField >> withoutLineBreak [

	self inputFilter: AlbTextEditorNoLineBreakInputFilter new
]

{ #category : 'initialization' }
ToTextField >> withoutLineWrapping [

	self infinite hFitContent.
	self next hFitContent
]
