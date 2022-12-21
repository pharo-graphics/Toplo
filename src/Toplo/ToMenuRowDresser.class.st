Class {
	#name : #ToMenuRowDresser,
	#superclass : #ToMenuItemRowDresser,
	#instVars : [
		'rightIcon'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuRowDresser >> rightIconIn: anElement [

	^ rightIcon ifNil: [ 
		  rightIcon := ToImage new
			               innerImage: anElement rightIconImage;
			               hExact: 15;
			               in: [ :im | im layout alignCenterRight ];
			               yourself ]
]

{ #category : #'api - install/uninstall  hook' }
ToMenuRowDresser >> rowLayingOutIn: anElement [

	| la ic |
	la := anElement label text
		      ifNotEmpty: [ anElement label ]
		      ifEmpty: [ nil ].
	ic := anElement icon hasInnerImage
		      ifTrue: [ anElement icon ]
		      ifFalse: [ nil ].

	anElement isSubmenu ifTrue: [ 
		^ { 
			  ic.
			  interspace.
			  la.
			  anElement privateMatchParentFill.
			  (self rightIconIn: anElement) } select: #notNil ].

	^ super rowLayingOutIn: anElement
]
