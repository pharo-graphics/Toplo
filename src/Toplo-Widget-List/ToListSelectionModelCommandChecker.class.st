Class {
	#name : #ToListSelectionModelCommandChecker,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #'command checking' }
ToListSelectionModelCommandChecker >> addIndexesSelectionCommand: aCommand [

	self subclassResponsibility 
]

{ #category : #'command checking' }
ToListSelectionModelCommandChecker >> addIntervalSelectionCommand: aCommand [

	self subclassResponsibility 
]

{ #category : #'command checking' }
ToListSelectionModelCommandChecker >> addWholeSelectionCommand: aCommand [ 
	^ self subclassResponsibility
]

{ #category : #'command checking' }
ToListSelectionModelCommandChecker >> removeIndexesSelectionCommand: aCommand [

	self subclassResponsibility 
]

{ #category : #'command checking' }
ToListSelectionModelCommandChecker >> removeIntervalSelectionCommand: aCommand [

	self subclassResponsibility 
]

{ #category : #'command checking' }
ToListSelectionModelCommandChecker >> removeWholeSelectionCommand: aCommand [

	^ self subclassResponsibility
]
