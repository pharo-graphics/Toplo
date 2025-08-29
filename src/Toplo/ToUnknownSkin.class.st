Class {
	#name : #ToUnknownSkin,
	#superclass : #ToSkin,
	#classVars : [
		'Instance'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #accessing }
ToUnknownSkin class >> instance [ 

	^ Instance ifNil: [ Instance := self new ]
]

{ #category : #adding }
ToUnknownSkin >> addSkinStateGeneration: aValuable for: anElement [

	aValuable value
]

{ #category : #testing }
ToUnknownSkin >> isUnknownSkin [ 

	^ true
]

{ #category : #installing }
ToUnknownSkin >> replaceSkinIn: anElement withSkinManager: aSkinManager [

	(aSkinManager skinToInstallIn: anElement) ifNotNil: [ :skin |
		aSkinManager installSkin: skin in: anElement ].
	" check skin installation "
	aSkinManager installedSkin isUnknownSkin ifTrue: [
		Error signal: 'The skin remains unknown' ].
	" apply style here directly to benefit from the installer recursion protection
					because  requestNewSkin may be sent during skin installation 
					(in that case it it ignored) "
	aSkinManager applyEnqueuedStatesIn: anElement
]
