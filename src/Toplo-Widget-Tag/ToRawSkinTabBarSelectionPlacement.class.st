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
	track := tabBar userData at: #'selection-track' ifAbsent: [ ^ self ].
	nodeBounds := node measuredBounds inSpace inChild:
		              aSelectionElement parent.
	trackBounds := track measuredBounds inSpace inChild:
		               aSelectionElement parent.
	pos := tabBar isHorizontal
		       ifTrue: [
			       nodeBounds position x
			       @ (trackBounds position y - aSelectionElement height) ]
		       ifFalse: [
			       (trackBounds position x - aSelectionElement width)
			       @ (nodeBounds position y ) ].
	aSelectionElement position: pos
]

{ #category : #accessing }
ToRawSkinTabBarSelectionPlacement >> tabBar: anObject [

	tabBar := anObject
]
