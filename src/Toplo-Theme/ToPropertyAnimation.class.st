Class {
	#name : #ToPropertyAnimation,
	#superclass : #Object,
	#traits : 'TToPropertyAnimation',
	#classTraits : 'TToPropertyAnimation classTrait',
	#instVars : [
		'property',
		'duration',
		'finishedHandlers'
	],
	#category : #'Toplo-Theme-Skin'
}

{ #category : #'t - property animation - accessing' }
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

{ #category : #'t - property animation - action handling' }
ToPropertyAnimation >> onFinishedDo: aBlock [

	self finishedHandlers add: aBlock
]

{ #category : #'t - property animation - accessing' }
ToPropertyAnimation >> property [

	^ property
]

{ #category : #accessing }
ToPropertyAnimation >> property: aProperty [

	property := aProperty
]

{ #category : #'t - property animation - writing' }
ToPropertyAnimation >> write: anObject to: anElement [

	self explicitRequirement 
]
