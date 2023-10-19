Class {
	#name : #ToPropertyAnimation,
	#superclass : #Object,
	#instVars : [
		'property',
		'duration',
		'finishedHandlers'
	],
	#category : 'Toplo-Core-Skin'
}

{ #category : #accessing }
ToPropertyAnimation >> duration [

	^ duration ifNil: [ duration := 200 milliSeconds ]
]

{ #category : #accessing }
ToPropertyAnimation >> duration: aDuration [

	duration := aDuration
]

{ #category : #accessing }
ToPropertyAnimation >> finishedHandlers [

	^ finishedHandlers 
]

{ #category : #initialization }
ToPropertyAnimation >> initialize [ 

	super initialize.
	finishedHandlers := OrderedCollection new
]

{ #category : #'action handling' }
ToPropertyAnimation >> onFinishedDo: aBlock [

	self finishedHandlers add: aBlock
]

{ #category : #accessing }
ToPropertyAnimation >> property [

	^ property
]

{ #category : #accessing }
ToPropertyAnimation >> property: aProperty [

	property := aProperty
]

{ #category : #writing }
ToPropertyAnimation >> write: anObject to: anElement [

	self explicitRequirement 
]
