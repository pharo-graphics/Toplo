Class {
	#name : #ToListNoneSelectionCommandChecker,
	#superclass : #ToListSelectionCommandChecker,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #'command checking' }
ToListNoneSelectionCommandChecker >> addIndexesSelectionCommand: aCommand [

	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListNoneSelectionCommandChecker >> addIntervalSelectionCommand: aCommand [

	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListNoneSelectionCommandChecker >> addWholeSelectionCommand: aCommand [

	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListNoneSelectionCommandChecker >> removeIndexesSelectionCommand: aCommand [

	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListNoneSelectionCommandChecker >> removeIntervalSelectionCommand: aCommand [

	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListNoneSelectionCommandChecker >> removeWholeSelectionCommand: aCommand [

	ToIncompatibleMode new signal
]
