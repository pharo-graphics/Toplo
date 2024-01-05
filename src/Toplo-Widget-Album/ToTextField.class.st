Class {
	#name : #ToTextField,
	#superclass : #ToAlbum,
	#category : #'Toplo-Widget-Album-TextField'
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

	super initialize.
	self infinite vFitContent.
	self next vFitContent.
	self vFitContent.
	self withoutLineWrapping
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
