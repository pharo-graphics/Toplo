Trait {
	#name : #TToDressable,
	#instVars : [
		'skin',
		'skinType'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - dressable - accessing' }
TToDressable >> addDresser: aDresser [

	self dresser addDresser: aDresser in: self
]

{ #category : #'t - dressable -  initialization' }
TToDressable >> defaultDresser [

	^ ToNullDresser new
]

{ #category : #'t - dressable - accessing' }
TToDressable >> dresser [
	^ self userData at: #dresser ifAbsent: nil
]

{ #category : #'t - dressable - accessing' }
TToDressable >> dresser: aDresser [

	| currentDresser |
	currentDresser := self userData at: #dresser ifAbsent:[ nil ].
	(currentDresser notNil and:[ currentDresser = aDresser ]) ifTrue:[ ^ self ].

	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self userData at: #dresser put: aDresser.
	self dresserDo: [ :d | d launchInstallationIn: self ]
	
]

{ #category : #'t - dressable - accessing' }
TToDressable >> dresserDo: aBlock [

	self dresser ifNotNil: [ :d | aBlock cull: d ]
]

{ #category : #'t - dressable - accessing' }
TToDressable >> dresserSatisfying: aBlock [

	^ self dresser dresserSatisfying: aBlock
]

{ #category : #'t - dressable -  initialization' }
TToDressable >> initializeDresser [

	self dresser: self defaultDresser
]

{ #category : #'t - dressable -  initialization' }
TToDressable >> postInitializeDresser [
	"Called after dresser initialization"
	
]

{ #category : #'t - dressable -  initialization' }
TToDressable >> preInitializeDresser [
	"Called before dresser initialization"
	
]

{ #category : #'t - dressable - accessing' }
TToDressable >> removeDresser: aDresser [

	self dresser = aDresser ifFalse: [ 
		self dresser removeDresser: aDresser in: self.
		^ self ].
	self dresser: aDresser next.
	aDresser next: ToNullDresser new.
	aDresser launchUninstallationIn: self
]

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

{ #category : #'t - dressable - accessing' }
TToDressable >> undress [

	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self userData at: #dresser put: nil
]
