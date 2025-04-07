Class {
	#name : #ToTabItemElementConfiguration,
	#superclass : #ToTripletElementConfiguration,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #hook }
ToTabItemElementConfiguration >> applyOn: aTabItemElement [

	super applyOn: aTabItemElement.
	aTabItemElement isRemovable
		ifTrue: [ aTabItemElement addRemoveButton ]
		ifFalse: [ aTabItemElement removeRemoveButton ].
	aTabItemElement requestNewSkin 
]
