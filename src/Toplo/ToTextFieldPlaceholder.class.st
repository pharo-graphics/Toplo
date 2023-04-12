Class {
	#name : #ToTextFieldPlaceholder,
	#superclass : #ToAlbumPlaceholder,
	#category : #'Toplo-Widget-TextField'
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

	super initialize.
	self padding: (BlInsets left: 3)
]
