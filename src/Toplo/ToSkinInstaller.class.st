Class {
	#name : #ToSkinInstaller,
	#superclass : #Object,
	#instVars : [
		'renew'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #hook }
ToSkinInstaller >> applyOn: anElement [

	anElement skinInstaller: nil.
	anElement installedSkin ifNotNil: [ :s |
		renew ifFalse: [ ^ anElement dispatchSkinChangedEvent ].
		anElement removeEventHandler: s ].
	anElement defaultSkin ifNotNil: [ :found |
		anElement installedSkin: found.
		anElement addEventHandler: found.
		anElement dispatchSkinChangedEvent ]
]

{ #category : #initialization }
ToSkinInstaller >> initialize [ 

	super initialize.
	renew := false
]

{ #category : #accessing }
ToSkinInstaller >> renew: aBoolean [

	renew := aBoolean
]
