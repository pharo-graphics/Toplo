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

	aCommand interval size = 1 ifTrue: [ ^ self ].
	aCommand interval ifEmpty: [
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

	aCommand interval size = 1 ifTrue: [ ^ self ].
	aCommand interval ifEmpty: [ ^ ToInvalidCommand new messageText: 'The interval should not be empty' ].
	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListSingleSelectionMode >> removeWholeSelectionCommand: aCommand [

	ToIncompatibleMode new signal

]
