Class {
	#name : #ToListSubSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#instVars : [
		'parentMode'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListSubSelectionMode class >> parentMode: aSelectionMode [

	^ self basicNew
		  parentMode: aSelectionMode;
		  initialize
]

{ #category : #'instance creation' }
ToListSubSelectionMode >> newSelecter [

	^ ToSubSelecter new
		  uniqueId: self uniqueId;
		  selectionChangedEventClass: self selectionChangedEventClass;
		  parentSelecter: parentMode selecter;
		  yourself
]

{ #category : #'api - hooks' }
ToListSubSelectionMode >> newSelectionModel [

	^ ToSubSelectionModel new
]

{ #category : #accessing }
ToListSubSelectionMode >> parentMode: aSelectionMode [

	parentMode := aSelectionMode
]

{ #category : #accessing }
ToListSubSelectionMode >> uniqueId [ 

	^ self subclassResponsibility 
]
