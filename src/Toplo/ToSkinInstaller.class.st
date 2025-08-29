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
					sm installedSkin replaceSkinIn: anElement withSkinManager: sm.
					sm onSkinInstallerApplied ] ]
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
