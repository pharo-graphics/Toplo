Trait {
	#name : #TToCircularElement,
	#instVars : [
		'scrollSensitivity'
	],
	#category : #'Toplo-Widget-Circular-BasicElement'
}

{ #category : #'t - circular element' }
TToCircularElement >> defaultLayout [ 

	^ ToBasicCircularLayout new
]

{ #category : #'t - circular element' }
TToCircularElement >> initializeAsCircularElement [

	scrollSensitivity := 0.02
]

{ #category : #'t - circular element' }
TToCircularElement >> inset [

	^ self layout inset
]

{ #category : #'t - circular element' }
TToCircularElement >> inset: aNumber [

	self inset = aNumber ifTrue: [ ^ self ].
	self layout inset: aNumber.
	self requestLayout
]

{ #category : #'t - circular element' }
TToCircularElement >> scrollSensitivity [

	^ scrollSensitivity
]

{ #category : #'t - circular element' }
TToCircularElement >> scrollSensitivity: anObject [

	scrollSensitivity := anObject
]

{ #category : #'t - circular element' }
TToCircularElement >> startAngle [

	^ self layout startAngle
]

{ #category : #'t - circular element' }
TToCircularElement >> startAngle: anAngleInDegrees [

	(self startAngle closeTo: anAngleInDegrees) ifTrue: [ ^ self ].
	self layout startAngle: anAngleInDegrees.
	self requestLayout
]

{ #category : #'t - circular element' }
TToCircularElement >> startAngleOffset [

	^ self layout startAngleOffset
]

{ #category : #'t - circular element' }
TToCircularElement >> startAngleOffset: anAngleInDegrees [

	(self startAngleOffset closeTo: anAngleInDegrees) ifTrue: [ ^ self ].
	self layout startAngleOffset: anAngleInDegrees.
	self requestLayout
]
