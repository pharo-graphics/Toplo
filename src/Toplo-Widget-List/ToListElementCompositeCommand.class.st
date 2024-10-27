Class {
	#name : #ToListElementCompositeCommand,
	#superclass : #ToElementCompositeCommand,
	#instVars : [
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'private - adding' }
ToListElementCompositeCommand >> addedIn: aCommandApplier [

	selectionModel := aCommandApplier selectionModel.
	commands do: [ :c | c addedIn: self ]
]

{ #category : #accessing }
ToListElementCompositeCommand >> indexes [

	^ Array streamContents: [ :stream |
		  commands do: [ :c | stream nextPutAll: c indexes ] ]
]

{ #category : #accessing }
ToListElementCompositeCommand >> intervals [

	^ Array streamContents: [ :stream |
		  commands do: [ :c | stream nextPutAll: c intervals ] ]
]

{ #category : #accessing }
ToListElementCompositeCommand >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListElementCompositeCommand >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]
