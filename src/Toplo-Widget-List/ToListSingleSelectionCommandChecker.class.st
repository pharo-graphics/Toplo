Class {
	#name : #ToListSingleSelectionCommandChecker,
	#superclass : #ToListSelectionCommandChecker,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #'command checking' }
ToListSingleSelectionCommandChecker >> addIndexesSelectionCommand: aCommand [

	aCommand indexes size = 1 ifTrue: [ ^ self ].
	aCommand indexes ifEmpty: [ ^ ToInvalidCommand new messageText: 'The indexes array should not be empty' ].
	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListSingleSelectionCommandChecker >> addIntervalSelectionCommand: aCommand [

	(aCommand from = aCommand to and: [aCommand from > 0]) ifTrue: [ ^ self ].
	(aCommand from - aCommand to) abs > 0 ifFalse: [
		^ ToInvalidCommand new messageText:
			  'The interval should not be empty' ].
	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListSingleSelectionCommandChecker >> addWholeSelectionCommand: aCommand [

	ToIncompatibleMode new signal

]

{ #category : #'command checking' }
ToListSingleSelectionCommandChecker >> removeIndexesSelectionCommand: aCommand [

	aCommand indexes size = 1 ifTrue: [ ^ self ].
	aCommand indexes ifEmpty: [ ^ ToInvalidCommand new messageText: 'The indexes array should not be empty' ].
	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListSingleSelectionCommandChecker >> removeIntervalSelectionCommand: aCommand [

	| interval |
	interval := aCommand computedInterval.
	interval size = 1 ifTrue: [ ^ self ].
	interval ifEmpty: [ ^ ToInvalidCommand new messageText: 'The interval should not be empty' ].
	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListSingleSelectionCommandChecker >> removeWholeSelectionCommand: aCommand [

	" ok lets do it "

]
