Class {
	#name : #ToPickedPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #'api - displaying' }
ToPickedPlacement >> positionWindow: aWindow onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| theRoot element |
	anEvent ifNil: [ ^ self ].
	theRoot := aWindow anchorRoot.
	element := aWindow element.
	"gap ifNil: [  
	positionInRoot := theRoot globalPointToLocal: anEvent position.
	elementPositionInRoot := theRoot localPointToMine: element position position fromChild: element.
	gap := elementPositionInRoot - positionInRoot].
	newPosition := theRoot element position + gap"
	aWindow position: (theRoot globalPointToLocal: anEvent position)
]
