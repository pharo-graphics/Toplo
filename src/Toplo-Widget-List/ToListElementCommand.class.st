Class {
	#name : #ToListElementCommand,
	#superclass : #ToElementBasicCommand,
	#instVars : [
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #accessing }
ToListElementCommand >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListElementCommand >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]
