Extension { #name : #BlElement }

{ #category : #'*Toplo' }
BlElement >> addStyleTag: aSymbol [

	| cls |
	self userData at: #styleTags ifAbsentPut: #().
	cls := self userData at: #styleTags.
	(cls includes: aSymbol) ifTrue: [ ^ self ].
	self userData at: #styleTags put: (cls copyWith: aSymbol)
]

{ #category : #'*Toplo' }
BlElement >> addStyleTags: aCollection [

	aCollection do: [:t | self addStyleTag: t]
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

	self launchSkinInstallation.
	self childrenDo: [ :child | child checkSkinInstallation ]
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

	self dispatchEvent: anEvent.
	self childrenDo: [ :child | child dispatchLookEvent: anEvent ]
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
BlElement >> flagAsDisabled [

	self userData at: #enabled put: false
]

{ #category : #'*Toplo' }
BlElement >> flagAsEnabled [

	self userData at: #enabled put: true
]

{ #category : #'*Toplo' }
BlElement >> holder [

	^ self constraints infinite holder
]

{ #category : #'*Toplo' }
BlElement >> includesStyleTag: aSymbol [

	| cls |
	self userData at: #styleTags ifAbsent: [ ^ false ].
	cls := self userData at: #styleTags.
	^ cls includes: aSymbol
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
BlElement >> launchSkinInstallation [
	"Nothing to do at BlElement level to preserve efficienty"

	
]

{ #category : #'*Toplo' }
BlElement >> launchSkinUninstallation [

	"Nothing to do at BlElement level to preserve efficienty"

]

{ #category : #'*Toplo' }
BlElement >> localStyleSheet [

	^ self userData at: #localStyleSheet ifAbsent: [  ]
]

{ #category : #'*Toplo' }
BlElement >> localStyleSheet: aStyleSheet [

	self userData at: #localStyleSheet put: aStyleSheet
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
BlElement >> removeStyleTag: aSymbol [

	| cls |
	self userData at: #styleTags ifAbsentPut: #().
	cls := self userData at: #styleTags.
	(cls includes: aSymbol) ifFalse: [ ^ self ].
	self userData at: #styleTags put: (cls copyWithout: aSymbol)
]

{ #category : #'*Toplo' }
BlElement >> skinDo: aBlock [

	self privateSkin ifNil: [ ^ self ].
	aBlock value: self privateSkin
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
	^ Array streamContents: [ :str |
		  | current inherits |
		  current := self.
		  inherits := true.
		  [ current notNil and: [ inherits ] ] whileTrue: [
			  current localStyleSheet ifNotNil: [ :ss |
				  str nextPut: ss.
				  inherits := ss inherits ].
			  current := current parent ].
		  (self toTheme notNil and: [ inherits ]) ifTrue: [
			  str nextPut: self toTheme styleSheet ] ]
]

{ #category : #'*Toplo' }
BlElement >> styleSheetInterpreter [

	^ ToStyleSheetInterpreter new
]

{ #category : #'*Toplo' }
BlElement >> styleTag: aSymbol [

	self userData at: #styleTags put: (Array with: aSymbol)
]

{ #category : #'*Toplo' }
BlElement >> styleTags [

	^ self userData at: #styleTags ifAbsent: [ #() ]
]

{ #category : #'*Toplo' }
BlElement >> styleTags: aCollectionOfSymbol [

	self userData at: #styleTags put: #().
	aCollectionOfSymbol do: [ :s | self addStyleTag: s ]
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
					  ifTrue: [ " install the theme only if the root is visible to 
						avoid default installation in another element that the space root"
						  self privateToTheme: ToAbstractTheme current.
						  self privateToTheme ]
					  ifFalse: [ ToAbstractTheme current ] ] ]
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
BlElement >> updateSkin [


]

{ #category : #'*Toplo' }
BlElement >> withSkin: aSkin [

	self privateSkin ifNotNil: [ :s |
		self removeEventHandler: s ].
	self privateSkin: aSkin.
	self privateSkin ifNotNil: [ :s |
		self addEventHandler: s.
		self dispatchSkinChangedEvent ]
]

{ #category : #'*Toplo' }
BlElement >> withoutSkin [

	self privateSkin ifNotNil: [ :s |
		self removeEventHandler: s.
		self privateSkin: nil ]
]
