Class {
	#name : #ToListSelectionModelHolderForTest,
	#superclass : #ToSelectionModelHolderForTest,
	#classTraits : 'TBlEventTarget classTrait',
	#category : #'Toplo-Widget-List-Tests-Selection-Model'
}

{ #category : #initialization }
ToListSelectionModelHolderForTest >> defaultSelectionModel [

	^ ToListSelectionModel new
]

{ #category : #initialization }
ToListSelectionModelHolderForTest >> initialize [ 

	super initialize.
	self selectionCommandChecker: ToListMultiSelectionCommandChecker new.

]

{ #category : #accessing }
ToListSelectionModelHolderForTest >> selectionCommandChecker [

	^ self selectionModel selectionCommandChecker
]

{ #category : #accessing }
ToListSelectionModelHolderForTest >> selectionCommandChecker: aSelectionCommandChecker [

	self selectionModel selectionCommandChecker: aSelectionCommandChecker
]
