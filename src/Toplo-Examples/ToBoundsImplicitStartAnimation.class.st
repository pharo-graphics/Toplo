Class {
	#name : #ToBoundsImplicitStartAnimation,
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
ToBoundsImplicitStartAnimation >> applyValue: interpolatedRectangle [

	target constraintsDo: [ :c |
		c position: interpolatedRectangle origin.
		c horizontal exact: interpolatedRectangle width.
		c vertical exact: interpolatedRectangle height ]
]

{ #category : #accessing }
ToBoundsImplicitStartAnimation >> from [

	^ from
]

{ #category : #accessing }
ToBoundsImplicitStartAnimation >> initStart [

	super initStart.

	from := target bounds asRectangle.
	
	positionDelta := to origin - from origin.
	extentDelta := to extent - from extent
]

{ #category : #accessing }
ToBoundsImplicitStartAnimation >> to [

	^ to
]

{ #category : #accessing }
ToBoundsImplicitStartAnimation >> to: aRectangle [

	to := aRectangle
]

{ #category : #pulse }
ToBoundsImplicitStartAnimation >> valueForStep: aNumber [

	| origin extent |
	origin := positionDelta * aNumber + from origin.
	extent := extentDelta * aNumber + from extent.

	^ origin extent: extent
]
