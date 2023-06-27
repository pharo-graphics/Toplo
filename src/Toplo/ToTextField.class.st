Class {
	#name : #ToTextField,
	#superclass : #ToAlbum,
	#category : #'Toplo-Widget-TextField'
}

{ #category : #'t - accessing - dresser' }
ToTextField >> defaultDresser [

	^ ToTextFieldDresser new
	
]

{ #category : #initialization }
ToTextField >> defaultEditorElement [

	^ AlbTextFieldElement new
]

{ #category : #initialization }
ToTextField >> initialize [

	super initialize.
	self infinite vFitContent.
	self next vFitContent.
	self vFitContent.
	self withoutLineWrapping.
	self addEventHandler: (AlbTextEditorCursorIconHandler new element: self)

]

{ #category : #layers }
ToTextField >> placeholderText: aText [

	self placeholder: (ToTextFieldPlaceholder new text: aText).
	self text size isZero ifTrue: [ self showPlaceholder ]
]

{ #category : #'t - placeholder show/hide' }
ToTextField >> showPlaceholder [

	placeholderLayer ifNil: [ ^ self ].
	placeholderLayer parentDo: [ :p | ^ self ].
	placeholderLayer padding: (BlInsets left: self textLeft).
	super showPlaceholder
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
