Class {
	#name : #ToListElementCommand,
	#superclass : #ToElementBasicCommand,
	#instVars : [
		'selectionModel',
		'selectionChanged'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #accessing }
ToListElementCommand >> selectionChanged [

	^ selectionChanged ifNil: [  selectionChanged := false ]
]

{ #category : #accessing }
ToListElementCommand >> selectionChanged: aBoolean [

	selectionChanged := aBoolean
]

{ #category : #accessing }
ToListElementCommand >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListElementCommand >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]
