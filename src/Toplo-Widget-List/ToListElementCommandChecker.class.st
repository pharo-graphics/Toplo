Class {
	#name : #ToListElementCommandChecker,
	#superclass : #Object,
	#instVars : [
		'listElement',
		'result'
	],
	#category : #'Toplo-Widget-List-Support'
}

{ #category : #'command operations' }
ToListElementCommandChecker >> addIndexesSelectionCommand: aCommand [


]

{ #category : #'command operations' }
ToListElementCommandChecker >> addIntervalSelectionCommand: aCommand [


]

{ #category : #'command operations' }
ToListElementCommandChecker >> addWholeSelectionCommand: aCommand [


]

{ #category : #'command checking' }
ToListElementCommandChecker >> allowCommand: aCommand [

	result := true.
	aCommand applyWithOperator: self.
	^ result
]

{ #category : #accessing }
ToListElementCommandChecker >> currentIndex [

	^ listElement selecter currentIndex
]

{ #category : #accessing }
ToListElementCommandChecker >> listElement: aListElement [

	listElement := aListElement 
]

{ #category : #'command operations' }
ToListElementCommandChecker >> removeIndexesSelectionCommand: aCommand [


]

{ #category : #'command operations' }
ToListElementCommandChecker >> removeIntervalSelectionCommand: aCommand [


]

{ #category : #'command operations' }
ToListElementCommandChecker >> removeWholeSelectionCommand: aCommand [


]

{ #category : #'command operations' }
ToListElementCommandChecker >> scrollCommand: aCommand [ 
]

{ #category : #'command operations' }
ToListElementCommandChecker >> selectionModelCopyFromCommand: aCopyFromCommand [


]

{ #category : #'command operations' }
ToListElementCommandChecker >> selectionModelShiftCommand: aCommand [ 

]
