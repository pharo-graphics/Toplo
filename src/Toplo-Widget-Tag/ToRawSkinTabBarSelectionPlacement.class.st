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

	| x y node nodeBounds |
	tabBar isWrapping ifTrue: [ ^ self ].
	" compute the selection element to be over the parent track element "
	node := aSelectionElement node.
	node space ifNil: [ ^ self ].
	nodeBounds := node measuredBounds inSpace inChild:
		              aSelectionElement parent.
	tabBar isHorizontal
		ifTrue: [
			x := nodeBounds position x.
			y := tabBar atStartSide
				     ifTrue: [ nodeBounds bottom - aSelectionElement measuredHeight]
				     ifFalse: [ nodeBounds top ] ]
		ifFalse: [
			y := nodeBounds position y.
			x := tabBar atStartSide
				     ifTrue: [ nodeBounds right - aSelectionElement measuredWidth]
				     ifFalse: [ nodeBounds left ] ].

	aSelectionElement position: x @ y
]

{ #category : #accessing }
ToRawSkinTabBarSelectionPlacement >> tabBar: anObject [

	tabBar := anObject
]
