Class {
	#name : #ToRawSkinTabBarSelectionPlacement,
	#superclass : #ToElementCustomPlacement,
	#instVars : [
		'tabBar'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'api - displaying' }
ToRawSkinTabBarSelectionPlacement >> positionElement: aSelectionElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| track pos node nodeBounds trackBounds |
	" compute the selection element to be over the parent track element "
	node := aSelectionElement node.
	track := tabBar userData at: #'selection-track'.
	nodeBounds := (node measuredBounds inParent: track parent) inChild:
		              aSelectionElement parent.
	trackBounds := (track measuredBounds inParent: track parent)
		               inChild: aSelectionElement parent.
	pos := tabBar isHorizontal
		       ifTrue: [ nodeBounds position x @ trackBounds position y ]
		       ifFalse: [ trackBounds position x @ nodeBounds position y ].
	aSelectionElement position: pos
]

{ #category : #accessing }
ToRawSkinTabBarSelectionPlacement >> tabBar: anObject [

	tabBar := anObject
]
