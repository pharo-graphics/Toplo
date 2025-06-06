Trait {
	#name : #TToPostponedCommandHolder,
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #'t - postponed command holder' }
TToPostponedCommandHolder >> addPostponedCommand: aCommand [

	self shouldBeImplemented 
]

{ #category : #'t - postponed command holder' }
TToPostponedCommandHolder >> consumePostponedCommand: aCommand in: anElement [

	self shouldBeImplemented 
]

{ #category : #'t - postponed command holder' }
TToPostponedCommandHolder >> consumePostponedCommandsIn: anElement [
	"Skip pre-processing and perform all pending commands in one pass."

	"we still consume finale step updates (if there is)."

	[ self hasPostponedCommand ] whileTrue: [
		| cmd |
		cmd := self nextPostponedCommand.
		self consumePostponedCommand: cmd in: anElement ]
]

{ #category : #'t - postponed command holder' }
TToPostponedCommandHolder >> hasPostponedCommand [

	^ self shouldBeImplemented 
]

{ #category : #'t - postponed command holder' }
TToPostponedCommandHolder >> nextPostponedCommand [

	^ self shouldBeImplemented 
]

{ #category : #'t - postponed command holder' }
TToPostponedCommandHolder >> postponeAction: aValuable [

	self shouldBeImplemented 
]

{ #category : #'t - postponed command holder' }
TToPostponedCommandHolder >> postponeCommand: aCommand [

	self addPostponedCommand: aCommand
]
