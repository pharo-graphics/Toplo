Class {
	#name : 'ToThemeManager',
	#superclass : 'Object',
	#instVars : [
		'styleSheetManager',
		'skinInstaller',
		'localDefaultSkin',
		'localTheme',
		'postponedRequestSkin',
		'installedSkin',
		'skinStateQueue'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'skin application' }
ToThemeManager >> applySkinInstallerOn: anElement [

	self skinInstaller ifNotNil: [ :si | si applyOn: anElement ]
	
]

{ #category : 'accessing - skin' }
ToThemeManager >> defaultSkin: aSkin in: anElement [

	| prev |
	prev := self localDefaultSkin ifAbsent: [  ].
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
ToThemeManager >> localToTheme [ 

	^ localTheme
]

{ #category : 'accessing' }
ToThemeManager >> localToTheme: aTheme [

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
ToThemeManager >> removeInstalledSkinIn: anElement [

	self skinDo: [ :s |
		s dispatchSkinUninstallStateRequestTo: anElement.
		anElement updateStyles.
		anElement removeEventHandler: s ]
]

{ #category : 'accessing - skin' }
ToThemeManager >> requestSkinIn: anElement [

	" first check for the space phases "
	anElement space ifNil: [
		^ self postponeRequestSkinIn: anElement ].
	self skinInstaller ifNotNil: [ 
		^ self ].
	anElement space installSkinPhases.
	self skinInstaller: anElement toTheme newSkinInstaller
]

{ #category : 'accessing - skin' }
ToThemeManager >> setSkin: aSkin in: anElement [

	self removeInstalledSkinIn: anElement.
	localDefaultSkin := aSkin.
	anElement requestSkin
]

{ #category : 'accessing - skin' }
ToThemeManager >> skinDo: aBlock [

	self installedSkin ifNil: [ ^ self ].
	aBlock value: self installedSkin
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
ToThemeManager >> skinStateQueueIn: anElement [

	^ skinStateQueue ifNil: [
		  skinStateQueue := ToSkinStateQueue new onInstalledIn: anElement ]
]

{ #category : 'accessing' }
ToThemeManager >> toTheme: aTheme in: anElement [

	self localToTheme = aTheme ifTrue: [ ^ self ].
	self localToTheme: aTheme.
	anElement toThemeChanged.

]

{ #category : 'accessing' }
ToThemeManager >> toThemeIn: anElement [

	^ self localToTheme ifNil: [
		  anElement hasParent
			  ifTrue: [ anElement parent toTheme ]
			  ifFalse: [
				  anElement isAttachedToSceneGraph
					  ifTrue: [ " install the theme only if the root is attached to 
						avoid default installation in another element than the space root"
						  self localToTheme: ToTheme current.
						  self localToTheme ]
					  ifFalse: [ Error signal: 'An element not attached should not ask for its theme' ] ] ]
]

{ #category : 'accessing - skin' }
ToThemeManager >> updateStylesOn: anElement [

	self skinStateQueue applyOn: anElement
]

{ #category : 'accessing - skin' }
ToThemeManager >> withoutSkinIn: anElement [

	self setSkin: ToNullSkin new in: anElement
]
