Class {
	#name : #ToAlbumPlaceholder,
	#superclass : #ToPlaceholderLayer,
	#instVars : [
		'label'
	],
	#category : 'Toplo-Widget-Album-TextPane'
}

{ #category : #initialization }
ToAlbumPlaceholder >> defaultLabel [

	^ ToLabel new
		  constraintsDo: [ :c |
			  c frame vertical alignCenter.
			  c frame horizontal alignCenter ];
		  beMultiLine;
		  in: [ :l |
			  l layout alignCenter.
			  l innerElement layout alignCenter ];
		  yourself
]

{ #category : #initialization }
ToAlbumPlaceholder >> initialize [

	super initialize.
	label := self defaultLabel.
	self addChild: label.
	self constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self preventMeAndChildrenMouseEvents
]

{ #category : #accessing }
ToAlbumPlaceholder >> text: aBlText [

	label text: aBlText
]
