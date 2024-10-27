Class {
	#name : #ToListElementCommand,
	#superclass : #ToElementBasicCommand,
	#instVars : [
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'private - adding' }
ToListElementCommand >> addedIn: aCommandApplier [

	selectionModel := aCommandApplier selectionModel
]

{ #category : #accessing }
ToListElementCommand >> indexes [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToListElementCommand >> intervals [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToListElementCommand >> intervalsIn: aCollection [
	" return an array of intervals #( 2 3 4 6 7 8 ) -> { 2 to: 4. 6 to: 8 } "

	| sorted |
	sorted := aCollection asOrderedCollection sort.
	^ Array streamContents: [ :stream |
		  | prev g |
		  g := nil.
		  prev := nil.
		  sorted do: [ :idx |
			  prev
				  ifNil: [
					  g := idx to: idx ]
				  ifNotNil: [
					  prev + 1 = idx
						  ifTrue: [ g := g first to: idx ]
						  ifFalse: [
							  stream nextPut: g.
							  g := idx to: idx ] ].
			  prev := idx ].
		  g ifNotNil: [ stream nextPut: g ] ]
]

{ #category : #accessing }
ToListElementCommand >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListElementCommand >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]
