Class {
	#name : #ToIntervalSelectionCommand,
	#superclass : #ToSelectionModelCommand,
	#instVars : [
		'from',
		'to'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #hook }
ToIntervalSelectionCommand >> applyOn: anObject [

	self operation applyIntervalSelection: self on: anObject.
	super applyOn: anObject	
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
ToIntervalSelectionCommand >> to [

	^ to
]

{ #category : #accessing }
ToIntervalSelectionCommand >> to: anIndex [

	to := anIndex
]
