Class {
	#name : #ToListSelectionCommandChecker,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #'command checking' }
ToListSelectionCommandChecker >> addIndexesSelectionCommand: aCommand [

	self subclassResponsibility 
]

{ #category : #'command checking' }
ToListSelectionCommandChecker >> addIntervalSelectionCommand: aCommand [

	self subclassResponsibility 
]

{ #category : #'command checking' }
ToListSelectionCommandChecker >> removeIndexesSelectionCommand: aCommand [

	self subclassResponsibility 
]

{ #category : #'command checking' }
ToListSelectionCommandChecker >> removeIntervalSelectionCommand: aCommand [

	self subclassResponsibility 
]

{ #category : #'command checking' }
ToListSelectionCommandChecker >> removeWholeSelectionCommand: aCommand [

	^ self subclassResponsibility
]
