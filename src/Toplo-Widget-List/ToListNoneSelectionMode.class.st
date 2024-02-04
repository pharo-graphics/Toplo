Class {
	#name : #ToListNoneSelectionMode,
	#superclass : #ToListSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #'command checking' }
ToListNoneSelectionMode >> addIndexesSelectionCommand: aCommand [

	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListNoneSelectionMode >> addIntervalSelectionCommand: aCommand [

	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListNoneSelectionMode >> addWholeSelectionCommand: aCommand [

	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListNoneSelectionMode >> removeIndexesSelectionCommand: aCommand [

	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListNoneSelectionMode >> removeIntervalSelectionCommand: aCommand [

	ToIncompatibleMode new signal
]

{ #category : #'command checking' }
ToListNoneSelectionMode >> removeWholeSelectionCommand: aCommand [

	ToIncompatibleMode new signal
]
