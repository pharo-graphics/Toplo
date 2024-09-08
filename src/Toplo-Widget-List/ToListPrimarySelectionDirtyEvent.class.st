Class {
	#name : #ToListPrimarySelectionDirtyEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'itemCount'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListPrimarySelectionDirtyEvent >> itemCount: anInteger [

	itemCount := anInteger
]

{ #category : #sending }
ToListPrimarySelectionDirtyEvent >> sendTo: anObject [

	anObject listPrimarySelectionDirtyEvent: self
]

{ #category : #accessing }
ToListPrimarySelectionDirtyEvent >> touchedIndexes [ 

	^ 1 to: itemCount
]
