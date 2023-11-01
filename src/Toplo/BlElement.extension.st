Extension { #name : 'BlElement' }

{ #category : '*Toplo' }
BlElement >> addStyleStamp: aStyleStamp [

	self ensureLocalStyleStampIndex.
	self localStyleStampIndex addProperty: aStyleStamp
]

{ #category : '*Toplo' }
BlElement >> applySkinInstaller [

	self skinInstaller ifNotNil: [ :si | si applyOn: self ]

]

{ #category : '*Toplo' }
BlElement >> borderBuilder [

	^ self userData at: #borderBuilder ifAbsentPut: [ BlBorderBuilder new ]
]

{ #category : '*Toplo' }
BlElement >> defaultSkin [

	^ self userData
		  at: #localDefaultSkin
		  ifAbsent: [ self toTheme skinFor: self ]
]

{ #category : '*Toplo' }
BlElement >> defaultSkin: aSkin [

	| prev |
	prev := self userData at: #localDefaultSkin ifAbsent: [  ]. 
	prev = aSkin ifTrue: [ ^ self ].
	self userData at: #localDefaultSkin put: aSkin.
	aSkin setAsDefaultSkinIn: self 
]

{ #category : '*Toplo' }
BlElement >> disable [

	self isDisabled ifFalse: [
		self flagAsDisabled.
		self dispatchEnablementChangedEvent  ].
	self childrenDo: [ :child | child disable ]
]

{ #category : '*Toplo' }
BlElement >> dispatchEnablementChangedEvent [

	self dispatchEvent: ToEnablementChangedEvent new
]

{ #category : '*Toplo' }
BlElement >> dispatchLookEvent: anEvent [

	self dispatchEvent: anEvent
]

{ #category : '*Toplo' }
BlElement >> dispatchSkinChangedEvent [

	self dispatchEvent: ToSkinChangedEvent new
]

{ #category : '*Toplo' }
BlElement >> dispatchSkinRequestedEvent [

	self dispatchEvent: ToSkinRequestedEvent new
]

{ #category : '*Toplo' }
BlElement >> enable [

	self isEnabled ifFalse: [
		self flagAsEnabled.
		self dispatchEnablementChangedEvent ].
	self childrenDo: [ :child | child enable ]
]

{ #category : '*Toplo' }
BlElement >> enqueueSkinState: aState [

	aState enqueueIn: self 
]

{ #category : '*Toplo' }
BlElement >> ensureLocalStyleStampIndex [

	self userData
		at: #localStyleStampIndex
		ifAbsentPut: ToPropertyIndex new
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
BlElement >> flushSkinStates [

	self skinStateQueue applyOn: self
]

{ #category : '*Toplo' }
BlElement >> hasEnablementFlag [

	^ self userData includesKey: #enabled
]

{ #category : '*Toplo' }
BlElement >> hasStamp: aSymbol [

	| index |
	index := self localStyleStampIndex ifNil: [ ^ false ].
	^ index hasPropertyNamed: aSymbol
]

{ #category : '*Toplo' }
BlElement >> holder [

	^ self constraints infinite holder
]

{ #category : '*Toplo' }
BlElement >> ifNotWithNullSkinDo: aBlock [

	(self userData at: #localDefaultSkin ifAbsent: [  ]) ifNotNil: [ :s |
		s isNullSkin ifTrue: [ ^ self ] ].
	aBlock value
]

{ #category : '*Toplo' }
BlElement >> initialRawStyle [
]

{ #category : '*Toplo' }
BlElement >> installRawStyle [

	self requestSkin
]

{ #category : '*Toplo' }
BlElement >> installedSkin [

	self eventDispatcher handlersDo: [ :h | (h isKindOf: ToSkin) ifTrue: [ ^ h]].
	^ nil
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
BlElement >> isWithoutSkin [

	^ self defaultSkin ifNil: [ ^ false ] ifNotNil: [ :s | s isNullSkin ]
]

{ #category : '*Toplo' }
BlElement >> localStyleSheet [

	^ self userData at: #localStyleSheet ifAbsent: [  ]
]

{ #category : '*Toplo' }
BlElement >> localStyleSheet: aStyleSheet [

	| prev |
	prev := self userData at: #localStyleSheet ifAbsent: [  ].
	prev ifNotNil: [ prev onUnInstalledIn: self ].
	self userData at: #localStyleSheet put: aStyleSheet.
	aStyleSheet ifNotNil: [ aStyleSheet onInstalledIn: self ]
]

{ #category : '*Toplo' }
BlElement >> localStyleStampIndex [

	^ self userData at: #localStyleStampIndex ifAbsent: [ ]
]

{ #category : '*Toplo' }
BlElement >> localStyleStampNamed: aSymbol [

	| index |
	index := self localStyleStampIndex ifNil: [ ^ nil ].
	^ index propertyNamed: aSymbol ifAbsent: [  ]
	
]

{ #category : '*Toplo' }
BlElement >> localToTheme [

	^ self userData at: #localToTheme ifAbsent: [  ]
]

{ #category : '*Toplo' }
BlElement >> localToTheme: aTheme [

	self userData at: #localToTheme put: aTheme
]

{ #category : '*Toplo' }
BlElement >> lookUpStyleStampNamed: aSymbol [
	" first look-up following child-parent association 
	for each element, try first to get the stamp from the localStyleStampIndex 
	then from the elementl styleSheet ifPresent"

	self withAllParentsDo: [ :p |
		(p localStyleStampNamed: aSymbol) ifNotNil: [ :t | ^ t ].
		p localStyleSheet ifNotNil: [ :ss |
			(ss stampNamed: aSymbol) ifNotNil: [ :t | ^ t ] ] ].
	" finally, try to get the stamp from the theme "
	^ self toTheme stampNamed: aSymbol
]

{ #category : '*Toplo' }
BlElement >> openInInnerWindow [

	| frame |
	frame := ToInnerWindow new.
	frame pane addChild: self.
	frame openInSpace
]

{ #category : '*Toplo' }
BlElement >> rawSkin [

	^  ToRawSkin new
]

{ #category : '*Toplo' }
BlElement >> removeAllStyleStamps [

	| index |
	index := self localStyleStampIndex ifNil: [ ^ self ].
	index removeAllProperties 
]

{ #category : '*Toplo' }
BlElement >> removeAllStyleStamps: aStyleStampCollection [

	| index |
	index := self localStyleStampIndex ifNil: [ ^ self ].
	aStyleStampCollection do: [ :s | index removeProperty: s ]
]

{ #category : '*Toplo' }
BlElement >> removeStyleStamp: aStyleStamp [

	| index |
	index := self localStyleStampIndex ifNil: [ ^ self ].
	index removeProperty: aStyleStamp
]

{ #category : '*Toplo' }
BlElement >> removeStyleStampNamed: aSymbol [

	| index |
	index := self localStyleStampIndex ifNil: [ ^ self ].
	index removePropertyNamed: aSymbol
]

{ #category : '*Toplo' }
BlElement >> removeStyleStampNamed: aSymbol ifAbsent: anAbsentBlock [

	| index |
	index := self localStyleStampIndex ifNil: [ ^ self ].
	index removePropertyNamed: aSymbol ifAbsent: anAbsentBlock
]

{ #category : '*Toplo' }
BlElement >> requestDefaultSkin: aSkin [

	" force the default skin. If aSkin is nil, then it means to comme back to default case "
	self defaultSkin: aSkin.
	self requestSkin
]

{ #category : '*Toplo' }
BlElement >> requestSkin [

	self ifNotWithNullSkinDo: [
		self skinInstaller ifNotNil: [ ^ self ].
		self skinInstaller: ToSkinInstaller new.
		self spaceDo: [ :space | space elementWithSkinInstaller: self ] ]
]

{ #category : '*Toplo' }
BlElement >> requestSkinRecursively [

	self childrenDo: [ :child | child requestSkinRecursively ].
	self requestSkin
]

{ #category : '*Toplo' }
BlElement >> skinDo: aBlock [

	self installedSkin ifNil: [ ^ self ].
	aBlock value: self installedSkin
]

{ #category : '*Toplo' }
BlElement >> skinInstaller [

	^ self userData at: #skinInstaller ifAbsent: [  ]
]

{ #category : '*Toplo' }
BlElement >> skinInstaller: aSkinInstaller [

	self userData at: #skinInstaller put: aSkinInstaller
]

{ #category : '*Toplo' }
BlElement >> skinStateGeneratorClass [

	^ ToSkinStateGenerator 
]

{ #category : '*Toplo' }
BlElement >> skinStateQueue [

	^ self userData at: #skinStateQueue ifAbsentPut: (ToSkinStateQueue new onInstalledIn: self)
]

{ #category : '*Toplo' }
BlElement >> stampNamed: aSymbol [

	(self lookUpStyleStampNamed: aSymbol) ifNotNil: [ :s | ^ s ].
	(ToElementPropertyNotFound name: aSymbol) signal
]

{ #category : '*Toplo' }
BlElement >> stampValue: aSymbol [

	(self lookUpStyleStampNamed: aSymbol) ifNotNil: [ :s | ^ s value ].
	(ToElementPropertyNotFound name: aSymbol) signal
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
BlElement >> styleSheet [

	^ self localStyleSheet
]

{ #category : '*Toplo-LookAndFeel' }
BlElement >> styleSheet: aStyleSheet [

	self localStyleSheet = aStyleSheet ifTrue: [ ^ self ].
	self localStyleSheet: aStyleSheet.
	self toThemeChanged.

]

{ #category : '*Toplo-LookAndFeel' }
BlElement >> styleSheetChain [
	" return an array with all my inherited stylesheets "

	^ Array new: 20 streamContents: [ :str |
		  | current inherits |
		  current := self.
		  inherits := true.
		  [ current notNil and: [ inherits ] ] whileTrue: [
			  current localStyleSheet ifNotNil: [ :ss |
				  str nextPut: ss.
				  inherits := ss inherits ].
			  current := current parent ].
		  (self toTheme notNil and: [
			   self toTheme styleSheet notNil and: [ inherits ] ]) ifTrue: [
			  str nextPut: self toTheme styleSheet ] ]
]

{ #category : '*Toplo' }
BlElement >> switchToNextCheckStateOnClick [

	" introduced here to avoid questionable condition in SinnableEventHandler for the management of the click event "
]

{ #category : '*Toplo' }
BlElement >> textAttributesBuilder [

	^ self userData at: #textAttributesBuilder ifAbsentPut: [ BlTextAttributesBuilder new ]
]

{ #category : '*Toplo-LookAndFeel' }
BlElement >> toTheme [

	^ self localToTheme ifNil: [
		  self hasParent
			  ifTrue: [ self parent toTheme ]
			  ifFalse: [
				  self isAttachedToSceneGraph
					  ifTrue: [ " install the theme only if the root is attached to 
						avoid default installation in another element that the space root"
						  self localToTheme: ToStyleSheetTheme current.
						  self localToTheme ]
					  ifFalse: [ ToTheme current ] ] ]
]

{ #category : '*Toplo-LookAndFeel' }
BlElement >> toTheme: aTheme [

	self localToTheme = aTheme ifTrue: [ ^ self ].
	self localToTheme: aTheme.
	self toThemeChanged.

]

{ #category : '*Toplo-LookAndFeel' }
BlElement >> toThemeChanged [

	self dispatchEvent: ToThemeChangedEvent new.
	self childrenDo: [ :c | c toThemeChanged ]
]

{ #category : '*Toplo' }
BlElement >> withAllStamps: aCollectionOfSymbol [

	aCollectionOfSymbol ifEmpty: [ ^ self ].
	aCollectionOfSymbol do: [ :s | self withStamp: s ]
]

{ #category : '*Toplo' }
BlElement >> withStamp: anAssociationOrSymbol [

	self ensureLocalStyleStampIndex.
	self addStyleStamp: anAssociationOrSymbol asStyleStamp
]

{ #category : '*Toplo' }
BlElement >> withoutAllStamps [

	self removeAllStyleStamps
]

{ #category : '*Toplo' }
BlElement >> withoutSkin [

	self installedSkin ifNotNil: [ :s | self removeEventHandler: s ].
	self defaultSkin: ToNullSkin new
]

{ #category : '*Toplo' }
BlElement >> withoutStamp: aSymbol [

	self removeStyleStampNamed: aSymbol ifAbsent: [  ]
]
