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

{ #category : #initialization }
ToTextFieldPlaceholder >> installRawStyle [ 

	super installRawStyle.
	self padding: (BlInsets
				 horizontal: (self tokenValueNamed: #'text-editor-padding-H')
				 vertical: (self tokenValueNamed: #'text-editor-padding-V'))
]
