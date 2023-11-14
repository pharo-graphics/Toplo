Class {
	#name : 'ToAlbumSaveRequestedEvent',
	#superclass : 'ToAlbumClientEvent',
	#instVars : [
		'unacceptedEdits'
	],
	#category : 'Toplo-Widget-Album-TextPane',
	#package : 'Toplo-Widget-Album',
	#tag : 'TextPane'
}

{ #category : 'accessing' }
ToAlbumSaveRequestedEvent >> unacceptedEdits [

	^ unacceptedEdits
]

{ #category : 'accessing' }
ToAlbumSaveRequestedEvent >> unacceptedEdits: aBoolean [

	unacceptedEdits := aBoolean
]
