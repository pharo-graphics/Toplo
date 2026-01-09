Extension { #name : #BlElement }

{ #category : #'*Toplo' }
BlElement >> actionPoolDo: aValuable [
]

{ #category : #'*Toplo' }
BlElement >> addAllStamps: aSymbolCollection [

	self ensuredStampMap addAllProperties: (aSymbolCollection collect: [ :s | (s-> true) asStampProperty ])
]

{ #category : #'*Toplo' }
BlElement >> addAllTokenProperties: aTokenPropertyCollection [

	self ensuredTokenPropertyMap addAllProperties: aTokenPropertyCollection
]

{ #category : #'*Toplo' }
BlElement >> addEventHandlerOn: anEventClass doUntil: aBlock [
	"Add an event handler that will be removed as soon as the untilBlock is true.
	Answer the new `BlEventHandler`."

	| anEventHandler |
	anEventHandler := BlEventHandler new.
	anEventHandler
		eventClass: anEventClass;
		action: [ :anEvent |
				(aBlock cull: anEvent) ifTrue: [
						self removeEventHandler: anEventHandler ] ].

	self addEventHandler: anEventHandler.

	^ anEventHandler
]

{ #category : #'*Toplo' }
BlElement >> addStamp: aSymbol [

	self ensuredStampMap addProperty: (aSymbol -> true) asStampProperty
]

{ #category : #'*Toplo' }
BlElement >> addStamp: aSymbol withValue: anObject [

	self ensuredStampMap addProperty: (aSymbol -> anObject) asStampProperty
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> addStyleSheetProperty: aWriteableProperty [

	self ensuredStyleSheet addWritableProperty: aWriteableProperty
]

{ #category : #'*Toplo' }
BlElement >> addTokenNamed: aSymbol withValue: anObject [

	self ensuredTokenPropertyMap addProperty: (aSymbol -> anObject) asTokenProperty 
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> addWritableProperty: aWriteableProperty [

	self
		deprecated: 'Use #addStyleSheetProperty:'
		transformWith: '`@rcvr addWritableProperty: `@arg'
			-> '`@rcvr addStyleSheetProperty: `@arg'.
	^ self addStyleSheetProperty: aWriteableProperty
]

{ #category : #'*Toplo' }
BlElement >> allStamps [

	^ self stampMap allPropertyNames 
]

{ #category : #'*Toplo' }
BlElement >> allowSelectionSkinEvents [

	self allowSkinEventClass: ToSelectedSkinEvent.
	self allowSkinEventClass: ToDeselectedSkinEvent.
]

{ #category : #'*Toplo' }
BlElement >> allowSkinEventClass: aSkinEventClass [

	self preventedSkinEventClasses ifNotNil: [ :p |
		p remove: aSkinEventClass ifAbsent: [ ] ]
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

	"During the configuration phase, elements that requested reconfiguration (using the message `requestConfiguration`) get this method executed.
	
	Subclasses may redefine this hook method."
	
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

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> bottomUpLocalThemeChain [
	" return an array with all my local theme "

	^ Array new: 10 streamContents: [ :stream |
		  self bottomUpLocalThemeDo: [ :ss | stream nextPut: ss ] ]
]

{ #category : #'*Toplo' }
BlElement >> bottomUpLocalThemeDo: aBlock [
	" evaluate a block with all my inherited stylesheets "

	self skinManagerDo: [ :sm |
			sm installedTheme ifNotNil: [ :th |
					aBlock value: th ] ].
	self parentDo: [ :p | p bottomUpLocalThemeDo: aBlock ]
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> bottomUpStyleSheetChain [
	" return an array with all my inherited stylesheets "

	^ Array new: 10 streamContents: [ :stream |
		  self bottomUpStyleSheetChainDo: [ :ss | stream nextPut: ss ] ]
]

{ #category : #'*Toplo' }
BlElement >> bottomUpStyleSheetChainDo: aBlock [
	" evaluate a block with all my inherited stylesheets "

	self skinManagerDo: [ :sm |
			sm styleSheet ifNotNil: [ :ss |
					aBlock value: ss.
					ss inherits ifFalse: [ ^ self ] ] ].
	self parentDo: [ :p | p bottomUpStyleSheetChainDo: aBlock ]
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
BlElement >> ensuredPreventedSkinEventClasses [

	^ self ensuredSkinManager ensuredPreventedSkinEventClasses
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
BlElement >> ensuredStampMap [

	^ self ensuredSkinManager ensuredStampMapIn: self
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> ensuredStyleSheet [

	^ self ensuredSkinManager ensuredStyleSheetIn: self
]

{ #category : #'*Toplo' }
BlElement >> ensuredTokenPropertyMap [

	^ self ensuredSkinManager ensuredTokenPropertyMapIn: self
]

{ #category : #'*Toplo' }
BlElement >> fallBackValueOfTokenNamed: aSymbol [

	('Warning: *** To be fixed: The token #''' , aSymbol
	 , ''' lookup failed. Trying the last installed theme.') traceCr.
	self dispatchEvent: (ToTokenPropertyNotFoundEvent new
			 name: aSymbol;
			 yourself).
	Toplo lastInstalledTheme ifNotNil: [ :th | self onThemeInstalled: th ].
	self topDownLocalThemeDo: [ :th |
		th ~= Toplo lastInstalledTheme ifTrue: [ self onThemeInstalled: th ] ].
	^ (self lookupTokenPropertyValueNamed: aSymbol) ifNil: [
			  (ToTokenPropertyNotFoundError name: aSymbol) signal.
			  nil ]
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
BlElement >> hasAllStamps: aSymbolCollection [

	^ aSymbolCollection allSatisfy: [ :s | self hasStamp: s ]
]

{ #category : #'*Toplo' }
BlElement >> hasEnablementFlag [

	^ self userData includesKey: #enabled
]

{ #category : #'*Toplo' }
BlElement >> hasListHolder [

	^ self constraints hasListHolder
]

{ #category : #'*Toplo' }
BlElement >> hasStamp [
	"Return true if the BlElement has stamp (one or more), false if not"

	^ self stampMap notNil and: [self stampMap isNotEmpty ]
]

{ #category : #'*Toplo' }
BlElement >> hasStamp: aSymbol [

	^ self stampMap
		  ifNil: [ false ]
		  ifNotNil: [ :map | map hasPropertyNamed: aSymbol ]
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

	^ self preventedSkinEventClasses
		  ifNil: [ false ]
		  ifNotNil: [ :p | p includes: aSkinEventClass ]
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
BlElement >> listHolderDo: aValuable [

	^ self constraints listHolderDo: aValuable
]

{ #category : #'*Toplo' }
BlElement >> localTheme [

	^ self skinManagerDo: [ :sm | sm installedTheme ]
]

{ #category : #'*Toplo' }
BlElement >> localTheme: aTheme [

	self localTheme ifNil: [ ^ self updateLocalThemeWith: aTheme ].
	self enqueueTask:
		(BlTaskAction new action: [ self updateLocalThemeWith: aTheme ])
]

{ #category : #'*Toplo' }
BlElement >> lookupTheme [

	| found |
	self bottomUpLocalThemeDo: [ :th | found := th ].
	found ifNil: [
			found := self space
				         ifNil: [ ToSpaceNotFoundError signal ]
				         ifNotNil: [ :sp | sp toTheme ] ].
	found ifNil: [ ToThemeNotFoundError signal ].
	^ found
]

{ #category : #'*Toplo' }
BlElement >> lookupTokenPropertyValueNamed: aSymbol [
	" look-up following child-parent association 
	for each parent, if the skin manager exists, then ask the skin manager token map for the token property value. "

	self withAllParentsDo: [ :p |
			p tokenPropertyMap ifNotNil: [ :map |
				(map propertyNamed: aSymbol) ifNotNil: [ :t |
				^ t value ] ] ].
	^ nil
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> lookupWritablePropertyNamed: aSymbol [

	self bottomUpStyleSheetChainDo: [ :ss |
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
BlElement >> onThemeInstalled: aTheme [

	" Normally, I'm sent on the space root only.
	I can be sent on another element in case of a lookup error "
	aTheme ifNil: [ ^ self ].
	self addAllTokenProperties: aTheme tokenProperties.
	self styleSheet: aTheme styleSheet.
	self toThemeInstalled.
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

	self ensuredPreventedSkinEventClasses add: aSkinEventClass
]

{ #category : #'*Toplo' }
BlElement >> preventedSkinEventClasses [

	^ self skinManager ifNotNil: [:sm | sm preventedSkinEventClasses ]
]

{ #category : #'*Toplo' }
BlElement >> recoverLastInstalledTheme [

	Toplo lastInstalledTheme ifNotNil: [ :th | self onThemeInstalled: th ]
]

{ #category : #'*Toplo' }
BlElement >> removeAllStamps [

	self stampMapDo: [ :map | map removeAllProperties ]
]

{ #category : #'*Toplo' }
BlElement >> removeAllStamps: aSymbolCollection [

	self stampMap removeAllPropertiesFromNames: aSymbolCollection
]

{ #category : #'*Toplo' }
BlElement >> removeAllTokenPropertiesFromNames: aCollection [

	self tokenPropertyMapDo: [ :map |
		map removeAllPropertiesFromNames: aCollection ]
]

{ #category : #'*Toplo' }
BlElement >> removeStamp: aSymbol [

	self stampMapDo: [ :map | map removePropertyNamed: aSymbol ]
]

{ #category : #'*Toplo' }
BlElement >> removeTokenNamed: aSymbol [

	self tokenPropertyMapDo: [ :map | map removePropertyNamed: aSymbol ]
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

	self skinManager ifNotNil: [ :sm | ^ aBlock value: sm ].
	^ nil
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
BlElement >> stampMap [

	^ self skinManagerDo: [ :sm | sm stampMap ]
]

{ #category : #'*Toplo' }
BlElement >> stampMapDo: aBlock [

	^ self stampMap ifNotNil: [ :map | aBlock value: map ]
]

{ #category : #'*Toplo' }
BlElement >> stampPropertyNamed: aSymbol [

	^ self stampMap
		  propertyNamed: aSymbol
		  ifAbsent: [
		  Error signal: 'Trying to get an undeclared stamp property' ]
]

{ #category : #'*Toplo' }
BlElement >> stampValue: aSymbol [

	^ (self stampPropertyNamed: aSymbol) value
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

{ #category : #'*Toplo' }
BlElement >> styleSheetProperty: aName [

	^ self lookupWritablePropertyNamed: aName
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

	| newConfig |
	self userData
		at: #toConfiguration
		ifPresent: [ :conf | ^ conf ]
		ifAbsentPut: [ newConfig := self newToConfiguration ].
	newConfig ifNotNil: [ newConfig onInstalledIn: self ].
	^ newConfig
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
BlElement >> toConfigurationDo: aBlock [

	^ self toConfiguration ifNotNil: [ :conf | aBlock cull: conf]
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
BlElement >> tokenPropertyMap [

	^ self skinManagerDo: [ :sm | sm tokenPropertyMap ]
]

{ #category : #'*Toplo' }
BlElement >> tokenPropertyMapDo: aBlock [

	^ self tokenPropertyMap ifNotNil: aBlock
]

{ #category : #'*Toplo' }
BlElement >> tokenValueNamed: aSymbol [

	self
		deprecated: 'Please use valueOfTokenNamed: instead'
		transformWith: '`@receiver tokenValueNamed: `@arg' -> '`@receiver valueOfTokenNamed: `@arg'.

	^ self valueOfTokenNamed: aSymbol
]

{ #category : #'*Toplo' }
BlElement >> topDownLocalThemeDo: aBlock [
	" evaluate a block with all my local theme in reverse order (top-down)"

	| chain |
	chain := self bottomUpLocalThemeChain.
	chain reverseDo: aBlock
]

{ #category : #'*Toplo' }
BlElement >> topDownStyleSheetChainDo: aBlock [
	" evaluate a block with all my inherited stylesheets in reverse order (top-down)"

	| chain |
	chain := self bottomUpStyleSheetChain.
	chain reverseDo: aBlock
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
	self ensuredSkinManager installedTheme: aTheme.
	self localTheme ifNotNil: [ :th | th onInstalledIn: self ]
]

{ #category : #'*Toplo' }
BlElement >> valueOfStamp: aSymbol [

	^ self stampMap
		  ifNil: [
		  Error signal: 'Trying to get an undeclared stamp property' ]
		  ifNotNil: [ :map |
				  (map
					   propertyNamed: aSymbol
					   ifAbsent: [
					   Error signal: 'Trying to get an undeclared stamp property' ])
					  value ]
]

{ #category : #'*Toplo' }
BlElement >> valueOfTokenNamed: aSymbol [

	^ (self lookupTokenPropertyValueNamed: aSymbol) ifNil: [
		  self fallBackValueOfTokenNamed: aSymbol ]
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
