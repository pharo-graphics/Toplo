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
	self innerElement vFitContent.
	self vFitContent.
	self withoutLineWrapping.
	self addEditorShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination return;
			 action: [  ];
			 description: 'Accept edition';
			 name: 'Accept';
			 yourself)
]

{ #category : #'api-layers' }
ToTextField >> layerReferentElement [

	^ self
]

{ #category : #layers }
ToTextField >> withGhostText: aText [

	ghostTextLayer ifNotNil: [ ^ self ].
	ghostTextLayer := ToTextFieldGhostTextLayer new text: aText.
	self addLayer: ghostTextLayer
]

{ #category : #initialization }
ToTextField >> withLineWrapping [

	self innerElement hMatchParent.

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

	self innerElement hFitContent

]
