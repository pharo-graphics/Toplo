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
BlElement >> addStamp: aSymbol withValue: anObject [

	self ensuredToStyleStore addStamp: aSymbol withValue: anObject
]

{ #category : #'*Toplo' }
BlElement >> addTokenNamed: aSymbol withValue: anObject [

	self ensuredToStyleStore addTokenProperty: (aSymbol -> anObject) asTokenProperty 
]

{ #category : #'*Toplo' }
BlElement >> allStamps [

	^ self toStyleStore
		  ifNil: [ #(  ) ]
		  ifNotNil: [ :tst | tst allStamps ]
]

{ #category : #'*Toplo' }
BlElement >> applyEnqueuedStatesDeeply [

	self withAllChildrenDepthFirstDo: [ :child |
		child skinManagerDo: [ :sm | sm applyEnqueuedStatesIn: child ] ]
]

{ #category : #'*Toplo' }
BlElement >> applySkinInstallerOnFirstRequest: aBoolean [

	self skinManagerDo: [ :sm | sm  applySkinInstallerOnFirstRequest: aBoolean ]
]

{ #category : #'*Toplo' }
BlElement >> applySkinInstallersDeeply [

	self withAllChildrenDepthFirstDo: [ :child |
		child skinManagerDo: [ :sm |
			sm applySkinUninstallerIn: child.
			sm applySkinInstallerIn: child ] ]
]

{ #category : #'*Toplo' }
BlElement >> borderBuilder [

	^ self skinManager borderBuilder
]

{ #category : #'*Toplo' }
BlElement >> defaultRawSkin: aSkin [

	self ensuredSkinManager setDefaultRawSkin: aSkin in: self
]

{ #category : #'*Toplo' }
BlElement >> defaultSkin: aSkin [

	self ensuredSkinManager setDefaultSkin: aSkin in: self
]

{ #category : #'*Toplo' }
BlElement >> disable [

	self isDisabled ifFalse: [
		self flagAsDisabled.
		self dispatchEvent: ToEnablementChangedEvent new.
		self skinManagerDo: [ :sm | sm enablementChangedIn: self ] ].
	self childrenDo: [ :child | child disable ]
]

{ #category : #'*Toplo' }
BlElement >> disabled: aBoolean [

	aBoolean 
		ifTrue: [ self disable ]
		ifFalse: [ self enable ]
]

{ #category : #'*Toplo' }
BlElement >> enable [

	self isEnabled ifFalse: [
		self flagAsEnabled.
		self dispatchEvent: ToEnablementChangedEvent new.
		self skinManagerDo: [ :sm | sm enablementChangedIn: self ] ].
	self childrenDo: [ :child | child enable ]
]

{ #category : #'*Toplo' }
BlElement >> enabled: aBoolean [

	aBoolean 
		ifTrue: [ self enable ]
		ifFalse: [ self disable ]
]

{ #category : #'*Toplo' }
BlElement >> ensureCanManageSkin [

	self ensureHaveSkinManager.
	(self eventDispatcher hasEventHandlerSuchThat: [ :h |
		 h isKindOf: ToSkinStateGenerator ]) ifFalse: [
		self addEventHandler: ToSkinStateGenerator new ].
	(self eventDispatcher hasEventHandlerSuchThat: [ :h |
		 h isKindOf: ToElementInitializeEventHandler ]) ifFalse: [
		self addEventHandler: ToElementInitializeEventHandler new ]
]

{ #category : #'*Toplo' }
BlElement >> ensureHaveSkinManager [

	self userData at: #skinManager ifAbsentPut: [ self newSkinManager ]
]

{ #category : #'*Toplo' }
BlElement >> ensuredShortcutsStore [

	^ self userData at: #shortcutsStore ifAbsentPut: [ self newShortcutsStore ]
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
BlElement >> hasStamp [
	"Return true if the BlElement has stamp (one or more), false if not"

	^ self allStamps notEmpty
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
BlElement >> installShortcuts [

	self shortcutsStoreDo: [ :store | store install ]
]

{ #category : #'*Toplo' }
BlElement >> installedSkin [

	self skinManagerDo: [ :sm | ^ sm installedSkin ].
	^ nil
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
BlElement >> localTheme [

	^ self userData at: #localTheme ifAbsent: [ ]
]

{ #category : #'*Toplo' }
BlElement >> localTheme: aTheme [

	(self parent isNil and: [
		 self space notNil and: [ self space toTheme ~= aTheme ] ]) ifTrue: [
		Error signal: 'The space root local theme can''t be changed directly, use the space API (#toTheme:)' ].
	self localTheme ifNotNil: [ :th | th onUninstalledIn: self ].
	self userData at: #localTheme put: aTheme.
	self localTheme ifNotNil: [ :th | th onInstalledIn: self ]
]

{ #category : #'*Toplo' }
BlElement >> lookupTheme [

	^ self localTheme ifNil: [
		  self parent
			  ifNil: [ self space toTheme ]
			  ifNotNil: [ :p | p lookupTheme ] ]
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> lookupWritablePropertyNamed: aSymbol [

	self styleSheetChain do: [ :ss |
		(ss property: aSymbol) ifNotNil: [ :wp | ^ wp ] ].
	^ nil
]

{ #category : #'*Toplo' }
BlElement >> newRawSkin [

	^  ToRawSkin new
]

{ #category : #'*Toplo' }
BlElement >> newShortcutsStore [

	^ ToShortcutsStore new
]

{ #category : #'*Toplo' }
BlElement >> newSkinManager [

	^ ToSkinManager new
]

{ #category : #'*Toplo' }
BlElement >> newTextAttributesBuilder [

	^ BlTextAttributesBuilder new
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
BlElement >> requestNewSkin [

	self skinManagerDo: [ :sm | sm requestNewSkinIn: self ]
]

{ #category : #'*Toplo' }
BlElement >> requestSkinApplication [

	self spaceDo: [ :sp | sp requestNextPulse ]
]

{ #category : #'*Toplo' }
BlElement >> requestUninstallSkin [

	self
		deprecated: 'Please delegate to the skinManager instead'
		transformWith: '`@receiver requestUninstallSkin' -> '`@receiver skinManagerDo: [ :sm | sm requestUninstallSkinIn: `@receiver ]'.

	self skinManagerDo: [ :sm | sm requestUninstallSkinIn: self ]
]

{ #category : #'*Toplo' }
BlElement >> shortcut: aShortcut [

	self ensuredShortcutsStore shortcut: aShortcut in: self
]

{ #category : #'*Toplo' }
BlElement >> shortcuts: aShortcutCollection [

	aShortcutCollection do: [ :sc |
		self ensuredShortcutsStore shortcut: sc in: self ]
]

{ #category : #'*Toplo' }
BlElement >> shortcutsStoreDo: aValuable [

	self userData at: #shortcutsStore ifPresent: [ :store | aValuable value: store ].
	
]

{ #category : #'*Toplo' }
BlElement >> skinInstaller [

	^ self skinManager skinInstaller
]

{ #category : #'*Toplo' }
BlElement >> skinInstaller: aSkinInstaller [

	self
		deprecated: 'Please delegate to the skinManager instead'
		transformWith: '`@receiver skinInstaller: `@arg' -> '`@receiver skinManager setSkinInstaller: `@arg in: `@receiver'.

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

	self
		deprecated: 'Please delegate to the skinManager instead'
		transformWith: '`@receiver skinStateQueue' -> '`@receiver skinManager skinStateQueue'.

	^ self skinManager skinStateQueue
]

{ #category : #'*Toplo' }
BlElement >> skinToInstall [

	self
		deprecated: 'Please delegate to the skinManager instead'
		transformWith: '`@receiver skinToInstall' -> '`@receiver skinManager skinToInstallIn: `@receiver'.

	^ self skinManager skinToInstallIn: self

]

{ #category : #'*Toplo' }
BlElement >> skinUninstaller [

	self
		deprecated: 'Please delegate to the skinManager instead'
		transformWith: '`@receiver skinUninstaller' -> '`@receiver skinManager skinUninstaller'.
		
	^ self skinManager skinUninstaller
]

{ #category : #'*Toplo' }
BlElement >> skinUninstaller: aSkinUninstaller [

	self
		deprecated: 'Please delegate to the skinManager instead'
		transformWith: '`@receiver skinUninstaller: `@arg' -> '`@receiver skinManager setSkinUninstaller: `@arg in: `@receiver'.
	self skinManager setSkinUninstaller: aSkinUninstaller in: self
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

{ #category : #'*Toplo' }
BlElement >> styleSheet [

	self skinManagerDo: [ :sm | ^ sm styleSheet  ].
	^ nil
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
BlElement >> textAttributesBuilder [

	^ self skinManager textAttributesBuilderIn: self
]

{ #category : #'*Toplo' }
BlElement >> toStyleStore [

	^ self userData at: #toStyleStore ifAbsent: [ ]
]

{ #category : #'*Toplo' }
BlElement >> toStyleStoreDo: aBlock [

	self toStyleStore ifNotNil: [ :tst | aBlock value: tst ]
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toThemeAboutToBeUninstalled: aTheme [

	self childrenDo: [ :c | c toThemeAboutToBeUninstalled: aTheme ]
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toThemeInstalled [

	self childrenDo: [ :c | c toThemeInstalled ].
	self dispatchEvent: ToThemeInstalledEvent new.
	self requestNewSkin
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toThemePreInstall: aTheme [

	self childrenDo: [ :c | c toThemePreInstall: aTheme ].
	self dispatchEvent: (ToThemePreInstallEvent new theme: aTheme; yourself)
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toThemeUninstalled: aTheme [

	self childrenDo: [ :c | c toThemeUninstalled: aTheme ].
	self requestNewSkin
]

{ #category : #'*Toplo' }
BlElement >> tokenValueNamed: aSymbol [

	self
		deprecated: 'Please use valueOfTokenNamed: instead'
		transformWith: '`@receiver tokenValueNamed: `@arg' -> '`@receiver valueOfTokenNamed: `@arg'.

	^ self valueOfTokenNamed: aSymbol
]

{ #category : #'*Toplo' }
BlElement >> uninstallRawStyle [

]

{ #category : #'*Toplo' }
BlElement >> uninstallShortcuts [

	self shortcutsStoreDo: [ :store | store uninstall ]
]

{ #category : #'*Toplo' }
BlElement >> valueOfStamp: aSymbol [

	^ self toStyleStore
		  ifNil: [
		  Error signal: 'Trying to get an undeclared stamp property' ]
		  ifNotNil: [ :tst | tst stampValue: aSymbol ]
]

{ #category : #'*Toplo' }
BlElement >> valueOfTokenNamed: aSymbol [

	| found |
	self skinManagerDo: [ :sm |
		found := sm tokenPropertyValue: aSymbol from: self ].
	found ifNil: [ (ToElementPropertyNotFound name: aSymbol) signal ].
	^ found
]

{ #category : #'*Toplo' }
BlElement >> withNullSkin [

	self ensuredSkinManager setDefaultSkin: ToNullSkin new in: self
]

{ #category : #'*Toplo' }
BlElement >> withStamp: aSymbol do: aValuable [

	self withStamp: aSymbol do: aValuable ifNone: [  ]
]

{ #category : #'*Toplo' }
BlElement >> withStamp: aSymbol do: aValuable ifNone: noneValuable [

	(self hasStamp: aSymbol) ifFalse: [
		noneValuable value.
		^ self ].
	aValuable value: (self valueOfStamp: aSymbol)
]
