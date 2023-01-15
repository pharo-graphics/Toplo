Class {
	#name : #ToTextFieldGhostTextLayer,
	#superclass : #ToAlbumGhostTextLayer,
	#category : #'Toplo-Widget-TextField'
}

{ #category : #'api - attaching / detaching' }
ToTextFieldGhostTextLayer >> attachTo: anEditorElement from: aWidget [

	super attachTo: anEditorElement from: aWidget.
	self flag: 'Attachement is to be evised : having a constant insets is not desirable'.
	label padding: aWidget next padding copy + (BlInsets left: 1).
	label margin: aWidget next margin copy.
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
