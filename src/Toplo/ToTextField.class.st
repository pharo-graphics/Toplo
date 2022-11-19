Class {
	#name : #ToTextField,
	#superclass : #ToAlbum,
	#category : #'Toplo-Widget-Album'
}

{ #category : #initialization }
ToTextField >> initialize [

	super initialize.
	self innerElement vFitContent.
	self hMatchParent.
	self vFitContent.
	self innerElement hFitContent.
	self border: (BlBorder paint: Color black width: 1).
	self addEditorShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination return;
			 action: [  ];
			 description: 'Accept edition';
			 name: 'Accept';
			 yourself)
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
