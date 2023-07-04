Class {
	#name : #ToButtonSkin,
	#superclass : #ToElementSkin,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #initialization }
ToButtonSkin >> initialize [ 

	super initialize.
	self recursive: true
]
