Class {
	#name : #ToTabItemElementConfiguration,
	#superclass : #ToTripletElementConfiguration,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #hook }
ToTabItemElementConfiguration >> applyOn: aTabItemElement [

	super applyOn: aTabItemElement.
	aTabItemElement removeRemoveButton.
	aTabItemElement isRemovable
		ifTrue: [ aTabItemElement addRemoveButton ].
	aTabItemElement requestNewSkin 
]
