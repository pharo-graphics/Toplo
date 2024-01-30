Class {
	#name : #ToListPickedSelectionAction,
	#superclass : #ToListSelectionAction,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Widget-List-SelectionAction'
}

{ #category : #accessing }
ToListPickedSelectionAction >> indexes [

	^ indexes
]

{ #category : #accessing }
ToListPickedSelectionAction >> indexes: anArray [

	indexes := anArray
]
