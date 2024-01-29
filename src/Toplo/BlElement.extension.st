Extension { #name : #BlElement }

{ #category : #'*Toplo' }
BlElement >> addAllStamps: aCollectionOfSymbol [

	self ensuredToStyleStore addAllStamps: aCollectionOfSymbol
]

{ #category : #'*Toplo' }
BlElement >> addAllTokenProperties: aTokenPropertyCollection [

	self ensuredToStyleStore addAllTokenProperties: aTokenPropertyCollection
]

{ #category : #'*Toplo' }
BlElement >> addStamp: aSymbol [


	self ensuredToStyleStore addStamp: aSymbol
]

{ #category : #'*Toplo' }
BlElement >> addStamp: aSymbol value: anObject [


	self ensuredToStyleStore addStamp: aSymbol value: anObject
]

{ #category : #'*Toplo' }
BlElement >> allStamps [

	^ self toStyleStore
		  ifNil: [ #(  ) ]
		  ifNotNil: [ :tst | tst allStamps ]
]

{ #category : #'*Toplo' }
BlElement >> applyEnqueuedStates [

	self skinManagerDo: [ :sm | sm  applyEnqueuedStatesIn: self ]
]

{ #category : #'*Toplo' }
BlElement >> applyEnqueuedStatesRecursively [

	self childrenDo: [ :child | child applyEnqueuedStatesRecursively ].
	self applyEnqueuedStates
]

{ #category : #'*Toplo' }
BlElement >> applySkinInstaller [

	self skinManagerDo: [ :sm |
		sm applySkinUninstallerIn: self.
		sm applySkinInstallerIn: self ]
]

{ #category : #'*Toplo' }
BlElement >> applySkinInstallerOnFirstRequest: aBoolean [

	self skinManagerDo: [ :sm | sm  applySkinInstallerOnFirstRequest: aBoolean ]
]

{ #category : #'*Toplo' }
BlElement >> applySkinInstallerRecursively [

	self childrenDo: [ :child | child applySkinInstallerRecursively ].
	self applySkinInstaller.


]

{ #category : #'*Toplo' }
BlElement >> borderBuilder [

	self skinManagerDo: [ :sm | ^ sm  borderBuilder ].
	^ nil
]

{ #category : #'*Toplo' }
BlElement >> defaultButterflySkin [

	self skinManagerDo: [ :sm | ^ sm  defaultButterflySkin ].
	^ nil
]

{ #category : #'*Toplo' }
BlElement >> defaultRawSkin [

	self skinManagerDo: [ :sm | ^ sm  defaultRawSkin ].
	^ nil
]

{ #category : #'*Toplo' }
BlElement >> defaultRawSkin: aSkin [

	self ensuredSkinManager setDefaultRawSkin: aSkin in: self
]

{ #category : #'*Toplo' }
BlElement >> defaultSkin [

	self skinManagerDo: [ :sm | ^ sm  defaultSkin ].
	^ nil
]

{ #category : #'*Toplo' }
BlElement >> defaultSkin: aSkin [

	self ensuredSkinManager setDefaultSkin: aSkin in: self
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
BlElement >> ensureCanManageSkin [

	self ensureHaveSkinManager.
	self addEventHandler: ToSkinStateGenerator new.
	self addEventHandler: ToElementInitializeEventHandler new
]

{ #category : #'*Toplo' }
BlElement >> ensureHaveSkinManager [

	self userData at: #skinManager ifAbsentPut: [
		ToSkinManager new
			onInstalledIn: self;
			yourself ]
]

{ #category : #'*Toplo' }
BlElement >> ensuredSkinManager [

	self ensureHaveSkinManager.
	^ self userData at: #skinManager
]

{ #category : #'*Toplo' }
BlElement >> ensuredToStyleStore [

	^ self userData at: #toStyleStore ifAbsentPut: [ ToStyleStore new onInstalledIn: self; yourself]
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
BlElement >> hasStamp: aSymbol [

	^ self toStyleStore
		  ifNil: [ false ]
		  ifNotNil: [ :tst | tst hasStamp: aSymbol ]
]

{ #category : #'*Toplo' }
BlElement >> holder [

	^ self constraints infinite holder
]

{ #category : #'*Toplo' }
BlElement >> installRawStyle [

	
]

{ #category : #'*Toplo' }
BlElement >> installedSkin [

	self skinManagerDo: [ :sm | ^ sm installedSkin ].
	^ nil
]

{ #category : #'*Toplo' }
BlElement >> installedSkinDo: aBlock [

	self 	skinManagerDo: [ :sm | sm installedSkinDo: aBlock ]
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
BlElement >> removeAllStamps [

	self toStyleStoreDo: [ :tst | tst removeAllStamps ]
]

{ #category : #'*Toplo' }
BlElement >> removeAllTokenPropertiesFromNames: aCollection [

	self toStyleStoreDo: [ :tst |
		tst removeAllTokenPropertiesFromNames: aCollection ]
]

{ #category : #'*Toplo' }
BlElement >> removeStamp: aSymbol [

	self toStyleStoreDo: [ :tst | tst removeStamp: aSymbol ]
]

{ #category : #'*Toplo' }
BlElement >> removeTokenNamed: aSymbol [

	self toStyleStoreDo: [ :tst | tst removeTokenPropertyNamed: aSymbol ]
]

{ #category : #'*Toplo' }
BlElement >> requestInstallSkin [

	self
		deprecated: 'Please delegate to the skinManager instead'
		transformWith: '`@receiver requestInstallSkin' -> '`@receiver ensuredSkinManager requestInstallSkinIn: self'.

	self ensuredSkinManager requestInstallSkinIn: self 
]

{ #category : #'*Toplo' }
BlElement >> requestNewSkin [

	self skinManagerDo: [ :sm | sm requestNewSkinIn: self ]
]

{ #category : #'*Toplo' }
BlElement >> requestNewSkinRecursively [

	self childrenDo: [ :child | child requestNewSkinRecursively ].
	self requestNewSkin
]

{ #category : #'*Toplo' }
BlElement >> requestUninstallSkin [

	self
		deprecated: 'Please delegate to the skinManager instead'
		transformWith: '`@receiver requestUninstallSkin' -> '`@receiver skinManagerDo: [ :sm | sm requestUninstallSkinIn: `@receiver ]'.

	self skinManagerDo: [ :sm | sm requestUninstallSkinIn: self ]
]

{ #category : #'*Toplo' }
BlElement >> requestUninstallSkinRecursively [

	self childrenDo: [ :child | child requestUninstallSkinRecursively ].
	self requestUninstallSkin
]

{ #category : #'*Toplo' }
BlElement >> setStamp: aSymbol value: anObject [

	self ensuredToStyleStore addStamp: aSymbol value: anObject
]

{ #category : #'*Toplo' }
BlElement >> setTokenNamed: aSymbol value: anObject [

	self ensuredToStyleStore addTokenProperty: (aSymbol -> anObject) asTokenProperty 
]

{ #category : #'*Toplo' }
BlElement >> skinInstaller [

	^ self skinManager ifNotNil: [ :sm | sm skinInstaller ]
]

{ #category : #'*Toplo' }
BlElement >> skinInstaller: aSkinInstaller [

	self ensuredSkinManager setSkinInstaller: aSkinInstaller in: self
]

{ #category : #'*Toplo' }
BlElement >> skinManager [

	^ self userData at: #skinManager ifAbsent: [  ]
]

{ #category : #'*Toplo' }
BlElement >> skinManagerDo: aBlock [

	self skinManager ifNotNil: [ :sm | aBlock value: sm ]
]

{ #category : #'*Toplo' }
BlElement >> skinStateQueue [

	self skinManagerDo: [ :sm | ^ sm skinStateQueue ].
	^ nil
]

{ #category : #'*Toplo' }
BlElement >> skinToInstall [

	self skinManagerDo: [ :sm | ^ sm skinToInstallIn: self ].
	^ nil
]

{ #category : #'*Toplo' }
BlElement >> skinUninstaller [

	self skinManagerDo: [ :sm | ^ sm skinUninstaller ].
	^ nil
]

{ #category : #'*Toplo' }
BlElement >> skinUninstaller: aSkinUninstaller [

	self skinManagerDo: [ :sm | sm setSkinUninstaller: aSkinUninstaller in: self ]
]

{ #category : #'*Toplo' }
BlElement >> stampValueNamed: aSymbol [

	^ self toStyleStore
		  ifNil: [
		  Error signal: 'Trying to get an undeclared stamp property' ]
		  ifNotNil: [ :tst | tst stampValue: aSymbol ]
]

{ #category : #'*Toplo' }
BlElement >> stillHoveredStartDelay [

	^ self userData at: #stillHoveredStartDelay ifAbsent: [ ]
]

{ #category : #'*Toplo' }
BlElement >> stillHoveredStartDelay: aDuration [

	" must have a skin state generator "
	self userData at: #stillHoveredStartDelay put: aDuration asDuration
]

{ #category : #'*Toplo' }
BlElement >> stillPressedStartDelay [

	^ self userData at: #stillPressedStartDelay ifAbsent: [ ]
]

{ #category : #'*Toplo' }
BlElement >> stillPressedStartDelay: aDuration [

	" must have a skin state generator "
	self userData at: #stillPressedStartDelay put: aDuration asDuration
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> styleSheet: aStyleSheet [

	self ensuredSkinManager setStyleSheet: aStyleSheet in: self
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> styleSheetChain [
	" return an array with all my inherited stylesheets "
	self withAllParentsDo: [ :p |
		p skinManagerDo: [ :sm | ^ sm computedStyleSheetChainIn: p ] ].
	^ #(  )
]

{ #category : #'*Toplo' }
BlElement >> switchToNextCheckStateOnClick [

	" introduced here to avoid questionable condition for the management of the click event "
]

{ #category : #'*Toplo' }
BlElement >> textAttributesBuilder [

	self skinManagerDo: [ :sm | ^ sm textAttributesBuilder ].
	^ nil
]

{ #category : #'*Toplo' }
BlElement >> toStyleStore [

	^ self userData at: #toStyleStore ifAbsent: [ ]
]

{ #category : #'*Toplo' }
BlElement >> toStyleStoreDo: aBlock [

	self toStyleStore ifNotNil: [ :tst | aBlock value: tst ]
]

{ #category : #'*Toplo' }
BlElement >> toTheme [

	^ self userData at: #toTheme ifAbsent: [
		  self parent
			  ifNil: [ self space toTheme ]
			  ifNotNil: [ :p | p toTheme ] ]
]

{ #category : #'*Toplo' }
BlElement >> toTheme: aTheme [

	self userData at: #toTheme ifPresent: [ :th | th onUninstalledIn: self ].
	self userData at: #toTheme put: aTheme.
	aTheme ifNil: [ ^ self ].
	aTheme onInstalledIn: self 
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toThemeChanged [

	self childrenDo: [ :c | c toThemeChanged ].
	self dispatchEvent: ToThemeChangedEvent new.
	" if i'm the space root element then take care to renew my base stylesheet "
	self parent ifNil: [
		self spaceDo: [ :sp |
			sp root == self ifTrue: [ sp renewRootStyleSheet ] ] ].
	self requestNewSkin
]

{ #category : #'*Toplo' }
BlElement >> tokenPropertyNamed: aSymbol [

	^ self toStyleStore ifNotNil: [ :tst |
		  tst tokenPropertyNamed: aSymbol from: self ]
]

{ #category : #'*Toplo' }
BlElement >> tokenValueNamed: aSymbol [

	| found |
	self skinManagerDo: [ :sm |
		found := sm tokenPropertyValue: aSymbol from: self ].
	found ifNil: [ (ToElementPropertyNotFound name: aSymbol) signal ].
	^ found
]

{ #category : #'*Toplo' }
BlElement >> uninstallRawStyle [

]

{ #category : #'*Toplo' }
BlElement >> withNullSkin [

	self ensuredSkinManager setDefaultSkin: ToNullSkin new in: self
]
