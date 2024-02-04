Class {
	#name : #ToListSelectionModelHolderForTest,
	#superclass : #ToSelectionModelHolderForTest,
	#classTraits : 'TBlEventTarget classTrait',
	#category : #'Toplo-Widget-List-Tests-Selection-Command'
}

{ #category : #initialization }
ToListSelectionModelHolderForTest >> defaultSelectionModel [

	^ ToListSelectionModel new
]
