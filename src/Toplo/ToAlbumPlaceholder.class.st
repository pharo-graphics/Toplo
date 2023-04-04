Class {
	#name : #ToAlbumPlaceholder,
	#superclass : #ToPanePlaceholderLayer,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #initialization }
ToAlbumPlaceholder >> defaultLabel [

	^ ToLabel new
		  constraintsDo: [ :c | 
			  c frame vertical alignCenter.
			  c frame horizontal alignCenter ];
		  beMultiLine;
		  in: [ :l | l layout alignCenter ];
		  in: [ :l | l innerElement layout alignCenter ];
		  yourself
]

{ #category : #initialization }
ToAlbumPlaceholder >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	label := self defaultLabel.
	self addChild: label.
	self preventMeAndChildrenMouseEvents.

]

{ #category : #accessing }
ToAlbumPlaceholder >> text: aBlText [

	label text: aBlText
]
