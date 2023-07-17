Class {
	#name : #ToCheckableGroupStrictStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : #'Toplo-Widget-Button'
}

{ #category : #notifications }
ToCheckableGroupStrictStrategy >> buttonInserted: aCheckable in: aGroup [

	aCheckable checked ifTrue: [
		(aGroup buttons select: [ :b | b ~= aCheckable and: [ b checked ] ])
			do: [ :b | b privateUncheck ] ].
	super buttonInserted: aCheckable in: aGroup
]

{ #category : #testing }
ToCheckableGroupStrictStrategy >> canSwitchToNextState: aCheckable [

	^ aCheckable checked not
]
