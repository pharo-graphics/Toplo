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
					sm installSkin: skin in: anElement ].
				" check skin installation "
				self checkSkinInstallationOn: anElement.
				" apply style here directly to benefit from the installer recursion protection
					because  requestNewSkin may be sent during skin installation 
					(in that case it it ignored) "
				sm applyEnqueuedStatesIn: anElement ].
			sm setSkinInstaller: nil in: anElement ] ]
]

{ #category : #hook }
ToSkinInstaller >> checkSkinInstallationOn: anElement [


	anElement skinManagerDo: [ :sm | " check skin installation "
		(sm installedSkin isNil and: [ sm postponedInstallSkinHandler isNil ])
			ifTrue: [ Error signal: 'A ToSkinManager has an invalid state' ] ]
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

	self isInstalling ifTrue: [ ^ self ].
	self installing: true.
	aBlock ensure: [ self installing: false ]
]

{ #category : #testing }
ToSkinInstaller >> isInstalling [

	^ installing
]
