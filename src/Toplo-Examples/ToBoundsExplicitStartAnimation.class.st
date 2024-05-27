Class {
	#name : #ToBoundsExplicitStartAnimation,
	#superclass : #BlAnimation,
	#instVars : [
		'from',
		'to',
		'positionDelta',
		'extentDelta'
	],
	#category : #'Toplo-Examples-Animation'
}

{ #category : #pulse }
ToBoundsExplicitStartAnimation >> applyValue: interpolatedRectangle [

	target constraintsDo: [ :c |
		c position: interpolatedRectangle origin.
		c horizontal exact: interpolatedRectangle width.
		c vertical exact: interpolatedRectangle height ]
]

{ #category : #accessing }
ToBoundsExplicitStartAnimation >> from [

	^ from
]

{ #category : #'as yet unclassified' }
ToBoundsExplicitStartAnimation >> from: fromRectangle to: toRectangle [

	from := fromRectangle.
	to := toRectangle.
	
	positionDelta := to origin - from origin.
	extentDelta := to extent - from extent
]

{ #category : #accessing }
ToBoundsExplicitStartAnimation >> to [

	^ to
]

{ #category : #pulse }
ToBoundsExplicitStartAnimation >> valueForStep: aNumber [

	| origin extent |
	origin := positionDelta * aNumber + from origin.
	extent := extentDelta * aNumber + from extent.

	^ origin extent: extent
]
