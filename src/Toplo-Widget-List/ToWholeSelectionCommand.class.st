Class {
	#name : #ToWholeSelectionCommand,
	#superclass : #ToSelectionAddRemoveCommand,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'instance creation' }
ToWholeSelectionCommand class >> add [

	^ self new
		  operation: ToAddSelectionOperation new;
		  yourself
]

{ #category : #'instance creation' }
ToWholeSelectionCommand class >> remove [

	^ self new
		  operation: ToRemoveSelectionOperation new;
		  yourself
]

{ #category : #'private - hook' }
ToWholeSelectionCommand >> applyWithOperator: anOperator [

	self operation applyWholeSelection: self on: anOperator.
	super applyWithOperator: anOperator
]

{ #category : #accessing }
ToWholeSelectionCommand >> indexes [ 

	^ 1 to: selectionModel itemCount
]
