Class {
	#name : #ToListSelectionModelHolderForTest,
	#superclass : #ToSelectionModelHolderForTest,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'selectionCommandChecker'
	],
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
ToListSelectionModelHolderForTest >> selecter [

	^ super selecter
		  selectionCommandChecker: self selectionCommandChecker;
		  yourself
]

{ #category : #accessing }
ToListSelectionModelHolderForTest >> selectionCommandChecker [

	^ selectionCommandChecker
]

{ #category : #accessing }
ToListSelectionModelHolderForTest >> selectionCommandChecker: aSelectionCommandChecker [

	selectionCommandChecker := aSelectionCommandChecker
]
