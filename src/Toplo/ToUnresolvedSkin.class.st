Class {
	#name : #ToUnresolvedSkin,
	#superclass : #ToSkin,
	#classVars : [
		'Instance'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #accessing }
ToUnresolvedSkin class >> instance [ 

	^ Instance ifNil: [ Instance := self new ]
]

{ #category : #testing }
ToUnresolvedSkin >> isThemeSkin [

	^ false
]

{ #category : #testing }
ToUnresolvedSkin >> isUnresolvedSkin [

	^ true
]
