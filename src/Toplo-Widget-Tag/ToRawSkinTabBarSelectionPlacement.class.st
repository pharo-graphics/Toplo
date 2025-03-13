Class {
	#name : #ToRawSkinTabBarSelectionPlacement,
	#superclass : #ToElementCustomPlacement,
	#instVars : [
		'tabBar'
	],
	#category : #'Toplo-Widget-Tag-Tab-RawThemeSupport'
}

{ #category : #'api - displaying' }
ToRawSkinTabBarSelectionPlacement >> positionElement: aSelectionElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| track x y node nodeBounds trackBounds  |
	" compute the selection element to be over the parent track element "
	node := aSelectionElement node.
	track := tabBar userData at: #'selection-track' ifAbsent: [ ^ self ].
	nodeBounds := node measuredBounds inSpace inChild:
		              aSelectionElement parent.
	trackBounds := track measuredBounds inSpace inChild:
		               aSelectionElement parent.
	tabBar isHorizontal
		ifTrue: [
			x := nodeBounds position x.
			y := trackBounds position y ]
		ifFalse: [
			x := trackBounds position x.
			y := nodeBounds position y ].

	aSelectionElement position: x @ y
]

{ #category : #accessing }
ToRawSkinTabBarSelectionPlacement >> tabBar: anObject [

	tabBar := anObject
]
