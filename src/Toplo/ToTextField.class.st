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
ToTextField >> initialize [

	super initialize.
	self infinite vFitContent.
	self next vFitContent.
	self vFitContent.
	self withoutLineWrapping.
	self addEventHandler: (AlbTextEditorCursorIconHandler new element: self)

]

{ #category : #initialization }
ToTextField >> withLineWrapping [

	self next hMatchParent.
	self infinite hMatchParent
]

{ #category : #layers }
ToTextField >> withPlaceholderText: aText [

	self placeholderLayer: (ToTextFieldPlaceholder new text: aText)
]

{ #category : #initialization }
ToTextField >> withSaveCapability [

	super withSaveCapability.
	self addEditorShortcut: (BlShortcutWithAction new
			 combination: (BlKeyCombination return );
			 action: [ self requestSave ];
			 description: 'Accept edition';
			 name: 'Accept';
			 yourself).	
	self addEditorShortcut: (BlShortcutWithAction new
			 combination: (BlKeyCombination escape );
			 action: [ self requestCancel ];
			 description: 'Cancel edition';
			 name: 'Cancel';
			 yourself).
	
	
	
]

{ #category : #initialization }
ToTextField >> withoutLineWrapping [

	self infinite hFitContent.
	self next hFitContent
]
