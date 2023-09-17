Class {
	#name : #ToBackgroundUpdateAnimationForTest,
	#superclass : #Object,
	#traits : 'TToPropertyAnimation',
	#classTraits : 'TToPropertyAnimation classTrait',
	#instVars : [
		'deferred',
		'property'
	],
	#category : #'Toplo-Theme-Tests-Skin'
}

{ #category : #'t - property animation - accessing' }
ToBackgroundUpdateAnimationForTest >> duration [

	^ 500 milliSeconds 
]

{ #category : #'t - property animation - action handling' }
ToBackgroundUpdateAnimationForTest >> onFinishedDo: aBlock [

	deferred := aBlock
]

{ #category : #'t - property animation - accessing' }
ToBackgroundUpdateAnimationForTest >> property [

	^ property
]

{ #category : #accessing }
ToBackgroundUpdateAnimationForTest >> property: aProperty [

	property := aProperty
]

{ #category : #'t - property animation - running' }
ToBackgroundUpdateAnimationForTest >> stop [


]

{ #category : #'t - property animation - writing' }
ToBackgroundUpdateAnimationForTest >> write: anObject to: anElement [

	anElement enqueueTask: (BlTaskAction new action: [
			 self duration asDelay wait.
			 self property write: anObject to: anElement.
			 deferred ifNotNil: [ :d | d value ] ])
]
