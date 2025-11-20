Extension { #name : #BlElement }

{ #category : #'*Toplo' }
BlElement >> actionPoolDo: aValuable [
]

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
BlElement >> allowSelectionSkinEvents [

	self allowSkinEventClass: ToSelectedSkinEvent.
	self allowSkinEventClass: ToDeselectedSkinEvent.
]

{ #category : #'*Toplo' }
BlElement >> allowSkinEventClass: aSkinEventClass [

	self preventedSkinEventClasses remove: aSkinEventClass ifAbsent: [  ]
]

{ #category : #'*Toplo' }
BlElement >> anyInParentsSatisfy: aValuable [
	"Return true if the valuable answers true with one of my parent including myself "

	(aValuable value: self) ifTrue: [ ^ true ].
	self parentDo: [ :p | ^ p anyInParentsSatisfy: aValuable ].
	^ false
]

{ #category : #'*Toplo' }
BlElement >> applyConfiguration [

	self toConfiguration ifNotNil: [ :tc | tc applyOn: self ]
]

{ #category : #'*Toplo' }
BlElement >> applyEnqueuedStatesDeeply [

	self skinManagerDo: [ :sm | sm applyEnqueuedStatesFor: self ].
	self childrenDo: [ :child | child applyEnqueuedStatesDeeply ].

]

{ #category : #'*Toplo' }
BlElement >> applySkinInstallersDeeply [

	self skinManagerDo: [ :sm |
			sm installNewSkinIn: self ].
	self childrenDo: [ :child | child applySkinInstallersDeeply ]
]

{ #category : #'*Toplo' }
BlElement >> applyUpwardConfiguration [
	" now consume the request for configuration to avoid 
	a useless application during next pass if I'm send programmatically "
	self spaceDo: [ :sp |
		self nextConfigurationPass: sp runningConfigurationPass ].
	self dispatchEvent: ToConfigurationAppliedEvent new
]

{ #category : #'*Toplo' }
BlElement >> borderBuilder [

	^ self userData
		  at: #borderBuilder
		  ifAbsentPut: [ BlBorderBuilder new ]
]

{ #category : #'*Toplo' }
BlElement >> checkConfigurationPassDeeply [

	| requested |
	requested := self isConfigurationRequested.
	requested ifTrue: [ self applyConfiguration ].
	self childrenDo: [ :child | child checkConfigurationPassDeeply ].
	requested ifFalse: [ ^ self ].
	self applyUpwardConfiguration
]

{ #category : #'*Toplo' }
BlElement >> closedEventClass [

	^ ToClosedEvent 
]

{ #category : #'*Toplo' }
BlElement >> defaultRawSkin [

	^ self userData at: #defaultRawSkin ifAbsent: [  ]
]

{ #category : #'*Toplo' }
BlElement >> defaultRawSkin: aSkin [

	self defaultRawSkin = aSkin ifTrue: [ ^ self ].
	self userData at: #defaultRawSkin put: aSkin.
	self requestNewSkin 
]

{ #category : #'*Toplo' }
BlElement >> defaultSkin [

	^ self userData at: #defaultSkin ifAbsent: [  ]
]

{ #category : #'*Toplo' }
BlElement >> defaultSkin: aSkin [

	self defaultSkin = aSkin ifTrue: [ ^ self ].
	self userData at: #defaultSkin put: aSkin.
	self requestNewSkin
]

{ #category : #'*Toplo' }
BlElement >> disable [

	self disabled: true
]

{ #category : #'*Toplo' }
BlElement >> disabled: aBoolean [

	self withAllChildrenBreadthFirstDo: [ :child | child flagAsDisabled: aBoolean ]
]

{ #category : #'*Toplo' }
BlElement >> dispatchClosedEvent [

	self dispatchEvent: self newClosedEvent 
]

{ #category : #'*Toplo' }
BlElement >> dispatchOpenedEvent [

	self dispatchEvent: self newOpenedEvent
]

{ #category : #'*Toplo' }
BlElement >> enable [

	self disabled: false
]

{ #category : #'*Toplo' }
BlElement >> enabled: aBoolean [

	self disabled: aBoolean not
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
BlElement >> flagAsDisabled: aBoolean [

	self isDisabled = aBoolean ifTrue: [ ^ self ].
	aBoolean
		ifTrue: [
				self loseFocus.
				self flagAsDisabled ]
		ifFalse: [ self flagAsEnabled ].
	self dispatchEvent: ToEnablementChangedEvent new.
	self skinManagerDo: [ :sm | sm enablementState: aBoolean not in: self ]
]

{ #category : #'*Toplo' }
BlElement >> flagAsEnabled [

	self userData at: #enabled put: true
]

{ #category : #'*Toplo' }
BlElement >> floatOverlay [

	^ self userData at: #floatOverlay ifAbsentPut: [
			  | overlay |
			  overlay := ToFloatOverlay new.
			  overlay attachToParent: self.
			  overlay ]
]

{ #category : #'*Toplo' }
BlElement >> hasEnablementFlag [

	^ self userData includesKey: #enabled
]

{ #category : #'*Toplo' }
BlElement >> hasHolder [

	^ self constraints hasHolder
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
BlElement >> holder: aNodeHolder [

	| infiniteConstraints |
	infiniteConstraints := self constraints infinite.
	infiniteConstraints holder: aNodeHolder
]

{ #category : #'*Toplo' }
BlElement >> holderDo: aValuable [

	self constraints holderDo: aValuable
]

{ #category : #'*Toplo' }
BlElement >> installRawStyle [

	
]

{ #category : #'*Toplo' }
BlElement >> installShortcuts [

	self shortcutsStoreDo: [ :store | store install ]
]

{ #category : #'*Toplo' }
BlElement >> isActionRunnableAfter: aTimeStamp [

	self parentDo: [ :p | ^ p isActionRunnableAfter: aTimeStamp ].
	^ true
]

{ #category : #'*Toplo' }
BlElement >> isConfigurationRequested [

	^ self isAttachedToSceneGraph and: [
		  self nextConfigurationPass = self space runningConfigurationPass ]
]

{ #category : #'*Toplo' }
BlElement >> isDisabled [

	^ self isEnabled not
]

{ #category : #'*Toplo' }
BlElement >> isDisabled: aBoolean [

	self disabled: aBoolean
]

{ #category : #'*Toplo' }
BlElement >> isEnabled [

	^ self userData at: #enabled ifAbsentPut: [ true ]
]

{ #category : #'*Toplo' }
BlElement >> isEnabled: aBoolean [

	self enabled: aBoolean
]

{ #category : #'*Toplo' }
BlElement >> isFake [ 

	^ false
]

{ #category : #'*Toplo' }
BlElement >> isFullyVisibleInParent: aParentElement [

	| bnds pbnds intersection |
	bnds := self measuredBounds inSpace bounds asRectangle.
	pbnds := aParentElement bounds inSpace asRectangle.
	intersection := bnds intersect: pbnds.
	^ intersection = bnds
]

{ #category : #'*Toplo' }
BlElement >> isItemContainer [

	^ false
]

{ #category : #'*Toplo' }
BlElement >> isMenu [

	^ false
]

{ #category : #'*Toplo' }
BlElement >> isMenuItem [

	^ false
]

{ #category : #'*Toplo' }
BlElement >> isMenuPane [

	^ false
]

{ #category : #'*Toplo' }
BlElement >> isOutsideEvent: anEvent [

	" is the event occurs on myself or on one of my children ?"
	^ (anEvent target withAllParentsInclude: self) not
]

{ #category : #'*Toplo' }
BlElement >> isPreventedSkinEvent: aSkinEvent [

	^ self isPreventedSkinEventClass: aSkinEvent class
]

{ #category : #'*Toplo' }
BlElement >> isPreventedSkinEventClass: aSkinEventClass [

	^ self preventedSkinEventClasses includes: aSkinEventClass
]

{ #category : #'*Toplo' }
BlElement >> isSelectableElement [

	^ self
		  withAllParentsDetect: [ :p | p isKindOf: ToAbstractListNode ]
		  ifFound: [ :p | true ]
		  ifNone: [ false ]
]

{ #category : #'*Toplo' }
BlElement >> isSelected [

	^ false
]

{ #category : #'*Toplo' }
BlElement >> isSpaceRoot [

	^ self id = BlSpace defaultRootLabel
]

{ #category : #'*Toplo' }
BlElement >> localTheme [

	^ self userData at: #localTheme ifAbsent: [ ]
]

{ #category : #'*Toplo' }
BlElement >> localTheme: aTheme [

	(self parent isNil and: [
		 self space notNil and: [ self space toTheme ~= aTheme ] ]) ifTrue: [
		Error signal:
			'The space root local theme can''t be changed directly, use the space API (#toTheme:)' ].
	self localTheme ifNil: [ ^ self updateLocalThemeWith: aTheme ].
	self enqueueTask:
		(BlTaskAction new action: [ self updateLocalThemeWith: aTheme ])
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
BlElement >> newClosedEvent [

	^ self closedEventClass new
		  window: self;
		  yourself
]

{ #category : #'*Toplo' }
BlElement >> newOpenedEvent [

	^ self openedEventClass new
		  window: self;
		  yourself
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
BlElement >> newToConfiguration [

	^ nil
]

{ #category : #'*Toplo' }
BlElement >> nextConfigurationPass [

	^ self userData at: #nextConfigurationPass ifAbsent: [ 0 ]
]

{ #category : #'*Toplo' }
BlElement >> nextConfigurationPass: aNumber [

	self userData at: #nextConfigurationPass put: aNumber
]

{ #category : #'*Toplo' }
BlElement >> onAddedInItemBarOwner: anItemBar [

	anItemBar onAddedUnknownItemKind: self
]

{ #category : #'*Toplo' }
BlElement >> onRemovedFromItemBarOwner: anItemBar [

	anItemBar onRemovedUnknownItemKind: self
]

{ #category : #'*Toplo' }
BlElement >> openInInnerWindow [

	| frame |
	frame := ToInnerWindow new.
	frame pane addChild: self.
	frame openInSpace.
	^ frame
]

{ #category : #'*Toplo' }
BlElement >> openedEventClass [

	^ ToOpenedEvent 
]

{ #category : #'*Toplo' }
BlElement >> preventSelectionSkinEvents [

	self preventSkinEventClass: ToSelectedSkinEvent.
	self preventSkinEventClass: ToDeselectedSkinEvent.
]

{ #category : #'*Toplo' }
BlElement >> preventSkinEventClass: aSkinEventClass [

	self preventedSkinEventClasses add: aSkinEventClass
]

{ #category : #'*Toplo' }
BlElement >> preventedSkinEventClasses [

	self userData
		at: #preventedSkinEventClasses
		ifAbsentPut: IdentitySet new.
	^ self userData at: #preventedSkinEventClasses
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
BlElement >> removedFromMenu: aMenu [
]

{ #category : #'*Toplo' }
BlElement >> requestConfiguration [

	self spaceDo: [ :sp |
		self nextConfigurationPass: sp nextConfigurationPass.
		sp  requestNewConfigurationPass ]
]

{ #category : #'*Toplo' }
BlElement >> requestNewConfigurationPass [

	self
		deprecated: 'Use #requestNewConfiguration'
		transformWith: '`@rcvr requestNewConfigurationPass'
			-> '`@rcvr requestNewConfiguration'.
	self requestConfiguration
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
BlElement >> selected: aBoolean [

	" no effect by default "
]

{ #category : #'*Toplo' }
BlElement >> selectionSkinEventsPrevented [

	^ (self isPreventedSkinEventClass: ToSelectedSkinEvent) or: [
		  self isPreventedSkinEventClass: ToDeselectedSkinEvent ]
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
BlElement >> styleSheet [

	self skinManagerDo: [ :sm | ^ sm styleSheet  ].
	^ nil
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> styleSheet: aStyleSheet [

	self ensuredSkinManager setStyleSheet: aStyleSheet in: self.
	self requestNewSkin
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

	^ self userData
		  at: #textAttributesBuilder
		  ifAbsentPut: [ self newTextAttributesBuilder ]
]

{ #category : #'*Toplo' }
BlElement >> textAttributesBuilderDo: aBlock [

	aBlock value: self textAttributesBuilder
]

{ #category : #'*Toplo' }
BlElement >> toConfiguration [

	^ self userData at: #toConfiguration ifAbsentPut: [
		  | conf |
		  conf := self newToConfiguration.
		  conf ifNotNil: [ conf onInstalledIn: self ].
		  conf ]
]

{ #category : #'*Toplo' }
BlElement >> toConfiguration: anElementConfiguration [

	self userData at: #toConfiguration ifPresent: [ :conf |
		conf onUninstalledIn: self.
		self userData removeKey: #toConfiguration ].
	anElementConfiguration ifNil: [ ^ self ].
	self userData at: #toConfiguration put: anElementConfiguration.
	anElementConfiguration onInstalledIn: self
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
BlElement >> toThemeInstalled [

	self childrenDo: [ :c | c toThemeInstalled ].
	self dispatchEvent: ToThemeInstalledEvent new.
	self requestNewSkin
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toThemeUninstalled: aTheme [

	self childrenDo: [ :c | c toThemeUninstalled: aTheme ]
]

{ #category : #'*Toplo' }
BlElement >> tokenPropertyValue: aSymbol [
	" look-up following child-parent association 
	for each element, try first to get the property from the local styleStampIndex 
	"

	self withAllParentsDo: [ :p |
			p toStyleStore ifNotNil: [ :tst |
				^ tst tokenPropertyValue: aSymbol from: p ] ].
	^ nil
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
BlElement >> updateLocalThemeWith: aTheme [

	self localTheme ifNotNil: [ :th | th onUninstalledIn: self ].
	self userData at: #localTheme put: aTheme.
	self localTheme ifNotNil: [ :th | th onInstalledIn: self ]
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
	found := self tokenPropertyValue: aSymbol.
	found ifNil: [ (ToElementPropertyNotFound name: aSymbol) signal ].
	^ found
]

{ #category : #'*Toplo' }
BlElement >> whenConfigurationAppliedDo: aValuable [

	self
		addEventHandlerOn: ToConfigurationAppliedEvent
		do: [ :evt | aValuable cull: evt ]
]

{ #category : #'*Toplo' }
BlElement >> withNullSkin [

	self defaultSkin: ToNullSkin instance
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

{ #category : #'*Toplo' }
BlElement >> withStamp: aSymbol ifNone: aValuable [

	self withStamp: aSymbol do: [:v | ] ifNone: aValuable
]
