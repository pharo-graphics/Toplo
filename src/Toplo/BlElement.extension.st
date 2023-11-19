Extension { #name : #BlElement }

{ #category : #'*Toplo' }
BlElement >> applySkinInstaller [

	self skinManager applySkinUninstallerIn: self.
	self skinManager applySkinInstallerIn: self
]

{ #category : #'*Toplo' }
BlElement >> applySkinInstallerRecursively [

	self childrenDo: [ :child | child applySkinInstallerRecursively ].
	self applySkinInstaller.


]

{ #category : #'*Toplo' }
BlElement >> applyStyles [

	self skinManager applyStylesIn: self
]

{ #category : #'*Toplo' }
BlElement >> applyStylesRecursively [

	self childrenDo: [ :child | child applyStylesRecursively ].
	self applyStyles.

]

{ #category : #'*Toplo' }
BlElement >> borderBuilder [

	^ self toStyleStore borderBuilder
]

{ #category : #'*Toplo' }
BlElement >> defaultSkin [

	^ self skinManager defaultSkinIn: self
]

{ #category : #'*Toplo' }
BlElement >> defaultSkin: aSkin [

	self skinManager defaultSkin: aSkin in: self
]

{ #category : #'*Toplo' }
BlElement >> disable [

	self isDisabled ifFalse: [
		self flagAsDisabled.
		self dispatchEvent: ToEnablementChangedEvent new  ].
	self childrenDo: [ :child | child disable ]
]

{ #category : #'*Toplo' }
BlElement >> enable [

	self isEnabled ifFalse: [
		self flagAsEnabled.
		self dispatchEvent: ToEnablementChangedEvent new ].
	self childrenDo: [ :child | child enable ]
]

{ #category : #'*Toplo' }
BlElement >> enqueueSkinState: aSkinState [

	self skinManager enqueueState: aSkinState for: self 
]

{ #category : #'*Toplo' }
BlElement >> flagAsDisabled [

	self userData at: #enabled put: false
]

{ #category : #'*Toplo' }
BlElement >> flagAsEnabled [

	self userData at: #enabled put: true
]

{ #category : #'*Toplo' }
BlElement >> hasEnablementFlag [

	^ self userData includesKey: #enabled
]

{ #category : #'*Toplo' }
BlElement >> hasStampNamed: aSymbol [

	^ self toStyleStore hasStampNamed: aSymbol
]

{ #category : #'*Toplo' }
BlElement >> holder [

	^ self constraints infinite holder
]

{ #category : #'*Toplo' }
BlElement >> initialRawStyle [
]

{ #category : #'*Toplo' }
BlElement >> installRawStyle [

	self parent ifNil: [
		self spaceDo: [ :sp | self background: sp defaultRootBackground ] ]
]

{ #category : #'*Toplo' }
BlElement >> installedSkin [

	^ self skinManager installedSkin
]

{ #category : #'*Toplo' }
BlElement >> installedSkinDo: aBlock [

	self skinManager installedSkinDo: aBlock
]

{ #category : #'*Toplo' }
BlElement >> isDisabled [

	^ self isEnabled not
]

{ #category : #'*Toplo' }
BlElement >> isEnabled [

	^ self userData at: #enabled ifAbsentPut: [ true ]
]

{ #category : #'*Toplo' }
BlElement >> localToTheme [

	^ self skinManager localTheme
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> localToTheme: aTheme [

	self skinManager localTheme: aTheme in: self.
	self spaceDo: [:sp | sp requestNextPulse ] 
]

{ #category : #'*Toplo' }
BlElement >> newRawSkin [

	^  ToRawSkin new
]

{ #category : #'*Toplo' }
BlElement >> openInInnerWindow [

	| frame |
	frame := ToInnerWindow new.
	frame pane addChild: self.
	frame openInSpace
]

{ #category : #'*Toplo' }
BlElement >> requestInstallSkin [

	" first check for the space phases "
	self skinManager requestInstallSkinIn: self 
]

{ #category : #'*Toplo' }
BlElement >> requestNewSkin [

	self requestUninstallSkin.
	self requestInstallSkin.
	self spaceDo: [ :sp | sp requestNextPulse ]
]

{ #category : #'*Toplo' }
BlElement >> requestNewSkinRecursively [

	self childrenDo: [ :child | child requestNewSkinRecursively ].
	self requestNewSkin 
]

{ #category : #'*Toplo' }
BlElement >> requestUninstallSkin [

	self skinManager requestUninstallSkinIn: self 
]

{ #category : #'*Toplo' }
BlElement >> setSkin: aSkin [

	self skinManager setSkin: aSkin in: self
]

{ #category : #'*Toplo' }
BlElement >> skinInstaller [

	^ self skinManager skinInstaller 
]

{ #category : #'*Toplo' }
BlElement >> skinInstaller: aSkinInstaller [

	self skinManager skinInstaller: aSkinInstaller
]

{ #category : #'*Toplo' }
BlElement >> skinManager [

	^ self userData at: #skinManager ifAbsentPut: [ ToSkinManager new ]
]

{ #category : #'*Toplo' }
BlElement >> skinStateGeneratorClass [

	^ ToSkinStateGenerator 
]

{ #category : #'*Toplo' }
BlElement >> skinStateQueue [

	^ self skinManager skinStateQueue
]

{ #category : #'*Toplo' }
BlElement >> skinUninstaller [

	^ self skinManager skinUninstaller 
]

{ #category : #'*Toplo' }
BlElement >> skinUninstaller: aSkinUninstaller [

	self skinManager skinUninstaller: aSkinUninstaller
]

{ #category : #'*Toplo' }
BlElement >> stampNamed: aSymbol [

	^ self toStyleStore stampNamed: aSymbol in: self
]

{ #category : #'*Toplo' }
BlElement >> stampValue: aSymbol [

	^ self toStyleStore stampValue: aSymbol in: self
]

{ #category : #'*Toplo' }
BlElement >> stillHoveredStartDelay [

	^ self userData at: #stillHoveredStartDelay ifAbsent: [ ]
]

{ #category : #'*Toplo' }
BlElement >> stillHoveredStartDelay: aDuration [

	self userData at: #stillHoveredStartDelay put: aDuration asDuration
]

{ #category : #'*Toplo' }
BlElement >> stillPressedStartDelay [

	^ self userData at: #stillPressedStartDelay ifAbsent: [ ]
]

{ #category : #'*Toplo' }
BlElement >> stillPressedStartDelay: aDuration [

	self userData at: #stillPressedStartDelay put: aDuration asDuration
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> styleSheet: aStyleSheet [

	self toStyleStore styleSheet: aStyleSheet in: self
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> styleSheetChain [
	" return an array with all my inherited stylesheets "
	^ self toStyleStore styleSheetChainIn: self
]

{ #category : #'*Toplo' }
BlElement >> switchToNextCheckStateOnClick [

	" introduced here to avoid questionable condition in SinnableEventHandler for the management of the click event "
]

{ #category : #'*Toplo' }
BlElement >> textAttributesBuilder [

	^ self toStyleStore textAttributesBuilder
]

{ #category : #'*Toplo' }
BlElement >> toStyleStore [

	^ self userData at: #toStyleStore ifAbsentPut: [ ToStyleStore new onInstalledIn: self; yourself]
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toTheme [

		^ self skinManager lookupThemeFrom: self
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toTheme: aTheme [

	self deprecated: 'Use #localToTheme: ' transformWith: '`@rcv toTheme: `@arg' -> '`@rcv localToTheme: `@arg'.
	self localToTheme: aTheme
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toThemeChanged [

	self childrenDo: [ :c | c toThemeChanged ].
	self dispatchEvent: ToThemeChangedEvent new.
	self requestNewSkin.
]

{ #category : #'*Toplo' }
BlElement >> uninstallRawStyle [

]

{ #category : #'*Toplo' }
BlElement >> withAllStamps: aCollectionOfSymbol [

	self toStyleStore withAllStamps: aCollectionOfSymbol
]

{ #category : #'*Toplo' }
BlElement >> withStamp: anAssociationOrSymbol [


	self toStyleStore withStamp: anAssociationOrSymbol
]

{ #category : #'*Toplo' }
BlElement >> withoutAllStamps [

	self toStyleStore removeAllStamps
]

{ #category : #'*Toplo' }
BlElement >> withoutSkin [

	self skinManager setSkin: ToNullSkin new in: self
]

{ #category : #'*Toplo' }
BlElement >> withoutStamp: aSymbol [

	self toStyleStore withoutStamp: aSymbol
]
