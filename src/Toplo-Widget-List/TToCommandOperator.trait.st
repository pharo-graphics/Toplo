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
			 operator: self;
			 yourself)
]

{ #category : #accessing }
TToCommandOperator >> applyAll [

	self dispatchEvent: ToCommandApplicationRequestEvent new
]

{ #category : #'command application' }
TToCommandOperator >> applyCommand: aCommand for: aTarget [

	aCommand applyOn: self for: aTarget.

]
