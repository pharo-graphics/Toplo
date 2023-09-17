Class {
	#name : #ToPropertyAnimation,
	#superclass : #Object,
	#traits : 'TToPropertyAnimation',
	#classTraits : 'TToPropertyAnimation classTrait',
	#instVars : [
		'property',
		'duration'
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

{ #category : #'t - property animation - accessing' }
ToPropertyAnimation >> property [

	^ property
]

{ #category : #accessing }
ToPropertyAnimation >> property: aProperty [

	property := aProperty
]
