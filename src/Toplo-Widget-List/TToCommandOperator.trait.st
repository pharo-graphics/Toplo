Trait {
	#name : #TToCommandOperator,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'applied command handling' }
TToCommandOperator >> actionCommand: aCommand for: aTarget [

	aCommand action cull: aTarget
]

{ #category : #accessing }
TToCommandOperator >> addCommand: aCommand [

	self dispatchEvent: (ToCommandAddedEvent new
			 command: aCommand;
			 commandOperator: self;
			 yourself)
]

{ #category : #'command application' }
TToCommandOperator >> applyCommand: aCommand for: aTarget [

	aCommand applyOn: self for: aTarget.

]
