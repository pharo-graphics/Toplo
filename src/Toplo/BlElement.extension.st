Extension { #name : #BlElement }

{ #category : #'*Toplo' }
BlElement >> addStyleStamp: aStyleStamp [

	self ensureLocalStyleStampIndex.
	self localStyleStampIndex addProperty: aStyleStamp
]

{ #category : #'*Toplo' }
BlElement >> asPlaceholderLayer [

	^ ToPlaceholderLayer new
		  in: [ :placeholder | placeholder addChild: self ];
		  yourself
]

{ #category : #'*Toplo' }
BlElement >> borderBuilder [

	^ self userData at: #borderBuilder ifAbsentPut: [ BlBorderBuilder new ]
]

{ #category : #'*Toplo' }
BlElement >> checkSkinInitialization [
]

{ #category : #'*Toplo' }
BlElement >> checkSkinInstallation [

	self childrenDo: [ :child | child checkSkinInstallation ].
	self skinInstaller ifNotNil: [ :si | si applyOn: self ].

]

{ #category : #'*Toplo' }
BlElement >> currentSkinState [

	^ self userData at: #currentSkinState ifAbsentPut: [  ]
]

{ #category : #'*Toplo' }
BlElement >> currentSkinState: aState [

	self userData at: #currentSkinState put: aState
]

{ #category : #'*Toplo' }
BlElement >> defaultSkin [

	^  self skinBuilder skinFor: self
]

{ #category : #'*Toplo' }
BlElement >> defaultSkin: aSkin [

	self userData at: #defaultSkin put: aSkin
]

{ #category : #'*Toplo' }
BlElement >> disable [

	self isFlaggedAsDisabled ifFalse: [
		self flagAsDisabled.
		self dispatchEnablementChangedEvent  ].
	self childrenDo: [ :child | child disable ]
]

{ #category : #'*Toplo' }
BlElement >> dispatchEnablementChangedEvent [

	self dispatchEvent: ToEnablementChangedEvent new
]

{ #category : #'*Toplo' }
BlElement >> dispatchLookEvent: anEvent [

	self dispatchEvent: anEvent
]

{ #category : #'*Toplo' }
BlElement >> dispatchSkinChangedEvent [

	self dispatchEvent: ToSkinChangedEvent new
]

{ #category : #'*Toplo' }
BlElement >> enable [

	self isFlaggedAsEnabled ifFalse: [
		self flagAsEnabled.
		self dispatchEnablementChangedEvent ].
	self childrenDo: [ :child | child enable ]
]

{ #category : #'*Toplo' }
BlElement >> ensureLocalStyleStampIndex [

	self userData
		at: #localStyleStampIndex
		ifAbsentPut: ToPropertyIndex new
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
BlElement >> hasStamp: aSymbol [

	| index |
	index := self localStyleStampIndex ifNil: [ ^ false ].
	^ index hasPropertyNamed: aSymbol
]

{ #category : #'*Toplo' }
BlElement >> holder [

	^ self constraints infinite holder
]

{ #category : #'*Toplo' }
BlElement >> installRawStyle [
]

{ #category : #'*Toplo' }
BlElement >> installSkin [

	self skinInstaller: ToLazySkintInstaller new
]

{ #category : #'*Toplo' }
BlElement >> installSkin: aSkin [

	self privateSkin ifNotNil: [ :s | self removeEventHandler: s ].
	aSkin ifNotNil: [ :s |
		self skinInstaller: (ToExplicitSkinInstaller new skin: s) ]
]

{ #category : #'*Toplo' }
BlElement >> installSkinRecursively [

	self childrenDo: [ :child | child installSkinRecursively ].
	self installSkin
]

{ #category : #'*Toplo' }
BlElement >> isDisabled [

	^ self isFlaggedAsDisabled
]

{ #category : #'*Toplo' }
BlElement >> isEnabled [

	^ self isFlaggedAsEnabled 
]

{ #category : #'*Toplo' }
BlElement >> isFlaggedAsDisabled [

	^ self isFlaggedAsEnabled not
]

{ #category : #'*Toplo' }
BlElement >> isFlaggedAsEnabled [

	^ self userData at: #enabled ifAbsentPut: [ true ]
]

{ #category : #'*Toplo' }
BlElement >> localStyleSheet [

	^ self userData at: #localStyleSheet ifAbsent: [  ]
]

{ #category : #'*Toplo' }
BlElement >> localStyleSheet: aStyleSheet [

	| prev |
	prev := self userData at: #localStyleSheet ifAbsent: [  ].
	prev ifNotNil: [ prev onUnInstalledIn: self ].
	self userData at: #localStyleSheet put: aStyleSheet.
	aStyleSheet ifNotNil: [ aStyleSheet onInstalledIn: self ]
]

{ #category : #'*Toplo' }
BlElement >> localStyleStampIndex [

	^ self userData at: #localStyleStampIndex ifAbsent: [ ]
]

{ #category : #'*Toplo' }
BlElement >> localStyleStampNamed: aSymbol [

	| index |
	index := self localStyleStampIndex ifNil: [ ^ nil ].
	^ index propertyNamed: aSymbol ifAbsent: [  ]
	
]

{ #category : #'*Toplo' }
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

{ #category : #'*Toplo' }
BlElement >> openInInnerWindow [

	| frame |
	frame := ToInnerWindow new.
	frame pane addChild: self.
	frame openInSpace
]

{ #category : #'*Toplo' }
BlElement >> privateSkin [

	^ self userData at: #privateSkin ifAbsent: [  ]
]

{ #category : #'*Toplo' }
BlElement >> privateSkin: aSkin [

	self privateSkin = aSkin ifTrue: [ ^ self ].
	self userData at: #privateSkin put: aSkin
]

{ #category : #'*Toplo' }
BlElement >> privateToTheme [

	^ self userData at: #privateToTheme ifAbsent: [  ]
]

{ #category : #'*Toplo' }
BlElement >> privateToTheme: aTheme [

	self userData at: #privateToTheme put: aTheme
]

{ #category : #'*Toplo' }
BlElement >> rawSkin [

	^  ToRawSkin new
]

{ #category : #'*Toplo' }
BlElement >> reinstallMySkin [

	self privateSkin ifNotNil: [ :s |
		self skinInstaller: (ToExplicitSkinInstaller new skin: s).
		self installSkin: nil ]
]

{ #category : #'*Toplo' }
BlElement >> removeAllStyleStamps [

	| index |
	index := self localStyleStampIndex ifNil: [ ^ self ].
	index removeAllProperties 
]

{ #category : #'*Toplo' }
BlElement >> removeAllStyleStamps: aStyleStampCollection [

	| index |
	index := self localStyleStampIndex ifNil: [ ^ self ].
	aStyleStampCollection do: [ :s | index removeProperty: s ]
]

{ #category : #'*Toplo' }
BlElement >> removeStyleStamp: aStyleStamp [

	| index |
	index := self localStyleStampIndex ifNil: [ ^ self ].
	index removeProperty: aStyleStamp
]

{ #category : #'*Toplo' }
BlElement >> removeStyleStampNamed: aSymbol [

	| index |
	index := self localStyleStampIndex ifNil: [ ^ self ].
	index removePropertyNamed: aSymbol
]

{ #category : #'*Toplo' }
BlElement >> removeStyleStampNamed: aSymbol ifAbsent: anAbsentBlock [

	| index |
	index := self localStyleStampIndex ifNil: [ ^ self ].
	index removePropertyNamed: aSymbol ifAbsent: anAbsentBlock
]

{ #category : #'*Toplo' }
BlElement >> skinBuilder [

	^ self toTheme skinBuilder
]

{ #category : #'*Toplo' }
BlElement >> skinDo: aBlock [

	self privateSkin ifNil: [ ^ self ].
	aBlock value: self privateSkin
]

{ #category : #'*Toplo' }
BlElement >> skinInstaller [

	^ self userData at: #skinInstaller ifAbsent: [  ]
]

{ #category : #'*Toplo' }
BlElement >> skinInstaller: aSkinInstaller [

	self userData at: #skinInstaller put: aSkinInstaller
]

{ #category : #'*Toplo' }
BlElement >> stampNamed: aSymbol [

	(self lookUpStyleStampNamed: aSymbol) ifNotNil: [ :s | ^ s ].
	(ToElementPropertyNotFound name: aSymbol) signal
]

{ #category : #'*Toplo' }
BlElement >> stampValue: aSymbol [

	(self lookUpStyleStampNamed: aSymbol) ifNotNil: [ :s | ^ s value ].
	(ToElementPropertyNotFound name: aSymbol) signal
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> styleSheet [

	^ self localStyleSheet
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> styleSheet: aStyleSheet [

	self localStyleSheet = aStyleSheet ifTrue: [ ^ self ].
	self localStyleSheet: aStyleSheet.
	self toThemeChanged.

]

{ #category : #'*Toplo-LookAndFeel' }
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

{ #category : #'*Toplo' }
BlElement >> switchToSkinState: aState [

	self currentSkinState: aState.
	aState applyOn: self
]

{ #category : #'*Toplo' }
BlElement >> textAttributesBuilder [

	^ self userData at: #textAttributesBuilder ifAbsentPut: [ BlTextAttributesBuilder new ]
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toTheme [

	^ self privateToTheme ifNil: [
		  self hasParent
			  ifTrue: [ self parent toTheme ]
			  ifFalse: [
				  self isAttachedToSceneGraph
					  ifTrue: [ " install the theme only if the root is attached to 
						avoid default installation in another element that the space root"
						  self privateToTheme: ToStyleSheetTheme current.
						  self privateToTheme ]
					  ifFalse: [ ToTheme current ] ] ]
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toTheme: aTheme [

	self privateToTheme = aTheme ifTrue: [ ^ self ].
	self privateToTheme: aTheme.
	self toThemeChanged.

]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toThemeChanged [

	self dispatchEvent: ToThemeChangedEvent new.
	self childrenDo: [ :c | c toThemeChanged ].


]

{ #category : #'*Toplo' }
BlElement >> updateDefaultSkin [

	self installSkin: self defaultSkin
]

{ #category : #'*Toplo' }
BlElement >> withAllStamps: aCollectionOfSymbol [

	aCollectionOfSymbol ifEmpty: [ ^ self ].
	aCollectionOfSymbol do: [ :s | self withStamp: s ]
]

{ #category : #'*Toplo' }
BlElement >> withStamp: anAssociationOrSymbol [

	self ensureLocalStyleStampIndex.
	self addStyleStamp: anAssociationOrSymbol asStyleStamp
]

{ #category : #'*Toplo' }
BlElement >> withoutAllStamps [

	self removeAllStyleStamps
]

{ #category : #'*Toplo' }
BlElement >> withoutSkin [

	self privateSkin ifNotNil: [ :s |
		self removeEventHandler: s.
		self privateSkin: nil ]
]

{ #category : #'*Toplo' }
BlElement >> withoutStamp: aSymbol [

	self removeStyleStampNamed: aSymbol ifAbsent: [  ]
]
