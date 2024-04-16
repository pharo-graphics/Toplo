Class {
	#name : #ToSecondarySelecter,
	#superclass : #ToCompositeSelecter,
	#instVars : [
		'primarySelecter'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #'instance creation' }
ToSecondarySelecter >> newOperator [
	
	^ ToSecondarySelectionModelOperator new
]

{ #category : #'instance creation' }
ToSecondarySelecter >> newSelectionModelInElement: anElement [

	^ anElement newSecondarySelectionModel
]

{ #category : #accessing }
ToSecondarySelecter >> primarySelecter: aPrimarySelecter [

	primarySelecter := aPrimarySelecter
]

{ #category : #accessing }
ToSecondarySelecter >> subSelecterIndex [

	^ primarySelecter subSelecterIndex
]
