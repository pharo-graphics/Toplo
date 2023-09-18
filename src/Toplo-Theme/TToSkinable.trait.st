Trait {
	#name : #TToSkinable,
	#instVars : [
		'privateSkin',
		'currentSkinState'
	],
	#category : #'Toplo-Theme-Skin'
}

{ #category : #'t - skinable - accessing' }
TToSkinable >> currentSkinState [

	^ currentSkinState
]

{ #category : #'t - skinable - accessing' }
TToSkinable >> currentSkinState: aState [

	currentSkinState := aState
]

{ #category : #'t - skinable - initialization' }
TToSkinable >> defaultSkin [

	^  self userData at: #defaultSkin ifAbsent: [self toTheme skinFor: self]
]

{ #category : #'t - skinable - initialization' }
TToSkinable >> defaultSkin: aSkin [

	self userData at: #defaultSkin put: aSkin
]

{ #category : #'t - skinable - initialization' }
TToSkinable >> defaultStyleClasses [

	^ self explicitRequirement 
]

{ #category : #'t - skinable - initialization' }
TToSkinable >> initializeSkin [

	self styleClasses ifEmpty: [ self styleClasses: self defaultStyleClasses].
	"self withSkin: self defaultSkin"
]

{ #category : #'t - skinable - install/uninstall  hook' }
TToSkinable >> launchSkinInstallation [

	self privateSkin ifNotNil: [ :s | s launchSkinInstallationIn: self ]
]

{ #category : #'t - skinable - install/uninstall  hook' }
TToSkinable >> launchSkinUninstallation [

	self privateSkin ifNotNil: [ :s | s launchSkinUninstallationIn: self ]
]

{ #category : #'t - skinable - accessing' }
TToSkinable >> privateSkin [

	^ privateSkin
]

{ #category : #'t - skinable - accessing' }
TToSkinable >> privateSkin: aSkin [

	privateSkin = aSkin ifTrue: [ ^ self ].
	privateSkin := aSkin
]

{ #category : #'t - skinable - initialization' }
TToSkinable >> updateSkin [

	self withSkin: self defaultSkin
]
