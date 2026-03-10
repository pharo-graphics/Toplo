Class {
	#name : #ToUnknownSkin,
	#superclass : #ToSkin,
	#classVars : [
		'Instance'
	],
	#category : #'Toplo-Theme-Skin'
}

{ #category : #accessing }
ToUnknownSkin class >> instance [ 

	^ Instance ifNil: [ Instance := self new ]
]

{ #category : #testing }
ToUnknownSkin >> isThemeSkin [

	^ false
]

{ #category : #testing }
ToUnknownSkin >> isUnknownSkin [ 

	^ true
]
