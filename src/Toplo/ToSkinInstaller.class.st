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
		anElement skinManagerDo: [ :sm |
			sm installedSkin ifNil: [
				(sm skinToInstallIn: anElement) ifNotNil: [ :skin |
					anElement dispatchEvent: (ToInstallSkinEvent new
							 skin: skin;
							 yourself).
					" apply style here directly to benefit from the installer recursion protection
					because  requestNewSkin may be sent during skin installation 
					(in that case it it ignored) "
					sm applyEnqueuedStatesIn: anElement ] ].
			" check skin installation "
			(sm installedSkin isNil and: [
				 sm postponedInstallSkinHandler isNil ]) ifTrue: [
				Error signal: 'A ToSkinManager has an invalid state' ].
			sm setSkinInstaller: nil in: anElement ] ]
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
