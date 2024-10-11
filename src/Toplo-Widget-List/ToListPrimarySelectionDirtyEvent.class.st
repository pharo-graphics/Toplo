Class {
	#name : #ToListPrimarySelectionDirtyEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'itemCount',
		'selectionOption',
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListPrimarySelectionDirtyEvent >> itemCount: anInteger [

	itemCount := anInteger
]

{ #category : #accessing }
ToListPrimarySelectionDirtyEvent >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListPrimarySelectionDirtyEvent >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #accessing }
ToListPrimarySelectionDirtyEvent >> selectionOption [

	^ selectionOption 
]

{ #category : #accessing }
ToListPrimarySelectionDirtyEvent >> selectionOption: aSelectionElementOption [

	selectionOption := aSelectionElementOption
]

{ #category : #sending }
ToListPrimarySelectionDirtyEvent >> sendTo: anObject [

	anObject listPrimarySelectionDirtyEvent: self
]

{ #category : #accessing }
ToListPrimarySelectionDirtyEvent >> touchedIndexes [ 

	^ 1 to: itemCount
]
