Trait {
	#name : #TToSimpleState,
	#category : #'Toplo-Core-States'
}

{ #category : #'t - simple state' }
TToSimpleState >> applyOn: anElement fromQueue: aQueue [

	| se |
	se := self skinEvent.
	se isConsumed ifTrue: [ ^ self ].
	anElement spaceDo: [ :sp | se fillFromTime: anElement space time ].
	anElement dispatchEvent: se
]

{ #category : #'t - simple state' }
TToSimpleState >> skinEvent [ 

	^ Error signal: '#skinEvent should be defined'
]
