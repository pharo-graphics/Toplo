Class {
	#name : #ToSecondarySelectionModel,
	#superclass : #ToFrontSelectionModel,
	#instVars : [
		'primarySelectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #testing }
ToSecondarySelectionModel >> isUnselectableIndex: anIndex [

	^ primarySelectionModel isUnselectableIndex: anIndex
]

{ #category : #accessing }
ToSecondarySelectionModel >> primarySelectionModel: aPrimarySelectionModel [

	primarySelectionModel := aPrimarySelectionModel
]

{ #category : #accessing }
ToSecondarySelectionModel >> subSelectionModelIndex [

	^ primarySelectionModel subSelectionModelIndex
]
