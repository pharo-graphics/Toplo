Extension { #name : #TToDressable }

{ #category : #'*Toplo-LookAndFeel' }
TToDressable >> setSkinForType: aType [

	self skin: (self toTheme class skinFor: (self class) type: aType)
]

{ #category : #'*Toplo-LookAndFeel' }
TToDressable >> skin [

	^ skin ifNil:[ self dresser ifNotNil:[ :e | (e respondsTo: #skin) ifTrue:[ e perform: #skin ] ifFalse:[ nil ] ] ]
]

{ #category : #'*Toplo-LookAndFeel' }
TToDressable >> skin: aSkin [

	(skin isNil or:[ skin class ~= aSkin class or:[skin type ~= aSkin type]]) ifFalse:[ ^ self ].
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

	(self skinType = aType and:[ self skin notNil ]) ifTrue:[ ^ self ].
	skinType := aType.
	
	self toTheme ifNil:[ ^ self ].
	
	self dresser: (self toTheme class dresserFor: self).
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

	self dresserDo: [ :d | d launchUninstallationIn: self ].
	
	self childrenDo: [ :c | c toThemeChanged ].
	
	"Update the skin if theme hierarchy has changed"
	self setSkinForType: self skinType.
	
	self dresserDo: [ :d | d launchInstallationIn: self ].
]
