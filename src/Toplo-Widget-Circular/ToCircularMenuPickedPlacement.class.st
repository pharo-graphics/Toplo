Class {
	#name : #ToCircularMenuPickedPlacement,
	#superclass : #ToElementCustomPlacement,
	#category : #'Toplo-Widget-Circular-Menu'
}

{ #category : #'api - displaying' }
ToCircularMenuPickedPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| theRoot theAnchor rootPosition localPosition |
	anEvent ifNil: [ ^ self ].
	theRoot := anElement anchorRoot.
	theAnchor := anElement anchorElement.
	anElement constraintsDo: [ :c | c ignoreByLayout ].
	localPosition := theAnchor globalPointToLocal: anEvent position.
	rootPosition := theAnchor localPointToGlobal: localPosition.
	rootPosition := theRoot globalPointToLocal: rootPosition.
	anElement position: rootPosition - (anElement measuredExtent / 2)
]
