Class {
	#name : #ToAnchoredPickedPlacement,
	#superclass : #ToElementCustomPlacement,
	#category : #'Toplo-Core-Support'
}

{ #category : #'api - displaying' }
ToAnchoredPickedPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| theRoot theAnchor |
	anEvent ifNil: [ ^ self ].
	theRoot := anElement anchorRoot.
	theAnchor := anElement anchorElement.
	"gap ifNil: [  
	positionInRoot := theRoot globalPointToLocal: anEvent position.
	elementPositionInRoot := theRoot localPointToMine: element position position fromChild: element.
	gap := elementPositionInRoot - positionInRoot].
	newPosition := theRoot element position + gap"
	anElement position: (theRoot globalPointToLocal: anEvent position)
]
