Trait {
	#name : #TToLAFDressable,
	#instVars : [
		'skin',
		'skinType'
	],
	#category : #'Toplo-LookAndFeel-Dressers'
}

{ #category : #'as yet unclassified' }
TToLAFDressable >> setSkinForType: aType [

	self toTheme ifNil: [ ^ self ].
	self skin: (self toTheme class skinFor: self class type: aType)
]

{ #category : #'as yet unclassified' }
TToLAFDressable >> skin [

	^ skin ifNil:[ self dresser ifNotNil:[ :e | (e respondsTo: #skin) ifTrue:[ e perform: #skin ] ifFalse:[ nil ] ] ]
]

{ #category : #'as yet unclassified' }
TToLAFDressable >> skin: aSkin [

	(skin isNil or:[ skin class ~= aSkin class or:[skin type ~= aSkin type]]) ifFalse:[ ^ self ].
	(skin isNil and:[aSkin isNil]) ifTrue:[ ^ self ].
	skin := aSkin.
	self skinChanged.
]

{ #category : #'as yet unclassified' }
TToLAFDressable >> skinChanged [

	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self dresserDo: [ :d | d launchInstallationIn: self ]
]

{ #category : #'as yet unclassified' }
TToLAFDressable >> skinType [

	^ skinType ifNil:[ ToLAFAbstractSkin defaultType ]
]

{ #category : #'as yet unclassified' }
TToLAFDressable >> skinType: aType [

	| newDresser |
	(self skinType = aType and:[ self skin notNil ]) ifTrue:[ ^ self ].
	skinType := aType.
	
	self toTheme ifNil:[ ^ self ].
	
	"Change dresser if necessary"
	newDresser := self toTheme class dresserFor: self.
	(self dresser notNil and:[newDresser class ~= self dresser class]) ifTrue:[self dresser: newDresser].
	
	self setSkinForType: aType.
]

{ #category : #'as yet unclassified' }
TToLAFDressable >> toThemeChanged [

	self dispatchEvent: ToThemeChangedEvent new.
	self childrenDo: [ :c | c toThemeChanged ].
	
	self flag:'labordep : this code should be remove when look and feel pattern was ok, here we are forcing a skin type to install all Look and Feel dedicated dressers'.
	 
	"Update the skin if theme hierarchy has changed"
	(skinType isNil and:[self space notNil]) ifTrue:[ self skinType: ToLAFAbstractSkin defaultType ].
	self setSkinForType: self skinType.
	
	"Force dresser rebuild"
	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self dresserDo: [ :d | d launchInstallationIn: self ].
]
