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
ToMenuRowDresser >> rowLayoutIn: anElement [
	anElement isSubmenu ifTrue: [
		^ { 
			  anElement icon.
			  interspace.
			  anElement label.
			  anElement privateMatchParentFill.
			  self rightIconIn: anElement } select: #notNil ].

	^ super rowLayoutIn: anElement
]
