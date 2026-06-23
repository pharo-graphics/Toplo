Class {
	#name : #ToTextField,
	#superclass : #ToAlbum,
	#instVars : [
		'wrappingMode'
	],
	#category : #'Toplo-Widget-Album-TextField'
}

{ #category : #'instance creation' }
ToTextField class >> newForSieve: aSieve [ 

	| textField |
	textField := self new.
	textField whenTextEditedDo: [
			| pattern |
			pattern := textField text asString.
			aSieve pattern: pattern ].
	^ textField
]

{ #category : #'instance creation' }
ToTextField class >> text: aText [

	^ self new text: aText
]

{ #category : #configuration }
ToTextField >> applyConfiguration [

	super applyConfiguration.
	self infinite vFitContent.
	self albumEditorElement
		vFitContent;
		hMatchParent.
	self albumEditorElement next
		vFitContent;
		hMatchParent.
	self vFitContent.
	self albumEditorElement constraintsDo: [ :c |
			c linear vertical alignCenter.
			c frame vertical alignCenter ].
	wrappingMode
		ifTrue: [
				self albumEditorElement next hMatchParent.
				self infinite hMatchParent ]
		ifFalse: [
				self albumEditorElement next hFitContent.
				self infinite hFitContent ]
]

{ #category : #initialization }
ToTextField >> defaultEditorElement [

	^ AlbTextFieldElement new
]

{ #category : #initialization }
ToTextField >> initialize [

	super initialize.
	wrappingMode := false
]

{ #category : #'t - element with placeholder' }
ToTextField >> placeholderClass [

	^ ToTextFieldPlaceholder
]

{ #category : #initialization }
ToTextField >> withLineWrapping [

	self
		deprecated: 'Use #wrappingMode: true '
		transformWith:
		'`@rcvr withLineWrapping' -> '`@rcvr wrappingMode: true'.
	self wrappingMode: true
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

	self
		deprecated: 'Use #wrappingMode: false '
		transformWith:
		'`@rcvr withoutLineWrapping' -> '`@rcvr wrappingMode: false'.
	self wrappingMode: false
]

{ #category : #accessing }
ToTextField >> wrappingMode [

	^ wrappingMode
]

{ #category : #accessing }
ToTextField >> wrappingMode: aBoolean [

	wrappingMode = aBoolean ifTrue: [ ^ self ].
	wrappingMode := aBoolean.
	self requestConfiguration
]
