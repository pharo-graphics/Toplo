Trait {
	#name : #TToPostponedCommandManager,
	#instVars : [
		'finalStepCommands'
	],
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #'t - postponed command manager' }
TToPostponedCommandManager >> addFinalStepCommand: aCommand [

	self finalStepCommands add: aCommand
]

{ #category : #'t - postponed command manager' }
TToPostponedCommandManager >> consumeFinalStepCommand: aCommand in: anElement [

	self dispatchCommand: aCommand to: anElement.
	self onCommandProcessed: aCommand in: anElement.
	self recycleCommand: aCommand
]

{ #category : #'t - postponed command manager' }
TToPostponedCommandManager >> consumeFinalStepCommandsIn: anElement [
	"Skip pre-processing and perform all pending commands in one pass."

	"we still consume finale step updates (if there is)."

	[ self hasFinalStepCommand ] whileTrue: [
		| cmd |
		cmd := self nextFinalStepCommand.
		self consumeFinalStepCommand: cmd in: anElement ] 
]

{ #category : #'t - postponed command manager' }
TToPostponedCommandManager >> finalStepCommands [

	^ finalStepCommands ifNil: [ finalStepCommands := OrderedCollection new ]
]

{ #category : #'t - postponed command manager' }
TToPostponedCommandManager >> hasFinalStepCommand [

	^ self finalStepCommands notEmpty
]

{ #category : #'t - postponed command manager' }
TToPostponedCommandManager >> nextFinalStepCommand [

	^ self finalStepCommands removeFirst
]

{ #category : #'t - postponed command manager' }
TToPostponedCommandManager >> postponeAction: aValuable for: aTarget [

	self postponeCommand: (ToListDataSourceActionCommand new
			 action: [ aValuable cull: aTarget ];
			 yourself)
]

{ #category : #'t - postponed command manager' }
TToPostponedCommandManager >> postponeCommand: aCommand [

	self addFinalStepCommand: aCommand 
]
