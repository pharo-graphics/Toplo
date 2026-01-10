Class {
	#name : #ToTabGroupElementConfiguration,
	#superclass : #ToTripletContainerConfiguration,
	#instVars : [
		'atStartSide'
	],
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #hook }
ToTabGroupElementConfiguration >> applyOn: aTabGroupElement [

	super applyOn: aTabGroupElement.

	aTabGroupElement itemList horizontal: aTabGroupElement isHorizontal.

	aTabGroupElement checkAddTabButton.
	aTabGroupElement itemList atStartSide: atStartSide.

	aTabGroupElement itemList constraintsDo: [ :c |
			c horizontal resizer:
				aTabGroupElement constraints horizontal resizer copy.
			c vertical resizer:
				aTabGroupElement constraints vertical resizer copy ].

	aTabGroupElement endContainer layout beHorizontal:
		aTabGroupElement isHorizontal.
	aTabGroupElement endContainer childrenDo: [ :child |
		child layout beHorizontal: aTabGroupElement isHorizontal ].

	aTabGroupElement itemList requestUpdateAllSelections.

	aTabGroupElement requestNewSkin.
	aTabGroupElement invisibleNodesMenu requestNewSkin
]

{ #category : #accessing }
ToTabGroupElementConfiguration >> atStartSide [

	^ atStartSide
]

{ #category : #accessing }
ToTabGroupElementConfiguration >> atStartSide: aBoolean [

	atStartSide := aBoolean
]

{ #category : #initialization }
ToTabGroupElementConfiguration >> initialize [

	super initialize.
	self class initializeSlots: self.
	atStartSide := true.

]
