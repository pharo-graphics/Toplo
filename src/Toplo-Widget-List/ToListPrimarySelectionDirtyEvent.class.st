Class {
	#name : #ToListPrimarySelectionDirtyEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'itemCount',
		'selectionOption'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListPrimarySelectionDirtyEvent >> groupHolder [

	^ selectionOption groupHolder
]

{ #category : #accessing }
ToListPrimarySelectionDirtyEvent >> itemCount: anInteger [

	itemCount := anInteger
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
