Trait {
	#name : #TToDressable,
	#instVars : [
		'skin',
		'skinType'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - accessing dresser' }
TToDressable >> addDresser: aDresser [

	self dresser addDresser: aDresser in: self
]

{ #category : #'t - initialization dresser' }
TToDressable >> defaultDresser [

	^ ToNullDresser new
]

{ #category : #'t - accessing dresser' }
TToDressable >> dresser [
	^ self userData at: #dresser ifAbsent: nil
]

{ #category : #'t - accessing dresser' }
TToDressable >> dresser: aDresser [

	| currentDresser |
	currentDresser := self userData at: #dresser ifAbsent:[ nil ].
	(currentDresser notNil and:[ currentDresser = aDresser ]) ifTrue:[ ^ self ].

	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self userData at: #dresser put: aDresser.
	self dresserDo: [ :d | d launchInstallationIn: self ]
	
]

{ #category : #'t - accessing dresser' }
TToDressable >> dresserDo: aBlock [

	self dresser ifNotNil: [ :d | aBlock cull: d ]
]

{ #category : #'t - accessing dresser' }
TToDressable >> dresserSatisfying: aBlock [

	^ self dresser dresserSatisfying: aBlock
]

{ #category : #'t - initialization dresser' }
TToDressable >> initializeDresser [

	self dresser: self defaultDresser
]

{ #category : #'t - initialization dresser' }
TToDressable >> postInitializeDresser [
	"Called after dresser initialization"
	
]

{ #category : #'t - initialization dresser' }
TToDressable >> preInitializeDresser [
	"Called before dresser initialization"
	
]

{ #category : #'t - accessing dresser' }
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
	
	"Change dresser if necessary"
	newDresser := self toTheme class dresserFor: self.
	(self dresser notNil and:[newDresser class ~= self dresser class]) ifTrue:[self dresser: newDresser].
	
	self setSkinForType: aType.
]

{ #category : #'*Toplo-LookAndFeel' }
TToDressable >> toTheme [

	^ self userData at: #ToTheme ifAbsent: [
		  self hasParent
			  ifTrue: [ self parent toTheme ]
			  ifFalse: [ ToAbstractTheme current ] 
	]
]

{ #category : #'*Toplo-LookAndFeel' }
TToDressable >> toTheme: aTheme [

	self userData at: #ToTheme put: aTheme.
	self toThemeChanged
]

{ #category : #'*Toplo-LookAndFeel' }
TToDressable >> toThemeChanged [

	self childrenDo: [ :c | c toThemeChanged ].
	 
	"Update the skin if theme hierarchy has changed"
	self flag:'labordep : this code should be remove when look and feel pattern was ok, here we are forcing a skin type to install all Look and Feel dedicated dressers'.
	(skinType isNil and:[self space notNil]) ifTrue:[ self skinType: ToAbstractSkin defaultType ].
	self setSkinForType: self skinType.
	
	"Force dresser rebuild"
	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self dresserDo: [ :d | d launchInstallationIn: self ].
]

{ #category : #'t - accessing dresser' }
TToDressable >> undress [

	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self userData at: #dresser put: nil
]
