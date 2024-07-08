Class {
	#name : #ToIntervalSelectionCommand,
	#superclass : #ToSelectionModelAddRemoveCommand,
	#instVars : [
		'from',
		'to'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'private - hook' }
ToIntervalSelectionCommand >> applyOn: anOperator [

	" ask the operator passed as argument to actually apply the command. "

	self
		deprecated: 'Use applyOnOperator: instead'
		transformWith: '`@receiver applyOn: `@argument'
			-> '`@receiver applyOnOperator: `@argument'.
	self applyWithOperator: anOperator
]

{ #category : #'private - hook' }
ToIntervalSelectionCommand >> applyWithOperator: anOperator [ 

	self operation applyIntervalSelection: self on: anOperator.
	super applyWithOperator: anOperator
]

{ #category : #accessing }
ToIntervalSelectionCommand >> computedInterval [

	^ (self from min: self to) to: (self from max: self to)
]

{ #category : #accessing }
ToIntervalSelectionCommand >> from [

	^ from
]

{ #category : #accessing }
ToIntervalSelectionCommand >> from: anIndex [

	from := anIndex
]

{ #category : #accessing }
ToIntervalSelectionCommand >> from: aFromIndex to: aToIndex [

	self from: aFromIndex.
	self to: aToIndex
]

{ #category : #accessing }
ToIntervalSelectionCommand >> indexes [ 

	^ self computedInterval 
]

{ #category : #accessing }
ToIntervalSelectionCommand >> intervals [ 

	^ Array with: (from to: to)
]

{ #category : #accessing }
ToIntervalSelectionCommand >> to [

	^ to
]

{ #category : #accessing }
ToIntervalSelectionCommand >> to: anIndex [

	to := anIndex
]
