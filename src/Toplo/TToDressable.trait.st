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

{ #category : #'t - accessing dresser' }
TToDressable >> removeDresser: aDresser [

	self dresser = aDresser ifFalse: [ 
		self dresser removeDresser: aDresser in: self.
		^ self ].
	self dresser: aDresser next.
	aDresser next: ToNullDresser new.
	aDresser launchUninstallationIn: self
]

{ #category : #'t - accessing skin' }
TToDressable >> skin [

	^ skin ifNil:[ self dresser ifNotNil:[ :e | (e respondsTo: #skin) ifTrue:[ e perform: #skin ] ifFalse:[ nil ] ] ]
]

{ #category : #'t - accessing skin' }
TToDressable >> skin: aSkin [

	(skin isNil or:[ skin class ~= aSkin class or:[skin type ~= aSkin type]]) ifFalse:[ ^ self ].
	skin := aSkin.
	self skinChanged.
]

{ #category : #'t - accessing skin' }
TToDressable >> skinChanged [

	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self dresserDo: [ :d | d launchInstallationIn: self ]
]

{ #category : #'t - accessing skin' }
TToDressable >> skinType [

	^ skinType ifNil:[ ToAbstractSkin defaultType ]
]

{ #category : #'t - accessing skin' }
TToDressable >> skinType: aType [

	(self skinType = aType and:[ self skin notNil ]) ifTrue:[ ^ self ].
	skinType := aType.
	
	self toTheme ifNil:[ ^ self ].
	
	self dresser: (self toTheme class dresserFor: self).
	self skin: (self toTheme class skinFor: (self class) type: aType)
]

{ #category : #'t - accessing theme' }
TToDressable >> toTheme [

	^ self userData at: #ToTheme ifAbsent: [
		  self hasParent
			  ifTrue: [ self parent toTheme ]
			  ifFalse: [ ToAbstractTheme current ] 
	]
]

{ #category : #'t - accessing theme' }
TToDressable >> toTheme: aTheme [

	self userData at: #ToTheme put: aTheme.
	self toThemeChanged
]

{ #category : #'t - accessing theme' }
TToDressable >> toThemeChanged [

	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self dresserDo: [ :d | d launchInstallationIn: self ].
	
	self childrenDo: [ :c | c toThemeChanged ]
]

{ #category : #'t - accessing dresser' }
TToDressable >> undress [

	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self userData at: #dresser put: nil
]
