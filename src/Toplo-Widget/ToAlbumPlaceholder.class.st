Class {
	#name : #ToAlbumPlaceholder,
	#superclass : #ToPlaceholderLayer,
	#category : #'Toplo-Widget-Album'
}

{ #category : #initialization }
ToAlbumPlaceholder >> initialize [

	super initialize.
	self layout alignCenter.
	self focusability: BlFocusability none
]
