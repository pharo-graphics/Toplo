Extension { #name : #TToDressable }

{ #category : #'*Toplo-LookAndFeel' }
TToDressable >> setSkinForType: aType [

	self toTheme ifNil: [ ^ self ].
	self skin: (self toTheme class skinFor: self class type: aType)
]

{ #category : #'*Toplo-LookAndFeel' }
TToDressable >> skin [

	^ skin ifNil:[ self dresser ifNotNil:[ :e | (e respondsTo: #skin) ifTrue:[ e perform: #skin ] ifFalse:[ nil ] ] ]
]

{ #category : #'*Toplo-LookAndFeel' }
TToDressable >> skin: aSkin [

	(skin isNil or:[ skin class ~= aSkin class or:[skin type ~= aSkin type]]) ifFalse:[ ^ self ].
	(skin isNil and:[aSkin isNil]) ifTrue:[ ^ self ].
	skin := aSkin.
	self skinChanged.
]

{ #category : #'*Toplo-LookAndFeel' }
TToDressable >> skinChanged [

	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self dresserDo: [ :d | d launchInstallationIn: self ]
]

{ #category : #'*Toplo-LookAndFeel' }
TToDressable >> skinType [

	^ skinType ifNil:[ ToAbstractSkin defaultType ]
]

{ #category : #'*Toplo-LookAndFeel' }
TToDressable >> skinType: aType [

	| newDresser |
	(self skinType = aType and:[ self skin notNil ]) ifTrue:[ ^ self ].
	skinType := aType.
	
	self toTheme ifNil:[ ^ self ].
	Toplo useLookAndFeel ifFalse: [ ^ self ].

	"Change dresser if necessary"
	newDresser := self toTheme class dresserFor: self.
	(self dresser notNil and:[newDresser class ~= self dresser class]) ifTrue:[self dresser: newDresser].
	
	self setSkinForType: aType.
]

{ #category : #'*Toplo-LookAndFeel' }
TToDressable >> toThemeChanged [

	self dispatchEvent: ToThemeChangedEvent new.
	self childrenDo: [ :c | c toThemeChanged ].
	Toplo useLookAndFeel ifFalse: [ ^ self ].
	
	self flag:'labordep : this code should be remove when look and feel pattern was ok, here we are forcing a skin type to install all Look and Feel dedicated dressers'.
	 
	"Update the skin if theme hierarchy has changed"
	(skinType isNil and:[self space notNil]) ifTrue:[ self skinType: ToAbstractSkin defaultType ].
	self setSkinForType: self skinType.
	
	"Force dresser rebuild"
	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self dresserDo: [ :d | d launchInstallationIn: self ].
]
