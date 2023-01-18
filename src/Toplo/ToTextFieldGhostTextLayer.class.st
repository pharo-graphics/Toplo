Class {
	#name : #ToTextFieldGhostTextLayer,
	#superclass : #ToAlbumGhostTextLayer,
	#category : #'Toplo-Widget-TextField'
}

{ #category : #'api - attaching / detaching' }
ToTextFieldGhostTextLayer >> attachTo: anEditorElement [

	super attachTo: anEditorElement.
	label padding: anEditorElement next padding copy.
	label margin: anEditorElement next margin copy.
]

{ #category : #initialization }
ToTextFieldGhostTextLayer >> defaultLabel [

	^ ToLabel new
		  fitContent;
		  constraintsDo: [ :c | 
			  c frame vertical alignCenter.
			  c frame horizontal alignLeft ];
		  beMonoLine;
		  yourself
]
