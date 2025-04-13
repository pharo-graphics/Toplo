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

	| x y node nodeBounds parent |
	tabBar isWrapping ifTrue: [ ^ self ].
	parent := aSelectionElement parent.
	" compute the selection element to be over the parent track element "
	node := aSelectionElement node.
	node space ifNil: [ ^ self ].
	nodeBounds := node measuredBounds inSpace inChild: parent.
	tabBar isHorizontal
		ifTrue: [
			x := nodeBounds position x.
			y := tabBar atStartSide
				     ifTrue: [
				     nodeBounds bottom  ]
				     ifFalse: [ nodeBounds top - (aSelectionElement measuredHeight) ] ]
		ifFalse: [
			y := nodeBounds position y.
			x := tabBar atStartSide
				     ifTrue: [ nodeBounds right  ]
				     ifFalse: [ nodeBounds left - aSelectionElement measuredWidth] ].

	aSelectionElement position: x @ y
]

{ #category : #accessing }
ToRawSkinTabBarSelectionPlacement >> tabBar: anObject [

	tabBar := anObject
]
