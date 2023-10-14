Class {
	#name : 'ToAlbumPlaceholder',
	#superclass : 'ToPlaceholderLayer',
	#instVars : [
		'label'
	],
	#category : 'Toplo-Widget-Album-TextPane',
	#package : 'Toplo-Widget-Album',
	#tag : 'TextPane'
}

{ #category : 'initialization' }
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

{ #category : 'initialization' }
ToAlbumPlaceholder >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	label := self defaultLabel.
	self addChild: label.
	self preventMeAndChildrenMouseEvents.

]

{ #category : 'accessing' }
ToAlbumPlaceholder >> text: aBlText [

	label text: aBlText
]
