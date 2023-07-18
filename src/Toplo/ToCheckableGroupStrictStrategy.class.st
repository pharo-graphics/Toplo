Class {
	#name : #ToCheckableGroupStrictStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : #'Toplo-Widget-Button'
}

{ #category : #notifications }
ToCheckableGroupStrictStrategy >> buttonInserted: aCheckable in: aGroup [

	aCheckable isChecked ifTrue: [
		(aGroup buttons select: [ :b | b ~= aCheckable and: [ b checked ] ])
			do: [ :b | b privateChecked: false ] ].
	super buttonInserted: aCheckable in: aGroup
]
