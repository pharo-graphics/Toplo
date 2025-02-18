Class {
	#name : #ToPickedPlacement,
	#superclass : #ToElementPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #'api - displaying' }
ToPickedPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| theRoot element |
	anEvent ifNil: [ ^ self ].
	theRoot := anElement anchorRoot.
	element := anElement anchorElement.
	"gap ifNil: [  
	positionInRoot := theRoot globalPointToLocal: anEvent position.
	elementPositionInRoot := theRoot localPointToMine: element position position fromChild: element.
	gap := elementPositionInRoot - positionInRoot].
	newPosition := theRoot element position + gap"
	anElement position: (theRoot globalPointToLocal: anEvent position)
]
