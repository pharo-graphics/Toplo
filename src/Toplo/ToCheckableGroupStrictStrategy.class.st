Class {
	#name : #ToCheckableGroupStrictStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : #'Toplo-Widget-Button'
}

{ #category : #notifications }
ToCheckableGroupStrictStrategy >> buttonInserted: aCheckable in: aGroup [

	aCheckable isChecked ifTrue: [
		(aGroup buttons select: [ :b | b ~= aCheckable and: [ b isChecked ] ])
			do: [ :b | b privateUncheck ] ].
	super buttonInserted: aCheckable in: aGroup
]

{ #category : #testing }
ToCheckableGroupStrictStrategy >> canSwitchToNextState: aCheckable [

	^ aCheckable isUnchecked
]
