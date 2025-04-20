Class {
	#name : #ToTabNodeConfiguration,
	#superclass : #ToBarNodeConfiguration,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #hook }
ToTabNodeConfiguration >> applyOn: aTabNode [

	super applyOn: aTabNode.
	aTabNode removeRemoveButton.
	aTabNode isRemovable
		ifTrue: [ aTabNode addRemoveButton ].
	aTabNode requestNewSkin 
]
