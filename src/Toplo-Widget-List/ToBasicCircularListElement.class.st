Class {
	#name : #ToBasicCircularListElement,
	#superclass : #ToElement,
	#instVars : [
		'scrollSensitivity'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite-Circular'
}

{ #category : #initialization }
ToBasicCircularListElement >> defaultLayout [ 

	^ ToBasicCircularLayout new
]

{ #category : #initialization }
ToBasicCircularListElement >> initialize [ 

	super initialize.
	scrollSensitivity := 0.02
]

{ #category : #accessing }
ToBasicCircularListElement >> inset [

	^ self layout inset
]

{ #category : #accessing }
ToBasicCircularListElement >> inset: aNumber [

	self inset = aNumber ifTrue: [ ^ self ].
	self layout inset: aNumber.
	self requestLayout
]

{ #category : #accessing }
ToBasicCircularListElement >> scrollSensitivity [

	^ scrollSensitivity
]

{ #category : #accessing }
ToBasicCircularListElement >> scrollSensitivity: anObject [

	scrollSensitivity := anObject
]

{ #category : #accessing }
ToBasicCircularListElement >> startAngle [

	^ layout startAngle
]

{ #category : #accessing }
ToBasicCircularListElement >> startAngle: anAngleInDegrees [

	(self startAngle closeTo: anAngleInDegrees) ifTrue: [ ^ self ].
	layout startAngle: anAngleInDegrees.
	self requestLayout
]

{ #category : #accessing }
ToBasicCircularListElement >> startAngleOffset [

	^ layout startAngleOffset
]

{ #category : #accessing }
ToBasicCircularListElement >> startAngleOffset: anAngleInDegrees [

	(self startAngleOffset closeTo: anAngleInDegrees) ifTrue: [ ^ self ].
	layout startAngleOffset: anAngleInDegrees.
	self requestLayout
]
