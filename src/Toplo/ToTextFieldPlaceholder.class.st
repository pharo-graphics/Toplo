Class {
	#name : #ToTextFieldPlaceholder,
	#superclass : #ToAlbumPlaceholder,
	#category : #'Toplo-Widget-TextField'
}

{ #category : #'api - attaching / detaching' }
ToTextFieldPlaceholder >> attachTo: anEditorElement [

	super attachTo: anEditorElement.
	"label padding: anEditorElement padding copy.
	label margin: anEditorElement margin copy."
]

{ #category : #initialization }
ToTextFieldPlaceholder >> defaultLabel [

	^ ToLabel new
		  fitContent;
		  constraintsDo: [ :c | 
			  c frame vertical alignCenter.
			  c frame horizontal alignLeft ];
		  beMonoLine;
		  yourself
]
