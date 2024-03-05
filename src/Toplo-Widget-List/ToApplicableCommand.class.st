Class {
	#name : #ToApplicableCommand,
	#superclass : #Object,
	#instVars : [
		'command',
		'operator'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'api - processing' }
ToApplicableCommand >> applyFor: aTarget [

	self operator applyCommand: self command for: aTarget
]

{ #category : #'api - processing' }
ToApplicableCommand >> applyIn: anInfiniteElement [

	self operator applyCommand: self command for: anInfiniteElement
]

{ #category : #commands }
ToApplicableCommand >> applyOnPosition: aPosition [

	^ aPosition
]

{ #category : #accessing }
ToApplicableCommand >> command [

	^ command
]

{ #category : #accessing }
ToApplicableCommand >> command: aCommand [

	command := aCommand
]

{ #category : #commands }
ToApplicableCommand >> dispatchToLayout: aLayout [

	
]

{ #category : #testing }
ToApplicableCommand >> isUpdate [

	^ false
]

{ #category : #commands }
ToApplicableCommand >> offsetPositionsIn: anInfiniteElement [ 

	
]

{ #category : #accessing }
ToApplicableCommand >> operator [

	^ operator
]

{ #category : #accessing }
ToApplicableCommand >> operator: aCommandOperator [

	operator := aCommandOperator
]
