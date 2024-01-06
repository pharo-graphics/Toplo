Class {
	#name : #ToSkinInstaller,
	#superclass : #Object,
	#instVars : [
		'installing'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #hook }
ToSkinInstaller >> applyOn: anElement [
	" if there is an installed skin -> nothing to do "

	self installingWhile: [
		anElement installedSkin ifNil: [
			anElement skinToInstall ifNotNil: [ :found |
				anElement skinManager installSkin: found in: anElement.
				" apply style here directly to benefit from the installer recursion protection
				because  requestNewSkin may be sent during skin installation 
				(in that case it it ignored) "
				anElement skinManager applyEnqueuedStatesIn: anElement ] ].
		anElement skinInstaller: nil ]
]

{ #category : #initialization }
ToSkinInstaller >> initialize [ 

	super initialize.
	installing := false
]

{ #category : #accessing }
ToSkinInstaller >> installing [

	^ installing
]

{ #category : #accessing }
ToSkinInstaller >> installing: aBoolean [

	installing := aBoolean
]

{ #category : #hook }
ToSkinInstaller >> installingWhile: aBlock [

	self installing: true.	
	aBlock value.
	self installing: false
]

{ #category : #testing }
ToSkinInstaller >> isInstalling [

	^ installing
]
