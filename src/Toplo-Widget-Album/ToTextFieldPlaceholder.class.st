Class {
	#name : #ToTextFieldPlaceholder,
	#superclass : #ToAlbumPlaceholder,
	#category : 'Toplo-Widget-Album-TextField'
}

{ #category : #initialization }
ToTextFieldPlaceholder >> defaultLabel [

	^ ToLabel new
		  fitContent;
		  beMonoLine;
		  yourself
]

{ #category : #initialization }
ToTextFieldPlaceholder >> initialize [

	super initialize.
	self constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter ].

]
