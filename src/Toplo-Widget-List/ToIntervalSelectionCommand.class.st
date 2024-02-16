Class {
	#name : #ToIntervalSelectionCommand,
	#superclass : #ToSelectionModelAddRemoveCommand,
	#instVars : [
		'from',
		'to'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #hook }
ToIntervalSelectionCommand >> applyOn: anObject for: aTarget [

	self operation applyIntervalSelection: self on: anObject.
	super applyOn: anObject for: aTarget
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
