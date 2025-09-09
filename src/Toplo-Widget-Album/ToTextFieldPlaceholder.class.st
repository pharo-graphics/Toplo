Class {
	#name : #ToTextFieldPlaceholder,
	#superclass : #ToAlbumPlaceholder,
	#category : #'Toplo-Widget-Album-TextField'
}

{ #category : #initialization }
ToTextFieldPlaceholder >> initialize [

	super initialize.
	self layout alignCenterLeft
]

{ #category : #skin }
ToTextFieldPlaceholder >> installRawStyle [

	super installRawStyle.
	self flag:
		'Have to dig why a + 1 is required here to have the placeholder content exactly at the same x-ordinate than the first edited character'.
	self padding: (BlInsets
			 horizontal: (self valueOfTokenNamed: #'padding-XS') + 2
			 vertical: (self valueOfTokenNamed: #'text-editor-padding-V'))
]
