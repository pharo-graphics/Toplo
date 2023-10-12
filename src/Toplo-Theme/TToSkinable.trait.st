Trait {
	#name : #TToSkinable,
	#category : #'Toplo-Theme-Core'
}

{ #category : #'t - skinable - install/uninstall  hook' }
TToSkinable >> launchSkinInstallation [

	self privateSkin ifNotNil: [ :s | s launchSkinInstallationIn: self ]
]

{ #category : #'t - skinable - install/uninstall  hook' }
TToSkinable >> launchSkinUninstallation [

	self privateSkin ifNotNil: [ :s | s launchSkinUninstallationIn: self ]
]

{ #category : #'t - skinable - initialization' }
TToSkinable >> updateSkin [

	self withSkin: self defaultSkin.
	self requestLayout
]
