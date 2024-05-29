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

{ #category : #accessing }
ToSecondarySelecter >> primarySelecter: aPrimarySelecter [

	primarySelecter := aPrimarySelecter
]

{ #category : #accessing }
ToSecondarySelecter >> selectionModelInEventTarget: anEventTarget [

	^ anEventTarget newSecondarySelectionModel
]

{ #category : #accessing }
ToSecondarySelecter >> subSelecterIndex [

	^ primarySelecter subSelecterIndex
]
