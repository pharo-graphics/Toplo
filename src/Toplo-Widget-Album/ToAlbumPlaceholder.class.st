Class {
	#name : #ToAlbumPlaceholder,
	#superclass : #ToPlaceholderLayer,
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #initialization }
ToAlbumPlaceholder >> initialize [

	super initialize.
	self layout alignCenter.
	self focusability: BlFocusability none
]

{ #category : #skin }
ToAlbumPlaceholder >> installRawStyle [

	super installRawStyle.
	self addTokenNamed: #'color-text' withValue: (self valueOfTokenNamed: #'color-text-placeholder').
]

{ #category : #skin }
ToAlbumPlaceholder >> uninstallRawStyle [

	self removeTokenNamed: #'color-text'.
	super uninstallRawStyle.

]
