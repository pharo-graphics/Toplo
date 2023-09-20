Class {
	#name : #ToBackgroundColorAnimationForTest,
	#superclass : #Object,
	#traits : 'TToPropertyAnimation',
	#classTraits : 'TToPropertyAnimation classTrait',
	#instVars : [
		'deferred',
		'property'
	],
	#category : 'Toplo-Theme-Tests-Skin'
}

{ #category : #'t - property animation - accessing' }
ToBackgroundColorAnimationForTest >> duration [

	^ 500 milliSeconds 
]

{ #category : #'t - property animation - action handling' }
ToBackgroundColorAnimationForTest >> onFinishedDo: aBlock [

	deferred := aBlock
]

{ #category : #'t - property animation - accessing' }
ToBackgroundColorAnimationForTest >> property [

	^ property
]

{ #category : #accessing }
ToBackgroundColorAnimationForTest >> property: aProperty [

	property := aProperty
]

{ #category : #'t - property animation - running' }
ToBackgroundColorAnimationForTest >> stop [


]

{ #category : #'t - property animation - writing' }
ToBackgroundColorAnimationForTest >> write: anObject to: anElement [

	anElement enqueueTask: (BlTaskAction new action: [
			 self duration asDelay wait.
			 self property write: anObject to: anElement.
			 deferred ifNotNil: [ :d | d value ] ])
]
