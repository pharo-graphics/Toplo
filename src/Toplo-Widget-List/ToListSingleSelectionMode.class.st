Class {
	#name : #ToListSingleSelectionMode,
	#superclass : #ToListSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #'command checking' }
ToListSingleSelectionMode >> addIndexesSelectionCommand: aCommand [

	aCommand indexes size = 1 ifTrue: [ ^ self ].
	aCommand indexes ifEmpty: [ ^ ToInvalidCommand new messageText: 'The indexes array should not be empty' ].
	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListSingleSelectionMode >> addIntervalSelectionCommand: aCommand [

	(aCommand from = aCommand to and: [aCommand from > 0]) ifTrue: [ ^ self ].
	(aCommand from - aCommand to) abs > 0 ifFalse: [
		^ ToInvalidCommand new messageText:
			  'The interval should not be empty' ].
	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListSingleSelectionMode >> addWholeSelectionCommand: aCommand [

	ToIncompatibleMode new signal

]

{ #category : #'command checking' }
ToListSingleSelectionMode >> removeIndexesSelectionCommand: aCommand [

	aCommand indexes size = 1 ifTrue: [ ^ self ].
	aCommand indexes ifEmpty: [ ^ ToInvalidCommand new messageText: 'The indexes array should not be empty' ].
	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListSingleSelectionMode >> removeIntervalSelectionCommand: aCommand [

	| interval |
	interval := aCommand computedInterval.
	interval size = 1 ifTrue: [ ^ self ].
	interval ifEmpty: [ ^ ToInvalidCommand new messageText: 'The interval should not be empty' ].
	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListSingleSelectionMode >> removeWholeSelectionCommand: aCommand [

	" ok lets do it "

]
