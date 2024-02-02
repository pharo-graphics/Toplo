Class {
	#name : #ToListSelectionMode,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection-Command'
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
