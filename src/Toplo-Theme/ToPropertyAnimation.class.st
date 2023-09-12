Class {
	#name : #ToPropertyAnimation,
	#superclass : #Object,
	#instVars : [
		'rawAnimation',
		'property',
		'duration'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #accessing }
ToPropertyAnimation >> duration [

	^ duration ifNil: [ duration := 200 milliSeconds ]
]

{ #category : #accessing }
ToPropertyAnimation >> duration: aDuration [

	duration := aDuration
]

{ #category : #'action handling' }
ToPropertyAnimation >> onFinishedDo: aBlock [

	rawAnimation onFinishedDo: aBlock
]

{ #category : #accessing }
ToPropertyAnimation >> property [

	^ property
]

{ #category : #accessing }
ToPropertyAnimation >> property: aPropertyDefinition [

	property := aPropertyDefinition
]

{ #category : #accessing }
ToPropertyAnimation >> stop [

	rawAnimation ifNotNil: [ :ra | ra isRunning ifTrue: [ ra stop ] ]
]

{ #category : #writing }
ToPropertyAnimation >> write: anObject to: anElement [

	self subclassResponsibility 
]
