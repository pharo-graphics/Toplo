Class {
	#name : #ToListSelectionMode,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #'command checking' }
ToListSelectionMode >> addIndexesSelectionCommand: aCommand [

	self subclassResponsibility 
]

{ #category : #'command checking' }
ToListSelectionMode >> addIntervalSelectionCommand: aCommand [

	self subclassResponsibility 
]

{ #category : #'command checking' }
ToListSelectionMode >> removeIndexesSelectionCommand: aCommand [

	self subclassResponsibility 
]

{ #category : #'command checking' }
ToListSelectionMode >> removeIntervalSelectionCommand: aCommand [

	self subclassResponsibility 
]

{ #category : #'command checking' }
ToListSelectionMode >> removeWholeSelectionCommand: aCommand [

	^ self subclassResponsibility
]
