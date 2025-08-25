Class {
	#name : #ToWindowStarter,
	#superclass : #Object,
	#category : #'Toplo-Core-Window'
}

{ #category : #testing }
ToWindowStarter >> isForInlineWindow [

	^ false
]

{ #category : #testing }
ToWindowStarter >> isInline [

	self
		deprecated: 'Use #isForInlineWindow instead'
		transformWith: '`@rcvr isInline' -> '`@rcvr isForInlineWindow'.
	^ self isForInlineWindow
]

{ #category : #'starting-stopping' }
ToWindowStarter >> startWindow: aWindow fromManager: aManager [

	self subclassResponsibility 
]

{ #category : #'starting-stopping' }
ToWindowStarter >> stopWindow: aWindow fromManager: aManager [

	self subclassResponsibility 
]

{ #category : #accessing }
ToWindowStarter >> windowClassFromManager: aManager [

	^ aManager defaultWindowClass 
]
