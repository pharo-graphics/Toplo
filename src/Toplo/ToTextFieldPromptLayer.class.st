Class {
	#name : #ToTextFieldPromptLayer,
	#superclass : #ToAlbumPromptLayer,
	#category : #'Toplo-Widget-TextField'
}

{ #category : #'api - attaching / detaching' }
ToTextFieldPromptLayer >> attachTo: anEditorElement [

	super attachTo: anEditorElement.
	"label padding: anEditorElement padding copy."
	label margin: anEditorElement next margin copy.
]

{ #category : #initialization }
ToTextFieldPromptLayer >> defaultLabel [

	^ ToLabel new
		  fitContent;
		  constraintsDo: [ :c | 
			  c frame vertical alignCenter.
			  c frame horizontal alignLeft ];
		  beMonoLine;
		  yourself
]
