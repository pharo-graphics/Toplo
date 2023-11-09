Class {
	#name : 'ToThemeManager',
	#superclass : 'Object',
	#instVars : [
		'skinInstaller',
		'localDefaultSkin',
		'localTheme',
		'postponedRequestSkin',
		'installedSkin',
		'skinStateQueue',
		'skinUninstaller'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'skin application' }
ToThemeManager >> applySkinInstallerIn: anElement [

	self skinInstaller ifNotNil: [ :si | si applyOn: anElement ]
	
]

{ #category : 'skin application' }
ToThemeManager >> applySkinUninstallerIn: anElement [

	self skinUninstaller ifNotNil: [ :su | su applyOn: anElement ]
	
]

{ #category : 'accessing - skin' }
ToThemeManager >> defaultSkin: aSkin in: anElement [

	self localDefaultSkin = aSkin ifTrue: [ ^ self ].
	self setSkin: aSkin in: anElement

]

{ #category : 'accessing - skin' }
ToThemeManager >> defaultSkinIn: anElement [

	^ localDefaultSkin ifNil: [ anElement toTheme newSkinFor: anElement ]
]

{ #category : 'initialization' }
ToThemeManager >> initialize [ 

	super initialize.
]

{ #category : 'accessing - skin' }
ToThemeManager >> installedSkin [

	" set from the ToSkin>>onInstalledIn: and ToSkin>>onUninstalledIn: with my #installedSkin: accessor"
	^ installedSkin
]

{ #category : 'accessing - skin' }
ToThemeManager >> installedSkin: aSkin [

	" send from the ToSkin>>onInstalledIn: and ToSkin>>onUninstalledIn: "
	installedSkin := aSkin
]

{ #category : 'accessing - skin' }
ToThemeManager >> installedSkinDo: aBlock [

	self installedSkin ifNil: [ ^ self ].
	aBlock value: self installedSkin
]

{ #category : 'accessing - skin' }
ToThemeManager >> isRequestSkinPostponed [

	
	^ postponedRequestSkin notNil
]

{ #category : 'accessing - skin' }
ToThemeManager >> localDefaultSkin [

	^ localDefaultSkin
]

{ #category : 'accessing - skin' }
ToThemeManager >> localDefaultSkin: aSkin [

	localDefaultSkin := aSkin
]

{ #category : 'accessing' }
ToThemeManager >> localTheme [ 

	^ localTheme
]

{ #category : 'accessing' }
ToThemeManager >> localTheme: aTheme [

	localTheme := aTheme
]

{ #category : 'accessing - skin' }
ToThemeManager >> postponeRequestSkinIn: anElement [

	self isRequestSkinPostponed ifTrue: [ ^ self ].
	postponedRequestSkin := BlEventHandler new.
	postponedRequestSkin eventClass: BlElementAddedToSceneGraphEvent.
	postponedRequestSkin action: [ :evt |
		evt target removeEventHandler: postponedRequestSkin.
		postponedRequestSkin := nil.
		evt target requestSkin ].
	anElement addEventHandler: postponedRequestSkin
]

{ #category : 'accessing - skin' }
ToThemeManager >> requestSkinIn: anElement [

	" first check for the space phases "
	anElement space ifNil: [
		^ self postponeRequestSkinIn: anElement ].
	self skinInstaller ifNotNil: [ 
		^ self ].
	anElement space installSkinPhases.
	self skinInstaller: ToSkinInstaller new
]

{ #category : 'accessing - skin' }
ToThemeManager >> requestUninstallSkinIn: anElement [

	self skinUninstaller ifNotNil: [ 
		^ self ].
	self skinUninstaller: ToSkinUninstaller new
]

{ #category : 'accessing - skin' }
ToThemeManager >> setSkin: aSkin in: anElement [

	anElement requestUninstallSkin.
	localDefaultSkin := aSkin.
	anElement requestSkin
]

{ #category : 'accessing' }
ToThemeManager >> skinInstaller [ 

	^ skinInstaller 
]

{ #category : 'accessing' }
ToThemeManager >> skinInstaller: aSkinInstaller [

	skinInstaller := aSkinInstaller 
]

{ #category : 'accessing' }
ToThemeManager >> skinStateQueue [

	^ skinStateQueue
]

{ #category : 'accessing' }
ToThemeManager >> skinStateQueueIn: anElement [

	^ skinStateQueue ifNil: [
		  skinStateQueue := ToSkinStateQueue new onInstalledIn: anElement ]
]

{ #category : 'accessing' }
ToThemeManager >> skinUninstaller [

	^ skinUninstaller
]

{ #category : 'accessing' }
ToThemeManager >> skinUninstaller: aSkinUninstaller [

	skinUninstaller := aSkinUninstaller 
]

{ #category : 'accessing' }
ToThemeManager >> toTheme: aTheme in: anElement [

	self localTheme = aTheme ifTrue: [ ^ self ].
	self localTheme: aTheme.
	anElement toThemeChanged.

]

{ #category : 'accessing' }
ToThemeManager >> toThemeIn: anElement [

	^ self localTheme ifNil: [
		  anElement hasParent
			  ifTrue: [ anElement parent toTheme ]
			  ifFalse: [
				  anElement isAttachedToSceneGraph
					  ifTrue: [ " install the theme only if the root is attached to 
						avoid default installation in another element than the space root"
						  self localTheme: ToTheme current.
						  self localTheme ]
					  ifFalse: [ Error signal: 'A not attached element should not ask for its theme' ] ] ]
]

{ #category : 'accessing - skin' }
ToThemeManager >> updateStylesIn: anElement [

	self installedSkinDo: [ :s | s updateStylesIn: anElement ]
]
