Class {
	#name : #ToTabGroupElementConfiguration,
	#superclass : #ToTripletElementConfiguration,
	#instVars : [
		'atStartSide'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #hook }
ToTabGroupElementConfiguration >> applyOn: aTabGroupElement [

	super applyOn: aTabGroupElement.
	aTabGroupElement checkAddNewTabItemButton.

	aTabGroupElement itemBar horizontal: aTabGroupElement isHorizontal.
	aTabGroupElement itemBar atStartSide: atStartSide.

	aTabGroupElement uniformNodeWidth: aTabGroupElement isVertical.
	aTabGroupElement uniformNodeHeight: aTabGroupElement isHorizontal.
	aTabGroupElement itemBar autoDistribute:
		aTabGroupElement autoDistribute.
	aTabGroupElement itemBar matchParent.

	aTabGroupElement isHFitContent
		ifTrue: [
			aTabGroupElement middleContainer constraintsDo: [ :c |
				c horizontal fitContent ].
			aTabGroupElement itemBar hFitContent ]
		ifFalse: [
			aTabGroupElement middleContainer constraintsDo: [ :c |
				c horizontal matchParent ].
			aTabGroupElement itemBar hMatchParent ].

	aTabGroupElement isVFitContent
		ifTrue: [
			aTabGroupElement middleContainer constraintsDo: [ :c |
				c vertical fitContent ].
			aTabGroupElement itemBar vFitContent ]
		ifFalse: [
			aTabGroupElement middleContainer constraintsDo: [ :c |
				c vertical matchParent ].
			aTabGroupElement itemBar vMatchParent ].

	aTabGroupElement isHorizontal
		ifTrue: [ aTabGroupElement endElement layout beHorizontal ]
		ifFalse: [ aTabGroupElement endElement layout beVertical ].

	aTabGroupElement itemBar refreshAllSelections.

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
	atStartSide := true.

]
