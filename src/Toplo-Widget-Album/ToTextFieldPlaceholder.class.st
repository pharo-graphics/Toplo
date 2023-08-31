Class {
	#name : #ToTextFieldPlaceholder,
	#superclass : #ToAlbumPlaceholder,
	#category : #'Toplo-Widget-Album-TextField'
}

{ #category : #initialization }
ToTextFieldPlaceholder >> defaultLabel [

	^ ToLabel new
		  fitContent;
		  constraintsDo: [ :c | 
			  c frame vertical alignCenter.
			  "c frame horizontal alignLeft" ];
		  beMonoLine;
		  yourself
]

{ #category : #initialization }
ToTextFieldPlaceholder >> initialize [ 

	super initialize
]
