Class {
	#name : #ToAnchoredPickedPlacement,
	#superclass : #ToElementCustomPlacement,
	#category : #'Toplo-Core-Support'
}

{ #category : #'api - displaying' }
ToAnchoredPickedPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| theRoot theAnchor rootPosition localPosition |
	anEvent ifNil: [ ^ self ].
	theRoot := anElement anchorRoot.
	theAnchor := anElement anchorElement.
	localPosition := theAnchor globalPointToLocal: anEvent position.
	rootPosition := theAnchor localPointToGlobal: localPosition.
	rootPosition := theRoot globalPointToLocal: rootPosition.
	anElement position: rootPosition
]
