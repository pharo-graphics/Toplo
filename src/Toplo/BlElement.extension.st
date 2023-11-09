Extension { #name : 'BlElement' }

{ #category : '*Toplo' }
BlElement >> applySkinInstaller [

	self toThemeManager applySkinUninstallerIn: self.
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
BlElement >> installedSkinDo: aBlock [

	self toThemeManager installedSkinDo: aBlock
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
BlElement >> requestSkin [

	" first check for the space phases "
	self toThemeManager requestSkinIn: self 
]

{ #category : '*Toplo' }
BlElement >> requestSkinRecursively [

	self childrenDo: [ :child | child requestSkinRecursively ].
	self requestSkin
]

{ #category : '*Toplo' }
BlElement >> requestUninstallSkin [

	" first check for the space phases "
	self toThemeManager requestUninstallSkinIn: self 
]

{ #category : '*Toplo' }
BlElement >> setSkin: aSkin [

	self toThemeManager setSkin: aSkin in: self
]

{ #category : '*Toplo' }
BlElement >> skinInstaller [

	^ self toThemeManager skinInstaller 
]

{ #category : '*Toplo' }
BlElement >> skinInstaller: aSkinInstaller [

	self toThemeManager skinInstaller: aSkinInstaller
]

{ #category : '*Toplo' }
BlElement >> skinStateGeneratorClass [

	^ ToSkinStateGenerator 
]

{ #category : '*Toplo' }
BlElement >> skinStateQueue [

	^ self toThemeManager skinStateQueueIn: self
]

{ #category : '*Toplo' }
BlElement >> skinUninstaller: aSkinUninstaller [

	self toThemeManager skinUninstaller: aSkinUninstaller
]

{ #category : '*Toplo' }
BlElement >> stampNamed: aSymbol [

	^ self toStyleSheetManager stampNamed: aSymbol in: self
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
BlElement >> textAttributesBuilder [

	^ self toStyleSheetManager textAttributesBuilder
]

{ #category : '*Toplo' }
BlElement >> toStyleSheetManager [

	^ self userData at: #toStyleSheetManager ifAbsentPut: [ ToStyleSheetManager new ]
]

{ #category : '*Toplo-LookAndFeel' }
BlElement >> toTheme [

		^ self toThemeManager toThemeIn: self
]

{ #category : '*Toplo-LookAndFeel' }
BlElement >> toTheme: aTheme [

	self toThemeManager toTheme: aTheme in: self
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

	self toThemeManager updateStylesIn: self
]

{ #category : '*Toplo' }
BlElement >> updateStylesRecursively [

	self updateStyles.
	self childrenDo: [ :child | child updateStylesRecursively ]
]

{ #category : '*Toplo' }
BlElement >> withAllStamps: aCollectionOfSymbol [

	self toStyleSheetManager withAllStamps: aCollectionOfSymbol
]

{ #category : '*Toplo' }
BlElement >> withStamp: anAssociationOrSymbol [


	self toStyleSheetManager withStamp: anAssociationOrSymbol
]

{ #category : '*Toplo' }
BlElement >> withoutAllStamps [

	self toStyleSheetManager removeAllStyleStamps
]

{ #category : '*Toplo' }
BlElement >> withoutSkin [

	self toThemeManager setSkin: ToNullSkin new in: self
]

{ #category : '*Toplo' }
BlElement >> withoutStamp: aSymbol [

	self toStyleSheetManager withoutStamp: aSymbol
]
