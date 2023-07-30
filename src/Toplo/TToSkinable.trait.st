Trait {
	#name : #TToSkinable,
	#instVars : [
		'privateSkin'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #'t - skin accessing' }
TToSkinable >> checkSkin [

	privateSkin ifNil: [ self initializeSkin ]
]

{ #category : #'t - skin accessing' }
TToSkinable >> defaultSkin [

	^  nil
]

{ #category : #'t - skin accessing' }
TToSkinable >> initializeSkin [

	self withSkin: self defaultSkin
]

{ #category : #'t - skin accessing' }
TToSkinable >> launchSkinInstallation [

	self privateSkin ifNotNil: [ :s | s launchSkinInstallationIn: self ]
]

{ #category : #'t - skin accessing' }
TToSkinable >> launchSkinUninstallation [

	self privateSkin ifNotNil: [ :s | s launchSkinUninstallationIn: self ]
]

{ #category : #'t - skin accessing' }
TToSkinable >> privateSkin [

	^ privateSkin
]

{ #category : #'t - skin accessing' }
TToSkinable >> privateSkin: aSkin [

	privateSkin = aSkin ifTrue: [ ^ self ].
	privateSkin := aSkin
]
