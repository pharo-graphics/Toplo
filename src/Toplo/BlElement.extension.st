Extension { #name : 'BlElement' }

{ #category : '*Toplo' }
BlElement >> applySkinInstaller [

	self toThemeManager applySkinInstallerIn: self
]

{ #category : '*Toplo' }
BlElement >> applySkinInstallerRecursively [

	self applySkinInstaller.
	self childrenDo: [ :child | child applySkinInstallerRecursively ]

]

{ #category : '*Toplo' }
BlElement >> borderBuilder [

	^ self toStyleSheetManager borderBuilder
]

{ #category : '*Toplo' }
BlElement >> defaultSkin [

	^ self toThemeManager defaultSkinIn: self
]

{ #category : '*Toplo' }
BlElement >> defaultSkin: aSkin [

	self toThemeManager defaultSkin: aSkin in: self
]

{ #category : '*Toplo' }
BlElement >> disable [

	self isDisabled ifFalse: [
		self flagAsDisabled.
		self dispatchEvent: ToEnablementChangedEvent new  ].
	self childrenDo: [ :child | child disable ]
]

{ #category : '*Toplo' }
BlElement >> enable [

	self isEnabled ifFalse: [
		self flagAsEnabled.
		self dispatchEvent: ToEnablementChangedEvent new ].
	self childrenDo: [ :child | child enable ]
]

{ #category : '*Toplo' }
BlElement >> flagAsDisabled [

	self userData at: #enabled put: false
]

{ #category : '*Toplo' }
BlElement >> flagAsEnabled [

	self userData at: #enabled put: true
]

{ #category : '*Toplo' }
BlElement >> hasEnablementFlag [

	^ self userData includesKey: #enabled
]

{ #category : '*Toplo' }
BlElement >> hasStamp: aSymbol [

	^ self toStyleSheetManager hasStamp: aSymbol
]

{ #category : '*Toplo' }
BlElement >> holder [

	^ self constraints infinite holder
]

{ #category : '*Toplo' }
BlElement >> initialRawStyle [
]

{ #category : '*Toplo' }
BlElement >> installRawStyle [

	self parent ifNil: [
		self spaceDo: [ :sp | self background: sp defaultRootBackground ] ]
]

{ #category : '*Toplo' }
BlElement >> installedSkin [

	^ self toThemeManager installedSkin
]

{ #category : '*Toplo' }
BlElement >> isDisabled [

	^ self isEnabled not
]

{ #category : '*Toplo' }
BlElement >> isEnabled [

	^ self userData at: #enabled ifAbsentPut: [ true ]
]

{ #category : '*Toplo' }
BlElement >> localStyleSheet [

	^ self toStyleSheetManager styleSheet 
]

{ #category : '*Toplo' }
BlElement >> localStyleStampIndex [
self flag: 'R'.
	^ self userData at: #localStyleStampIndex ifAbsent: [ ]
]

{ #category : '*Toplo' }
BlElement >> localStyleStampNamed: aSymbol [

	| index |
self flag: 'R'.
	index := self localStyleStampIndex ifNil: [ ^ nil ].
	^ index propertyNamed: aSymbol ifAbsent: [  ]
	
]

{ #category : '*Toplo' }
BlElement >> localToTheme [
self flag: 'R'.
	^ self userData at: #localToTheme ifAbsent: [  ]
]

{ #category : '*Toplo' }
BlElement >> localToTheme: aTheme [
self flag: 'R'.
	self userData at: #localToTheme put: aTheme
]

{ #category : '*Toplo' }
BlElement >> newRawSkin [

	^  ToRawSkin new
]

{ #category : '*Toplo' }
BlElement >> openInInnerWindow [

	| frame |
	frame := ToInnerWindow new.
	frame pane addChild: self.
	frame openInSpace
]

{ #category : '*Toplo' }
BlElement >> postponeRequestSkin [

	self toThemeManager postponeRequestSkinIn: self
]

{ #category : '*Toplo' }
BlElement >> removeAllStyleStamps [

	| index |
self flag: 'R'.
	index := self localStyleStampIndex ifNil: [ ^ self ].
	index removeAllProperties 
]

{ #category : '*Toplo' }
BlElement >> removeAllStyleStamps: aStyleStampCollection [

	| index |
self flag: 'R'.
	index := self localStyleStampIndex ifNil: [ ^ self ].
	aStyleStampCollection do: [ :s | index removeProperty: s ]
]

{ #category : '*Toplo' }
BlElement >> removeInstalledSkin [
self flag: 'R'.
	self skinDo: [ :s | 
		s dispatchSkinUninstallStateRequestTo: self.
		self removeEventHandler: s ]
]

{ #category : '*Toplo' }
BlElement >> removeStyleStamp: aStyleStamp [

	| index |
self flag: 'R'.
	index := self localStyleStampIndex ifNil: [ ^ self ].
	index removeProperty: aStyleStamp
]

{ #category : '*Toplo' }
BlElement >> removeStyleStampNamed: aSymbol [

	| index |
self flag: 'R'.
	index := self localStyleStampIndex ifNil: [ ^ self ].
	index removePropertyNamed: aSymbol
]

{ #category : '*Toplo' }
BlElement >> removeStyleStampNamed: aSymbol ifAbsent: anAbsentBlock [

	| index |
self flag: 'R'.
	index := self localStyleStampIndex ifNil: [ ^ self ].
	index removePropertyNamed: aSymbol ifAbsent: anAbsentBlock
]

{ #category : '*Toplo' }
BlElement >> requestSkin [

	" first check for the space phases "
self flag: 'R'.
	self space ifNil: [
		^ self postponeRequestSkin ].
	self skinInstaller ifNotNil: [ 
		^ self ].
	self space installSkinPhases.
	self skinInstaller: self toTheme newSkinInstaller
]

{ #category : '*Toplo' }
BlElement >> requestSkinRecursively [

	self childrenDo: [ :child | child requestSkinRecursively ].
	self requestSkin
]

{ #category : '*Toplo' }
BlElement >> setSkin: aSkin [
self flag: 'R'.
	self removeInstalledSkin.
	self userData at: #localDefaultSkin put: aSkin.
	self requestSkin
]

{ #category : '*Toplo' }
BlElement >> skinDo: aBlock [
self flag: 'R'.
	self installedSkin ifNil: [ ^ self ].
	aBlock value: self installedSkin
]

{ #category : '*Toplo' }
BlElement >> skinInstaller [
self flag: 'R'.
	^ self userData at: #skinInstaller ifAbsent: [  ]
]

{ #category : '*Toplo' }
BlElement >> skinInstaller: aSkinInstaller [
self flag: 'R'.
	self userData at: #skinInstaller put: aSkinInstaller
]

{ #category : '*Toplo' }
BlElement >> skinStateGeneratorClass [

	^ ToSkinStateGenerator 
]

{ #category : '*Toplo' }
BlElement >> skinStateQueue [
self flag: 'R'.
	^ self userData at: #skinStateQueue ifAbsentPut: (ToSkinStateQueue new onInstalledIn: self)
]

{ #category : '*Toplo' }
BlElement >> stampNamed: aSymbol [

	self toStyleSheetManager stampNamed: aSymbol in: self
]

{ #category : '*Toplo' }
BlElement >> stampValue: aSymbol [

	^ self toStyleSheetManager stampValue: aSymbol in: self
]

{ #category : '*Toplo' }
BlElement >> stillHoveredStartDelay [

	^ self userData at: #stillHoveredStartDelay ifAbsent: [ ]
]

{ #category : '*Toplo' }
BlElement >> stillHoveredStartDelay: aDuration [

	self userData at: #stillHoveredStartDelay put: aDuration asDuration
]

{ #category : '*Toplo' }
BlElement >> stillPressedStartDelay [

	^ self userData at: #stillPressedStartDelay ifAbsent: [ ]
]

{ #category : '*Toplo' }
BlElement >> stillPressedStartDelay: aDuration [

	self userData at: #stillPressedStartDelay put: aDuration asDuration
]

{ #category : '*Toplo-LookAndFeel' }
BlElement >> styleSheet: aStyleSheet [

	self toStyleSheetManager styleSheet: aStyleSheet in: self
]

{ #category : '*Toplo-LookAndFeel' }
BlElement >> styleSheetChain [
	" return an array with all my inherited stylesheets "
	^ self toStyleSheetManager styleSheetChainIn: self
]

{ #category : '*Toplo' }
BlElement >> switchToNextCheckStateOnClick [

	" introduced here to avoid questionable condition in SinnableEventHandler for the management of the click event "
]

{ #category : '*Toplo' }
BlElement >> toStyleSheetManager [

	^ self userData at: #toStyleSheetManager ifAbsentPut: [ ToStyleSheetManager new ]
]

{ #category : '*Toplo-LookAndFeel' }
BlElement >> toTheme [
self flag: 'R'.
	^ self localToTheme ifNil: [
		  self hasParent
			  ifTrue: [ self parent toTheme ]
			  ifFalse: [
				  self isAttachedToSceneGraph
					  ifTrue: [ " install the theme only if the root is attached to 
						avoid default installation in another element that the space root"
						
						  self localToTheme: ToTheme current.
						  self localToTheme ]
					  ifFalse: [ Error signal: 'Should never be reached' ] ] ]
]

{ #category : '*Toplo-LookAndFeel' }
BlElement >> toTheme: aTheme [
self flag: 'R'.
	self localToTheme = aTheme ifTrue: [ ^ self ].
	self localToTheme: aTheme.
	self toThemeChanged.

]

{ #category : '*Toplo-LookAndFeel' }
BlElement >> toThemeChanged [

	self childrenDo: [ :c | c toThemeChanged ].
	self dispatchEvent: ToThemeChangedEvent new.
	self requestSkin
]

{ #category : '*Toplo' }
BlElement >> toThemeManager [

	^ self userData at: #toThemeManager ifAbsentPut: [ ToThemeManager new ]
]

{ #category : '*Toplo' }
BlElement >> uninstallRawStyle [

]

{ #category : '*Toplo' }
BlElement >> updateStyles [
self flag: 'R'.
	self skinDo: [ :s | s updateStylesOn: self ]
]

{ #category : '*Toplo' }
BlElement >> updateStylesRecursively [

	self updateStyles.
	self childrenDo: [ :child | child updateStylesRecursively ]
]

{ #category : '*Toplo' }
BlElement >> withAllStamps: aCollectionOfSymbol [
self flag: 'R'.
	aCollectionOfSymbol ifEmpty: [ ^ self ].
	aCollectionOfSymbol do: [ :s | self withStamp: s ]
]

{ #category : '*Toplo' }
BlElement >> withStamp: anAssociationOrSymbol [


	self toStyleSheetManager withStamp: anAssociationOrSymbol
]

{ #category : '*Toplo' }
BlElement >> withoutAllStamps [
self flag: 'R'.
	self removeAllStyleStamps
]

{ #category : '*Toplo' }
BlElement >> withoutSkin [
self flag: 'R'.
	self setSkin: ToNullSkin new
]

{ #category : '*Toplo' }
BlElement >> withoutStamp: aSymbol [
self flag: 'R'.
	self removeStyleStampNamed: aSymbol ifAbsent: [  ]
]
